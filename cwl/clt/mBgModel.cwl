cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ mBgModel ] 
arguments:
  - position: 5
    valueFrom: "$(inputs.out_name)"
inputs:
  images_tbl:
    type: File
    inputBinding:
      position: 3
  fits_tbl:
    type: File
    inputBinding:
      position: 4
  n_iter:
    type: int 
    inputBinding:
      position: 2
      prefix: -i
  out_name:
    type: string
outputs:
  corrections_tbl:
    type: File
    outputBinding:
      glob: "$(inputs.out_name)"
