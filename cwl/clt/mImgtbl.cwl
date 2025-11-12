cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ mImgtbl ]
inputs:
  in_dir:
    type: Directory
    inputBinding:
      position: 3
  out_name:
    type: string 
    inputBinding:
      position: 4
  imglist:
    type: File 
    inputBinding:
      position: 2
      prefix: -t
outputs:
  out_table:
    type: File 
    outputBinding:
      glob: "$(inputs.out_name)"

