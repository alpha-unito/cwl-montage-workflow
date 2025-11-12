cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ mProject ]
arguments:
  - position: 4
    valueFrom: "$(inputs.out_name).fits"
inputs:
  in_fits:
    type: File
    inputBinding:
      position: 3
  out_name:
    type: string
  extended:
    type: boolean
    default: true
    inputBinding: 
      position: 2
      valueFrom: -X
  template:
    type: File
    inputBinding:
      position: 5
outputs:
  out_fits:
    type: File
    outputBinding:
      glob: "$(inputs.out_name).fits"
    secondaryFiles:
      - "$(inputs.out_name)_area.fits"
