# If necessary, uncomment the line below to include explore_source.

# include: "training_viktoryia_krauchanka.model.lkml"

view: user_facts_ndt {
  derived_table: {
    explore_source: order_items {
      column: user_id { field: users.id }
      column: total_sales {}
      column: unique_orders_count {}
    }
  }
  dimension: user_id {
    primary_key: yes
    type: number
  }
  dimension: total_sales {
    value_format: "$0.00"
    type: number
  }
  dimension: unique_orders_count {
    type: number
  }

  measure: avg_total_sales {
    type: average
    sql:  ${total_sales} ;;
  }

  measure: avg_orders_count {
    type: average
    sql: ${unique_orders_count} ;;
  }
}
