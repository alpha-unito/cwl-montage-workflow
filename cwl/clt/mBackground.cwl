cwlVersion: v1.2
class: CommandLineTool
requirements: 
  InitialWorkDirRequirement:
    listing: 
      - entry: $(inputs.in_fits)
baseCommand: [ mBackground ]
arguments:
- position: 3
  valueFrom: "$(inputs.in_fits.basename)"
- position: 4
  valueFrom: "$(inputs.out_name).fits"
inputs:
  table_mode:
    type: boolean 
    inputBinding:
      position: 2
      prefix: -t
    default: true
  in_fits:
    type: File
  out_name: 
    type: string
  projected_tbl:
    type: File
    inputBinding:
      position: 5
  corrections_tbl:
    type: File
    inputBinding:
      position: 6
outputs:
  out_fits:
    type: File
    outputBinding:
      glob: "$(inputs.out_name).fits"
    secondaryFiles:
      - "$(inputs.out_name)_area.fits"