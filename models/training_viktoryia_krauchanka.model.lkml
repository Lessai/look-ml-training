connection: "snowlooker"

# include all the views
include: "/views/**/*.view"

datagroup: order_items {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: order_items

explore: order_items {


  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id}  ;;
    relationship: many_to_one # root --> new table
  }

  join: user_facts {
    type: left_outer
    sql_on: ${users.id} = ${user_facts.user_id} ;;
    relationship: one_to_one
  }

  join: user_facts_ndt {
    type: left_outer
    sql_on: ${users.id} = ${user_facts_ndt.user_id} ;;
    relationship: one_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: brand_facts {
    type: left_outer
    sql_on: ${products.brand} = ${brand_facts.brand};;
    relationship: many_to_one
  }
}

explore: users {

}
