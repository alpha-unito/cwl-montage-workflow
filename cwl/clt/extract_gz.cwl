cwlVersion: v1.2
class: CommandLineTool
requirements: 
  InitialWorkDirRequirement:
    listing: 
      - entry: $(inputs.gz_file)
        writable: true
baseCommand: [gzip]
inputs:
  gz_file:
    type: File
    inputBinding:
      position: 1     
      prefix: -d
      valueFrom: $(self.basename)
outputs:
  out_file:
    type: File 
    outputBinding:
      glob: "$(inputs.gz_file.nameroot)"

