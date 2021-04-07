view: model_info {
  sql_table_name: looker_pdts.BQML_K_MEANS_MODEL_INFO ;;

  parameter: select_model_name {
    view_label: "1. Name Your Model"
    label: "BQML Model Name (REQUIRED)"
    description: "Enter a unique name to create a new BQML model or select an existing model to use in your analysis"
    type: unquoted
    suggest_explore: model_info
    suggest_dimension: model_info.model_name
    suggest_persist_for: "0 minutes"
  }

  dimension: model_name {
    suggest_persist_for: "0 minutes"
    primary_key: yes
    type: string
    sql: ${TABLE}.model_name ;;
  }

  dimension: number_of_clusters {
    type: string
    sql: ${TABLE}.number_of_clusters ;;
  }

  dimension: item_id {
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: features {
    type: string
    sql: ${TABLE}.features ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [raw, time]
    sql: ${TABLE}.created_at ;;
  }

  measure: count {
    type: count
    drill_fields: [model_name, created_at_time]
  }
}
