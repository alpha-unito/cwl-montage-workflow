cwlVersion: v1.2  
class: Workflow
inputs:
  data:
    type: 
      type: record
      fields:
        file: string
        url: string
outputs: 
  image: 
    type: File
    outputSource: extract/out_file
steps:
  download:
    run: clt/download.cwl 
    in:
      data: data 
    out: [ gz_file ]
  extract:
    run: clt/extract_gz.cwl 
    in:
      gz_file: download/gz_file
    out: [ out_file ]