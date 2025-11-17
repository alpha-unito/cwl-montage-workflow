cwlVersion: v1.2
class: CommandLineTool
requirements:
  NetworkAccess:
    networkAccess: true
baseCommand: [ mArchiveList ]
inputs:
  band:
    type:
      type: record
      fields:
        bid: int
        survey: 
          type: string
          inputBinding: 
            position: 1
        band:  
          type: string
          inputBinding: 
            position: 2
        color: string
  object_location:
    type: string 
    inputBinding:
      position: 3
  width:
    type: float 
    inputBinding:
      position: 4
  height:
    type: float 
    inputBinding:
      position: 5
  outfile:
    type: string 
    inputBinding:
      position: 6
outputs:
  images_tbl:
    type: File 
    outputBinding:
      glob: "$(inputs.outfile)"

