cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ mDiffFit ]
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
stdout: mDiffFit.out
outputs:
  status_fits:
    type: File
    outputBinding:
      glob: "$(inputs.statusfile)"
  log_out: 
    type: stdout
  return_code:
    type: int
    outputBinding:
      outputEval: $(runtime.exitCode)
successCodes: [0, 1]
