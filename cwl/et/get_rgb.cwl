cwlVersion: v1.2
class: ExpressionTool
requirements:
  InlineJavascriptRequirement: {}
inputs:
  outs_fits: File[]
  bands: 
    type:
      type: array
      items:
        type: record
        fields:
          bid: int
          corrected_tbl: File
          diff_tbl: File
          projected_tbl: File
          statfile: File
          images_tbl: File
          images_fits: File[]
          color: string
outputs: 
  red: File 
  green: File
  blue: File
expression: |
  ${
    var red = null;
    var green = null;
    var blue = null;

    if (inputs.outs_fits.length !== inputs.bands.length) {
      throw new Error("Input lists must have the same length");
    }

    for (var i = 0; i < inputs.outs_fits.length; i++) {
      if (red === null && inputs.bands[i].color === "red") {
        red = inputs.outs_fits[i];
      } else if (green === null && inputs.bands[i].color === "green") {
        green = inputs.outs_fits[i];
      } else if (blue === null && inputs.bands[i].color === "blue") {
        blue = inputs.outs_fits[i];
      } else {
        throw new Error("Unexpected color " + inputs.bands[i].color + " at position " + i);
      }
    }

    return { "red": red, "green": green, "blue": blue };
  }