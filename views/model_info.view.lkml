view: model_info {
  sql_table_name: @{looker_temp_dataset_name}.BQML_ARIMA_MODEL_INFO ;;

  dimension: model_name {
    suggest_persist_for: "0 minutes"
    primary_key: yes
    type: string
    sql: ${TABLE}.model_name ;;
  }

  dimension: time_column {
    type: string
    sql: ${TABLE}.time_column ;;
  }

  dimension: data_column {
    type: string
    sql: ${TABLE}.data_column ;;
  }

  dimension: horizon {
    type: number
    sql: ${TABLE}.horizon ;;
  }

  dimension: holiday_region {
    type: string
    sql: ${TABLE}.holiday_region ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [raw, time]
    sql: ${TABLE}.created_at ;;
  }

  dimension: explore {
    type: string
    sql: ${TABLE}.explore ;;
  }

  measure: count {
    type: count
    drill_fields: [model_name, created_at_time]
  }
}
