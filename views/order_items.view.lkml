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
  }
  dimension_group: shipped {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.shipped_at ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
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

measure: total_sale  {
  type:  sum
  sql: ${sale_price}* 1.2;;
  description: "Rev based on sale price"
  group_label: "Sales"
  label: "Revenue"
  value_format_name: usd_0
}
measure: average_sale {
  type: average
  sql:${sale_price};;
}

 #Task 1: Create a measure that calculates the distinct  number of order within the order_items view
  measure: distinct_orders {
    type: count_distinct
    sql: ${order_id} ;;
    description: "Number of unique orders"
  }
#Task 2: Create a measure that calculates total sales  (use the sale_price dimension)
  measure: total_sales {
    type: sum
    sql: ${sale_price} ;;
    description: "Total sales based on sale price"
    group_label: "Sales"
    value_format_name: usd_0
  }
#Task 3: Create a measure that calculates average sales  (use the sale_price dimension)
  measure: average_sales {
    type: average
    sql: ${sale_price} ;;
    description: "Average sale per order item"
    group_label: "Sales"
    value_format_name: usd_0
  }
#BONUS: Create a filtered measure that calculates the  total sales for only users that came to the website via  the Email traffic source [order_items view]
  measure: total_sales_email_users {
    type: sum
    sql: ${sale_price} ;;
    filters: [
      users.traffic_source: "Email"
    ]
    description: "Total sales for users via Email"
    group_label: "Sales"
    value_format_name: usd_0
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

 #Task 1: Create a filtered measure that calculates the  total sales for only users that came to the website via the Email traffic source [order_items view] - Done above
#Task 2: Create a field that calculates the percentage of  sales that are attributed to users coming from the email  traffic source [order_items view]
  measure: pct_sales_email_users {
    type: number
    sql:  ${total_sales_email_users} * 100.0  / ${total_sales} ;;
    description: "Percentage of total sales attributed to Email traffic users"
    value_format_name: percent_2
    group_label: "Sales"
  }
#Task 3: Calculate the average spend per user by  dividing the total sales measure by the user count  measure, and format the output so that it shows up in  USD
#creating unique users first
  measure: unique_users {
    type: count_distinct
    sql: ${user_id} ;;
    description: "Number of unique users"
  }


  measure: avg_spend_per_user {
    type: number
    sql: ${total_sales} / ${unique_users} ;;
    description: "Average spend per user"
    value_format_name: usd_0
    group_label: "Sales"
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
