WITH dim_smartphones AS (
    SELECT
        md5(concat(BRAND_NAME, MODEL)) AS smartphone_key
    FROM {{ ref('gold_dim_smartphones') }}
)

SELECT
    ds.smartphone_key,
    sc.PRICE,
    sc.RATING
FROM {{ ref('silver_smartphones_clean') }} sc
JOIN dim_smartphones ds
    ON md5(concat(sc.BRAND_NAME, sc.MODEL)) = ds.smartphone_key