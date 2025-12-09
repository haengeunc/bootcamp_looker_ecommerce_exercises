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
  dimension: DAYS_SINCE_SIGNUP {
    type:  number
    sql:  date_diff(current_Date(), ${created_date}, day ) ;;
  }
  dimension_group: since_signup {
    type:  duration
    sql_start: ${created_date} ;;
    sql_end: current_Date() ;;
     intervals: [day, week, month, quarter, year]
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
    type:  string
    # sql:  ${first_name} | " " | ${last_name} ;;
    sql: CONCAT (${first_name} ," ", ${last_name}) ;;
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
  dimension: city_state {
    type:  string
    sql:  CONCAT(${city}, " - ", ${state}) ;;
  }
  dimension: street_address {
    type: string
    sql: ${TABLE}.street_address ;;
  }
  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }
  dimension: has_email_traffic_source {
    type:  yesno
    sql: ${traffic_source} = "Email" ;;
  }
  dimension: user_geom {
    type: string
    sql: ${TABLE}.user_geom ;;
  }
  dimension: AGE_CLASSIFICATION {
    type: tier
    tiers:  [1 ,18, 25,50, 80] # Defines age brackets
    sql: ${age} ;;
    style: integer
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
  events.count,
  order_items.count,
  orders.count
  ]
  }

}
