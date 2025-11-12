cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ mOverlaps ]
arguments:
- position: 2
  valueFrom: "$(inputs.band_id)-diff.tbl"
inputs:
  raw_tbl: 
    type: File 
    inputBinding: 
        position: 1
  band_id: int 
outputs:
  diff_tbl:
    type: File
    outputBinding:
      glob: "$(inputs.band_id)-diff.tbl"
