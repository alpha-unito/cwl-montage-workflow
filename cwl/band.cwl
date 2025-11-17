cwlVersion: v1.2  
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}

inputs:
  center: string
  degrees: float
  n_iter: int
  band:
    type:
      type: record
      fields:
        bid: int
        survey: string
        band: string
        color: string
  region: File
  region_oversized: File

outputs: 
  out_fits: 
    type: File 
    outputSource: mAdd/out_fits
  out_png: 
    type: File
    outputSource: mViewer/out_png
steps:
  mArchiveList:
    run: clt/mArchiveList.cwl
    in:
      band: band
      object_location: center
      degrees: degrees
      width: 
        valueFrom: "$(inputs.degrees * 1.42)" 
      height: 
        valueFrom: "$(inputs.degrees * 1.42)" 
      outfile:
        valueFrom: "$(inputs.band.bid)-images.tbl"
    out: [ images_tbl ]

  mDAGTbls:
    run: clt/mDAGTbls.cwl
    in:
      images_tbl: mArchiveList/images_tbl
      region: region_oversized
      band: band
      band_id:
        valueFrom: "$(inputs.band.bid)"
    out: [ raw_tbl, projected_tbl, corrected_tbl ]
  
  mOverlaps:
    run: clt/mOverlaps.cwl
    in:
      raw_tbl: mDAGTbls/raw_tbl
      band: band
      band_id:
        valueFrom: "$(inputs.band.bid)"
    out: [ diff_tbl ]

  generate_statfile:
    run: clt/generate_statfile.cwl 
    in:
      diff_tbl: mOverlaps/diff_tbl
      band: band
      band_id:
        valueFrom: "$(inputs.band.bid)"
    out: [ statfile ]

  retrieve_urls:
    run: clt/retrieve_urls.cwl
    in: 
      images_tbl: mArchiveList/images_tbl
    out: [ urls ]

  mArchiveGet:
    run: clt/mArchiveGet.cwl 
    in:
      data: retrieve_urls/urls 
    out: [ image_fits ]
    scatter: data 

  mProject:
    run: clt/mProject.cwl
    in:
      template: region_oversized
      in_fits: mArchiveGet/image_fits
      out_name:
        valueFrom: "p$(inputs.in_fits.nameroot)"
    out: [out_fits]
    scatter: in_fits

  wdiff:
    in:
      band: band
      band_id:
        valueFrom: "$(inputs.band.bid)"
      in_1_fits: mProject/out_fits
      in_2_fits: mProject/out_fits
      diff_tbl: mOverlaps/diff_tbl
      region_oversized: region_oversized
    out: [status_fits]
    run: 
      class: Workflow
      inputs:
        band_id: int
        in_1_fits: File[]
        in_2_fits: File[]
        diff_tbl: File
        region_oversized: File
      outputs:
        status_fits:
          type: File[]
          outputSource: diff/status_fits
          pickValue: all_non_null
      steps:
        diff:
          run: diff.cwl
          in:
            band_id: band_id
            in_1_fits: in_1_fits
            in_2_fits: in_1_fits
            diff_tbl: diff_tbl
            region_oversized: region_oversized
          out: [status_fits]
          scatter: [in_1_fits,in_2_fits]
          scatterMethod: flat_crossproduct

  mConcatFit:
    run: clt/mConcatFit.cwl
    in:
      statfiles_tbl: generate_statfile/statfile
      band: band 
      fits_tbl: 
        valueFrom: "$(inputs.band.bid)-fits.tbl"
      statutes: wdiff/status_fits
      statdir: 
        valueFrom: "${return {'class': 'Directory', 'basename': 'data', 'listing': inputs.statutes}}"
    out: [ out_fits ]

  mBgModel:
    run: clt/mBgModel.cwl 
    in:
      images_tbl: mArchiveList/images_tbl
      fits_tbl: mConcatFit/out_fits
      n_iter: n_iter
      band: band
      out_name:
        valueFrom: "$(inputs.band.bid)-corrections.tbl"
    out: [corrections_tbl]

  mBackground:
    run: clt/mBackground.cwl
    in:
      in_fits: mProject/out_fits
      out_name: 
        valueFrom: "c$(inputs.in_fits.nameroot.substring(1))"
      projected_tbl: mDAGTbls/projected_tbl
      corrections_tbl: mBgModel/corrections_tbl
    out: [out_fits]
    scatter: in_fits
  
  mImgtbl:
    run: clt/mImgtbl.cwl
    in: 
      cfits: mBackground/out_fits
      in_dir: 
        valueFrom: "${return {'class': 'Directory', 'basename': 'data', 'listing': inputs.cfits}}"
      out_name: 
        valueFrom: "$(inputs.band.bid)-updated.corrected.tbl"
      band: band 
      imglist: mDAGTbls/corrected_tbl
    out: [out_table]

  mAdd:
    run: clt/mAdd.cwl
    in:
      image: mImgtbl/out_table
      template: region
      band: band
      out_name: 
        valueFrom: "$(inputs.band.bid)-mosaic"
      in_fits: mBackground/out_fits
    out: [out_fits]

  mViewer:
    run: clt/mViewer.cwl 
    in:
      color_table:
        default: 1
      gray_file: mAdd/out_fits
      gray_min_range:
        default: "-1s"
      gray_max_range:
        default: "max"
      gray_distribution:
        default: "gaussian"
      png_out_name:
        valueFrom: "$(inputs.gray_file.nameroot).png"
    out: [out_png]
