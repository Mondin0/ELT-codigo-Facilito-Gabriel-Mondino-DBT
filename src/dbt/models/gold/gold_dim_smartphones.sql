SELECT DISTINCT
    md5(concat(BRAND_NAME, MODEL)) AS smartphone_key,  -- clave surrogate
    BRAND_NAME,
    MODEL,
    HAS_5G,
    HAS_NFC,
    HAS_IR_BLASTER,
    OS,
    PROCESSOR_BRAND,
    NUM_CORES,
    PROCESSOR_SPEED,
    BATTERY_CAPACITY,
    RAM_CAPACITY,
    SCREEN_SIZE,
    RESOLUTION_WIDTH,
    RESOLUTION_HEIGHT
FROM {{ ref('silver_smartphones_clean') }}