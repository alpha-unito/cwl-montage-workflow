cwlVersion: v1.2 
class: Workflow
requirements:
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  center: string
  degrees: float
  bands: 
    type:
      type: array
      items:
        type: record
        fields:
          bid: int
          survey: string
          band: string
          color: string
  n_iter: int

outputs: 
  grey_pngs: 
    type: File[]
    outputSource: band/out_png

steps:
  regions:
    run: clt/generate_region.cwl
    in: 
      center: center
      degrees: degrees
    out: [region, region_oversized]
  band:
    run: band.cwl
    in:
      center: center
      degrees: degrees
      band: bands
      n_iter: n_iter
      region: regions/region
      region_oversized: regions/region_oversized
    out: [out_fits, out_png]
    scatter: band