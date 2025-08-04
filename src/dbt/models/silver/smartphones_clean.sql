select * from {{ ref('smartphones_source') }}
where BRAND_NAME is not null
  and MODEL is not null
