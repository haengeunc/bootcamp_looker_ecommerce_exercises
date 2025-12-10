view: products {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.products` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;

    link: {
      label: "Search on Google the brand {{ value }}"
      url: "https://www.google.com/search?q={{ value }}"
      icon_url: "http://www.google.com/s2/favicons?domain=www.looker.com"
    }

    link: {
      label: "See the detail dashboard for {{ value }}"
      url: "https://cntxtdeliveryteam.cloud.looker.com/dashboards/bootcamp_ecommerce::ecommerce_products_dashboard?Created+Month+Name=&Country=&Brand={{ value }}&Category="
    }

  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }
  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }
  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }
  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  name,
  distribution_centers.name,
  distribution_centers.id,
  inventory_items.count,
  order_items.count
  ]
  }

}
