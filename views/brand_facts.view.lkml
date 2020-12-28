# If necessary, uncomment the line below to include explore_source.

# include: "training_viktoryia_krauchanka.model.lkml"

view: brand_facts {
  derived_table: {
    explore_source: order_items {
      column: brand { field: products.brand }
      column: total_sales {}
      derived_column: brand_rank{
        sql: row_number() over (order by total_sales desc) ;;
      }
      bind_all_filters: yes
    }
  }

  dimension: brand {
    type: string
    primary_key: yes
  }

  dimension: total_sales {
    value_format: "$0.00"
    type: number
  }

  dimension: brand_rank {
    type: number
  }

  dimension: is_first_five {
    type: yesno
    sql: ${brand_rank} <= 5 ;;
  }

  dimension: ranked_brands {
    type: string
    sql: case when ${is_first_five}
      then ${brand_rank} || ') ' || ${brand}
      else '6) Other' end
      ;;
  }

  measure: total_revenue{
    type: sum
    sql: ${total_sales} ;;
    value_format_name: usd
  }
}
