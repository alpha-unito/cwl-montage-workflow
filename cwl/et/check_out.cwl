cwlVersion: v1.2
class: ExpressionTool
requirements:
  InlineJavascriptRequirement: {}
inputs:
  return_code:
    type: int
  log_out: 
    type: File
    loadContents: true
outputs: 
  is_valid:
    type: boolean
expression: |
  ${
    var is_valid = true;
    if (inputs.log_out.contents.includes("[Images don't overlap]")) {
      is_valid = false;
    } else {
      throw new Error(inputs.log_out.contents);
    }
    return { "is_valid": is_valid };
  }