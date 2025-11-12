cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ mConcatFit ]
inputs:
  statfiles_tbl:
    type: File
    inputBinding:
      position: 1
  fits_tbl:
    type: string 
    inputBinding:
      position: 2
  statdir:
    type: Directory 
    inputBinding:
      position: 3
outputs:
  out_fits:
    type: File 
    outputBinding:
      glob: "$(inputs.fits_tbl)"

