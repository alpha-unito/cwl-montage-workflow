cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ "python", "generate.py" ]
hints:
  - class: DockerRequirement
    dockerPull: opencadc/astropy:3.9-slim
inputs:
  diff_tbl:
    type: File
    inputBinding:
      position: 1
  band_id:
    type: int 
    inputBinding: 
      position: 2
outputs:
  statfile:
    type: File 
    outputBinding:
      glob: "$(inputs.band_id)-stat.tbl"
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: 'generate.py' 
        entry: |
          import re
          import sys
          from astropy.io import ascii
          t = ascii.read(sys.argv[1])
          band_id = sys.argv[2]
          # make sure we have a wide enough column
          t['stat'] = ' '*66
          for row in t:
              base_name = re.sub('(diff\.|\.fits.*)', '', row['diff'])
              row['stat'] = '%s-fit.%s.txt' %(band_id, base_name)
          ascii.write(t, '%s-stat.tbl' %(band_id), format='ipac')