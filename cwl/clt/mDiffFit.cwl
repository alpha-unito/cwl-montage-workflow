cwlVersion: v1.2
class: CommandLineTool
requirements:
  ShellCommandRequirement: {}
baseCommand: [ mDiffFit ]
arguments:
- position: 8
  valueFrom: "|| true"
  shellQuote: false
inputs:
  in_1_fits:
    type: File
    inputBinding:
      position: 4
  in_2_fits:
    type: File
    inputBinding:
      position: 5
  out_name:
    type: string 
    inputBinding:
      position: 6
  template_hdr:
    type: File
    inputBinding:
      position: 7
  statusfile:
    type: string 
    inputBinding:
      position: 3
      prefix: -s
  debug:
    type: boolean 
    default: true
    inputBinding:
      position: 2
      prefix: -d
outputs:
  status_fits:
    type: File
    outputBinding:
      glob: "$(inputs.statusfile)"
