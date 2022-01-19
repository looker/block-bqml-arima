view: arima_coefficients {
  label: "[7] BQML: ARIMA Coefficients"

  sql_table_name: ML.ARIMA_COEFFICIENTS(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model_{{ _explore._name }}) ;;

  # dimension: ar_coefficients {
  #   hidden: yes
  #   description: "The autoregressive coefficients, which correspond to non-seasonal p"
  #   sql: ${TABLE}.ar_coefficients;;
  # }

  dimension: ar_coefficients {
     label: "AR Coefficients"
    description: "The autoregressive coefficients, which correspond to non-seasonal p"
    sql: (select string_agg(cast(ar as string),', ') from unnest(${TABLE}.ar_coefficients) as ar);;
  }

  # dimension: ma_coefficients {
  #   hidden: yes
  #   description: "The moving-average coefficients, which correspond to non-seasonal q"
  #   sql: ${TABLE}.ma_coefficients ;;
  # }

  dimension: ma_coefficients {
    label: "MA Coefficients"
    description: "The moving-average coefficients, which correspond to non-seasonal q"
    sql: (select string_agg(cast(ma as string),', ') from unnest(${TABLE}.ma_coefficients) as ma) ;;
  }

  dimension: intercept_or_drift {
    type: number
    description: "Constant term in the ARIMA model"
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
    description: "The autoregressive coefficients, which correspond to non-seasonal p"
    type: number
    sql: ${TABLE} ;;
  }
}

view: ma_coefficients {
  label: "[8] BQML: ARIMA Coefficients"

  dimension: ma_coefficients {
    label: "MA Coefficients"
    description: "The moving-average coefficients, which correspond to non-seasonal q"
    type: number
    sql: ${TABLE} ;;
  }
}
