cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ "python", "generate.py" ]
hints:
  - class: DockerRequirement
    dockerPull: opencadc/astropy:3.9-slim
inputs:
  in_1_name: 
    type: string
    inputBinding:
      position: 1
  in_2_name: 
    type: string
    inputBinding:
      position: 2
  diff_tbl: 
    type: File
    inputBinding:
      position: 3
  prefix_project:
    type: string 
    inputBinding: 
      position: 4
    default: "p"
outputs:
  diff_name: string
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: 'generate.py' 
        entry: |
          import sys
          import json
          from astropy.io import ascii
          data = ascii.read(sys.argv[3])
          out = {}
          for row in data:
            if sys.argv[1] == f"{sys.argv[4]}{row['plus']}" and sys.argv[2] == f"{sys.argv[4]}{row['minus']}":
              out["diff_name"] = row["diff"]
              break
          if not out:
            out["diff_name"] = ""
          with open('cwl.output.json', 'w') as f:
            json.dump(out, f)




