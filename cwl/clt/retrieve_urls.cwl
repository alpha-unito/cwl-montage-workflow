cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ "python", "extract.py" ]
hints:
  - class: DockerRequirement
    dockerPull: opencadc/astropy:3.9-slim
inputs:
  images_tbl:
    type: File
    inputBinding:
      position: 1
outputs:
  urls:
    type: 
      type: array 
      items:
        type: record
        fields:
          file: string
          url: string
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: 'extract.py' 
        entry: |
          import sys
          import json
          from astropy.io import ascii
          data = []
          for row in ascii.read(sys.argv[1]):
            data.append({'file': row['file'], 'url': row['URL']})
          with open('cwl.output.json', 'w') as f:
              json.dump({"urls": data}, f)
    
    

