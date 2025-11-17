cwlVersion: v1.2
class: ExpressionTool
requirements:
  InlineJavascriptRequirement: {}
inputs:
  return_code:
    type: int
    default: 0
  log_out: 
    type: string
outputs: 
  is_valid:
    type: boolean
expression: |
  ${
    var is_valid = true;
    if (inputs.log_out.includes("[Images don't overlap]")) {
      is_valid = false;
    } else {
      throw new Error(inputs.log_out);
    }
    return { "is_valid": is_valid };
  }