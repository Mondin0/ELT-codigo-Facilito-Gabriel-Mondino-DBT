select 
  BRAND_NAME,
  MODEL,
  PRICE,
  RATING,
  case 
    when HAS_5G in (true, 'true', 'TRUE', 1, '1') then true 
    else false 
  end as HAS_5G,
  case 
    when HAS_NFC in (true, 'true', 'TRUE', 1, '1') then true 
    else false 
  end as HAS_NFC,
  case 
    when HAS_IR_BLASTER in (true, 'true', 'TRUE', 1, '1') then true 
    else false 
  end as HAS_IR_BLASTER,
  PROCESSOR_BRAND,
  NUM_CORES,
  PROCESSOR_SPEED,
  BATTERY_CAPACITY,
  RAM_CAPACITY,
  case when OS = '' then null else OS end as OS,
  SCREEN_SIZE,
  RESOLUTION_WIDTH,
  RESOLUTION_HEIGHT
from {{ ref('bronze_smartphones_source') }}
where BRAND_NAME is not null
  and MODEL is not null
  and PRICE is not null
  and PRICE > 0
