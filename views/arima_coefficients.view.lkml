view: arima_coefficients {
  label: "[5] BQML: Model Coefficients"

  sql_table_name: ML.ARIMA_COEFFICIENTS(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model) ;;

  dimension: ar_coefficients {
    type: number
    sql: ${TABLE}.ar_coefficients ;;
  }

  dimension: ma_coefficients {
    type: number
    sql: ${TABLE}.ma_coefficients ;;
  }

  dimension: intercept_or_drift {
    type: number
    sql: ${TABLE}.intercept_or_drift ;;
  }

  measure: count {
    type: count
  }

}
