view: arima_forecast {
  label: "[7] BQML: Forecast"

  sql_table_name: ML.FORECAST(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model,
    STRUCT({% parameter set_horizon %} AS horizon, {% parameter set_confidence_level %} AS confidence_level)) ;;

  parameter: set_horizon {
    label: "Forecast Horizon (optional)"
    description: "Choose the number of time points to forecast. The default value is 1,000. The maximum value is the number specified when you created your model."
    type: number
    default_value: "1000"
  }

  parameter: set_confidence_level {
    label: "Confidence Level (optional)"
    description: "The percentage of the future values that fall in the prediction interval. The default value is 0.95. The valid input range is [0, 1)."
    type: number
    default_value: "0.95"
  }


  dimension: pk {
    primary_key: yes
    hidden: yes
    type: date_raw
    sql: ${TABLE}.forecast_timestamp ;;
  }

  dimension_group: forecast {
    type: time
    timeframes: [raw, time, date, week, month, year]
    sql: ${TABLE}.forecast_timestamp ;;
    convert_tz: no
  }

  dimension: forecast_value {
    hidden: yes
    type: number
    sql: ${TABLE}.forecast_value ;;
  }

  dimension: standard_error {
    type: number
    sql: ${TABLE}.standard_error ;;
  }

  dimension: confidence_level {
    type: number
    sql: ${TABLE}.confidence_level ;;
  }

  dimension: prediction_interval_lower_bound {
    hidden: yes
    type: number
    sql: ${TABLE}.prediction_interval_lower_bound ;;
  }

  dimension: prediction_interval_upper_bound {
    hidden: yes
    type: number
    sql: ${TABLE}.prediction_interval_upper_bound ;;
  }

  measure: forecast_count {
    label: "Count of Forecasts"
    type: count
  }

  measure: total_forecast {
    type: sum
    sql: ${forecast_value} ;;
    value_format_name: decimal_4
  }

  measure: total_prediction_interval_lower_bound {
    type: sum
    sql: ${prediction_interval_lower_bound} ;;
    value_format_name: decimal_4
  }

  measure: total_prediction_interval_upper_bound {
    type: sum
    sql: ${prediction_interval_upper_bound} ;;
    value_format_name: decimal_4
  }
}
