view: user_facts {
  derived_table: {
    sql: SELECT order_items.user_id AS user_id,
      COUNT(DISTINCT order_items.order_id) as lifitime_order_count,
      SUM(order_items.sale_price) as lifitime_value
FROM "PUBLIC"."ORDER_ITEMS"
GROUP BY order_items.user_id
 ;;
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: lifitime_order_count {
    type: number
    sql: ${TABLE}."LIFITIME_ORDER_COUNT" ;;
  }

  dimension: lifitime_value {
    type: number
    sql: ${TABLE}."LIFITIME_VALUE" ;;
  }

  measure: avg_lifitime_order_count {
    type: average
    sql:  ${lifitime_order_count} ;;
  }

  measure: avg_lifitime_value {
    type: average
    sql: ${lifitime_value} ;;
    value_format_name: usd
  }
}
