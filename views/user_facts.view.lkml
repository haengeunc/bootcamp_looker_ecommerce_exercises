
view: user_facts {
  derived_table: {
    explore_source: order_items {
      column: id { field: users.id }
      column: total_sales {}
    }
  }
  dimension: id {
    description: ""
    type: number
  }
  dimension: total_sales {
    description: ""
    value_format: "$#,##0"
    type: number
  }

  measure: avg_order_spend {
    type: average
    sql: ${total_sales} ;;
    value_format_name: usd
  }
}
