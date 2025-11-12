cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ mDAGTbls ]
arguments:
  - position: 3
    valueFrom: "$(inputs.band_id)-raw.tbl"
  - position: 3
    valueFrom: "$(inputs.band_id)-projected.tbl"
  - position: 3
    valueFrom: "$(inputs.band_id)-corrected.tbl"
inputs:
  images_tbl:
    type: File
    inputBinding:
      position: 1
  region:
    type: File 
    inputBinding:
      position: 2
  band_id:
    type: int
outputs:
  raw_tbl:
    type: File
    outputBinding:
      glob: "$(inputs.band_id)-raw.tbl"
  projected_tbl:
    type: File
    outputBinding:
      glob: "$(inputs.band_id)-projected.tbl"
  corrected_tbl:
    type: File
    outputBinding:
      glob: "$(inputs.band_id)-corrected.tbl"
