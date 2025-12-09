view: order_items {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.order_items` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: delivered {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.delivered_at ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
    synonyms: ["revenue", "income"]
  }





  dimension_group: shipped {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.shipped_at ;;
  }
  dimension: status {
    view_label: "Specific fields"
    type: string
    sql: ${TABLE}.status ;;
    #this is to show status
    tags: ["stat"]
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_sale {
    value_format_name: usd_0
    description: "Revenue based on sale price"
    group_label: "Sale"
    label: "Revenue"
    type: sum
    sql: ${sale_price} ;;

  }

  measure: jeans_total_sale {
    sql: ${sale_price} ;;
    type: sum
    filters: [products.category: "Jeans"]
  }

  measure: jeans_revenue_share {
    type: number
    sql: SAFE_DIVIDE(${jeans_total_sale} ,${total_sale}) ;;
    value_format_name: percent_1
  }

  measure: average_sale {
    type: average
    sql: ${sale_price} ;;
    group_label: "Sale"
    # value_format_name: sar
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.last_name,
  users.id,
  users.first_name,
  inventory_items.id,
  inventory_items.product_name,
  products.name,
  products.id,
  orders.order_id
  ]
  }

}
