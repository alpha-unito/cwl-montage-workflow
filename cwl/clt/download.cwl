cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ wget ]
inputs:
  data:
    type: 
      type: record
      fields:
        file: 
          type: string
          inputBinding:
            position: 2 
            prefix: -O
        url: 
          type: string
          inputBinding:
            position: 1
stdout: download.out
stderr: download.err
outputs:
  gz_file:
    type: File 
    outputBinding:
      glob: "$(inputs.data.file)"

