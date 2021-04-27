view: arima_explain_forecast {
  label: "[8] BQML: Forecast"

  sql_table_name: ML.EXPLAIN_FORECAST(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model,
                    STRUCT({% parameter set_horizon %} AS horizon, {% parameter set_confidence_level %} AS confidence_level)) ;;

  parameter: set_horizon {
    label: "Forecast Horizon (optional)"
    description: "Choose the number of time points to forecast. The default value is 3. The maximum value is the number specified when you created your model."
    type: number
    default_value: "3"
  }

  parameter: set_confidence_level {
    label: "Confidence Level (optional)"
    description: "The percentage of the future values that fall in the prediction interval. The default value is 0.95. The valid input range is [0, 1)."
    type: number
    default_value: "0.95"
  }

  dimension_group: time_series {
    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.time_series_timestamp ;;
    convert_tz: no
  }

  dimension: time_series_type {
    type: string
    sql: ${TABLE}.time_series_type ;;
  }

  dimension: time_series_data {
    type: number
    sql: ${TABLE}.time_series_data ;;
  }

  dimension: time_series_adjusted_data {
    type: number
    sql: ${TABLE}.time_series_adjusted_data ;;
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
    type: number
    sql: ${TABLE}.prediction_interval_lower_bound ;;
  }

  dimension: prediction_interval_upper_bound {
    type: number
    sql: ${TABLE}.prediction_interval_upper_bound ;;
  }

  dimension: trend {
    type: number
    sql: ${TABLE}.trend ;;
  }

  dimension: seasonal_period_yearly {
    type: number
    sql: ${TABLE}.seasonal_period_yearly ;;
  }

  dimension: seasonal_period_quarterly {
    type: number
    sql: ${TABLE}.seasonal_period_quarterly ;;
  }

  dimension: seasonal_period_monthly {
    type: number
    sql: ${TABLE}.seasonal_period_monthly ;;
  }

  dimension: seasonal_period_weekly {
    type: number
    sql: ${TABLE}.seasonal_period_weekly ;;
  }

  dimension: seasonal_period_daily {
    type: number
    sql: ${TABLE}.seasonal_period_daily ;;
  }

  dimension: holiday_effect {
    type: number
    sql: ${TABLE}.holiday_effect ;;
  }

  dimension: spikes_and_dips {
    type: number
    sql: ${TABLE}.spikes_and_dips ;;
  }

  dimension: step_changes {
    type: number
    sql: ${TABLE}.step_changes ;;
  }

  measure: count {
    type: count
  }

}
