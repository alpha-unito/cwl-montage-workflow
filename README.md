# Montage Workflow - CWL Implementation

This repository contains a [Common Workflow Language](https://www.commonwl.org/) (CWL) implementation of the [Montage Workflow](https://github.com/pegasus-isi/montage-workflow-v3), initially implemented for the [Pegasus](https://pegasus.isi.edu/) v5.0 workflow management system.

## Usage

Running this workflow requires a [CWL runner](https://www.commonwl.org/implementations/). For example, the CWL reference implementation, called [cwltool](https://github.com/common-workflow-language/cwltool), can be installed as follows:

```bash
python3 -m venv venv
source venv/bin/activate
pip install cwlref-runner
```

You need Docker because some steps rely on images that contain essential tools, such as AstroPy.

Additionally, you must install the Montage tools and ensure they are available in your environment. Follow the [istructions](http://montage.ipac.caltech.edu/docs/download2.html) to install them.

The data is downloaded automatically during the workflow. If you wish to change the dataset, you can modify the config.json file. The current configuration is based on the example provided in the [Pegasus Montage workflow implementation](https://github.com/pegasus-isi/montage-workflow-v3).


Once all software and data dependencies are installed, the workflow can be launched using the following command:

```bash
cwl-runner main.cwl config.yml
```