view: users {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.users` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    # sql: ${first_name} | " " | ${last_name} ;;
    sql: CONCAT(${first_name}," " , ${last_name}) ;;
  }

  dimension: city_state {
    type: string
    # sql: ${first_name} | " " | ${last_name} ;;
    sql: CONCAT(${city}," " , ${state}) ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [18, 25, 50, 80]
    sql: ${age}
    style: integer;;
  }

  dimension: is_traffic_source_email {
    type: yesno
    sql: ${TABLE}.traffic_source = 'Email' ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }
  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }
  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }
  dimension: street_address {
    type: string
    sql: ${TABLE}.street_address ;;
  }
  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }
  dimension: user_geom {
    type: string
    sql: ${TABLE}.user_geom ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  last_name,
  first_name,
  full_name,
  city_state,
  events.count,
  order_items.count,
  orders.count
  ]
  }

}
