view: arima_coefficients {
  label: "[8] BQML: ARIMA Coefficients"

  sql_table_name: ML.ARIMA_COEFFICIENTS(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model) ;;

  dimension: ar_coefficients {
    hidden: yes
  }

  dimension: ma_coefficients {
    hidden: yes
  }

  dimension: intercept_or_drift {
    type: number
    sql: ${TABLE}.intercept_or_drift ;;
  }

  measure: count {
    type: count
  }
}

view: ar_coefficients {
  label: "[8] BQML: ARIMA Coefficients"

  dimension: ar_coefficients {
    label: "AR Coefficients"
    type: number
    sql: ${TABLE} ;;
  }
}

view: ma_coefficients {
  label: "[8] BQML: ARIMA Coefficients"

  dimension: ma_coefficients {
    label: "MA Coefficients"
    type: number
    sql: ${TABLE} ;;
  }
}
