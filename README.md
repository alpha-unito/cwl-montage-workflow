# Montage Workflow - CWL Implementation

This repository contains a [Common Workflow Language](https://www.commonwl.org/) (CWL) implementation of the [Montage Workflow](https://github.com/pegasus-isi/montage-workflow-v3), initially implemented for the [Pegasus](https://pegasus.isi.edu/) v5.0 workflow management system.

## Requirements

Before the workflow can be executed, the environment must meet the following requirements:
- **CWL Runner**: A [CWL runner](https://www.commonwl.org/implementations/) is required to execute the workflow. The reference implementation, `cwltool`, can be installed via pip:
  
```bash
python3 -m venv venv
source venv/bin/activate
pip install cwlref-runner
```

- **Docker**: Docker is required, as several steps rely on container images containing essential tools (e.g., [AstroPy](https://www.astropy.org/)).

- **Montage Tools**: The Montage toolkit must be installed, and the binaries must be available in the system path. [Download instructions](http://montage.ipac.caltech.edu/docs/download2.html) are available on the official website.

## Workflow Overview

The repository contains two primary workflows:

- [cwl/main_get_dataset.cwl](cwl/main_get_dataset.cwl): Downloads and prepares the necessary dataset.
- [cwl/main_montage.cwl](cwl/main_montage.cwl): The core Montage analysis workflow.

## Usage

### Dataset Generation

First, the `main_get_dataset.cwl` workflow is executed. This process generates the required data and creates the `config_montage.json` file, which is necessary for running the main analysis.

```bash
mkdir data
cwl-runner --outdir data cwl/main_get_dataset.cwl cwl/config_get_dataset.json
```

The dataset can be customized by modifying the `config_get_dataset.json` file. The current configuration is based on the example provided in the [Pegasus Montage workflow implementation](https://github.com/pegasus-isi/montage-workflow-v3).

### Montage Workflow Execution

Once the data is generated and dependencies are installed, the main workflow can be launched using the generated configuration file:

```bash
cwl-runner cwl/main_montage.cwl data/config_montage.json
```