cwlVersion: v1.2  
class: Workflow

inputs:
  band_id: int
  in_1_fits: File
  in_2_fits: File
  diff_tbl: File
  region_oversized: File
outputs: 
  status_fits: 
    type: File?
    outputSource: mDiffFit/status_fits
  is_valid:
    type: boolean
    outputSource: check_output/is_valid
steps:
  get_diff:
    run: clt/get_diff.cwl 
    in:
      in_1_fits: in_1_fits
      in_2_fits: in_2_fits
      in_1_name: 
        valueFrom: "$(inputs.in_1_fits.basename)"
      in_2_name: 
        valueFrom: "$(inputs.in_2_fits.basename)"
      diff_tbl: diff_tbl
    out: [diff_name]

  mDiffFit:
    run: clt/mDiffFit.cwl
    in:
      band_id: band_id
      in_1_fits: in_1_fits
      in_2_fits: in_2_fits
      diff_name: get_diff/diff_name
      out_name:
        valueFrom: "$(inputs.band_id)-$(inputs.diff_name)"
      template_hdr: region_oversized
      statusfile:
        valueFrom: "$(inputs.band_id)-fit.$(inputs.diff_name.replace(/(diff.|.fits)/g, '')).txt"
    when: "$(inputs.diff_name !== '')"
    out: [status_fits, log_out, return_code]

  check_output:
    run: et/check_out.cwl 
    in: 
      return_code: mDiffFit/return_code
      log_out: mDiffFit/log_out
    out: [is_valid]
    when: "$(Number.isInteger(inputs.return_code) && inputs.return_code !== 0)"