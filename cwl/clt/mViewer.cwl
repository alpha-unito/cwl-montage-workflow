cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ mViewer ]
inputs:
  color_table:
    type: int?
    inputBinding:
      position: 1
      prefix: -ct

  gray_file:
    type: File?
    inputBinding:
      position: 3
      prefix: -gray
  gray_min_range:
    type: string?
    inputBinding:
      position: 4
  gray_max_range:
    type: string?
    inputBinding:
      position: 5
  gray_distribution:
    type: string?
    inputBinding:
      position: 6
  
  red_file:
    type: File?
    inputBinding:
      position: 8
      prefix: -red
  red_min_range:
    type: string?
    inputBinding:
      position: 9
  red_max_range:
    type: string?
    inputBinding:
      position: 10
  red_distribution:
    type: string?
    inputBinding:
      position: 11

  blue_file:
    type: File?
    inputBinding:
      position: 13
      prefix: -blue
  blue_min_range:
    type: string?
    inputBinding:
      position: 14
  blue_max_range:
    type: string?
    inputBinding:
      position: 15
  blue_distribution:
    type: string?
    inputBinding:
      position: 16

  green_file:
    type: File?
    inputBinding:
      position: 18
      prefix: -green
  green_min_range:
    type: string?
    inputBinding:
      position: 19
  green_max_range:
    type: string?
    inputBinding:
      position: 20
  green_distribution:
    type: string?
    inputBinding:
      position: 21

  png_out_name:
    type: string 
    inputBinding:
      position: 22
      prefix: -png

outputs:
  out_png:
    type: File
    outputBinding:
      glob: "$(inputs.png_out_name)"
