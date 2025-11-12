cwlVersion: v1.2
class: CommandLineTool
requirements: 
  InitialWorkDirRequirement:
    listing: 
      - entry: $(inputs.in_fits)
baseCommand: [ mAdd ]
arguments:
- position: 4
  valueFrom: "$(inputs.out_name).fits"
inputs:
  exact_size:
    type: boolean
    default: true
    inputBinding:
      position: 1
      prefix: -e
  image:
    type: File
    inputBinding:
      position: 2
  template:
    type: File 
    inputBinding:
      position: 3
  out_name:
    type: string
  in_fits:
    type: File[]
outputs:
  out_fits:
    type: File
    outputBinding:
      glob: "$(inputs.out_name).fits"
    secondaryFiles:
      - "$(inputs.out_name)_area.fits"

