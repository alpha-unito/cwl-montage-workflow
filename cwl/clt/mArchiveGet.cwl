cwlVersion: v1.2
class: CommandLineTool
requirements:
  NetworkAccess:
    networkAccess: true
baseCommand: [ mArchiveGet ]
arguments:
- position: 2
  valueFrom: "$(inputs.data.file.replace(/.gz$/, ''))"

inputs:
  data:
    type: 
      type: record
      fields:
        file: 
          type: string
        url: 
          type: string
          inputBinding:
            position: 1
outputs:
  image_fits:
    type: File 
    outputBinding:
      glob: "$(inputs.data.file.replace(/.gz$/, ''))"

