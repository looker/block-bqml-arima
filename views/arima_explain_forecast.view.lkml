view: arima_explain_forecast {
  label: "[7] BQML: Forecast"

  sql_table_name: ML.EXPLAIN_FORECAST(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model,
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
    sql: ${TABLE}.time_series_timestamp ;;
  }

  dimension_group: time_series {
    type: time
    timeframes: [raw, time, date, week, month, year]
    sql: ${TABLE}.time_series_timestamp ;;
    convert_tz: no
  }

  dimension: time_series_type {
    type: string
    sql: ${TABLE}.time_series_type ;;
  }

  dimension: time_series_data {
    hidden: yes
    type: number
    sql: ${TABLE}.time_series_data ;;
  }

  dimension: time_series_adjusted_data {
    hidden: yes
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
    hidden: yes
    type: number
    sql: ${TABLE}.prediction_interval_lower_bound ;;
  }

  dimension: prediction_interval_upper_bound {
    hidden: yes
    type: number
    sql: ${TABLE}.prediction_interval_upper_bound ;;
  }

  dimension: trend {
    hidden: yes
    type: number
    sql: ${TABLE}.trend ;;
  }

  dimension: seasonal_period_yearly {
    hidden: yes
    type: number
    sql: ${TABLE}.seasonal_period_yearly ;;
  }

  dimension: seasonal_period_quarterly {
    hidden: yes
    type: number
    sql: ${TABLE}.seasonal_period_quarterly ;;
  }

  dimension: seasonal_period_monthly {
    hidden: yes
    type: number
    sql: ${TABLE}.seasonal_period_monthly ;;
  }

  dimension: seasonal_period_weekly {
    hidden: yes
    type: number
    sql: ${TABLE}.seasonal_period_weekly ;;
  }

  dimension: seasonal_period_daily {
    hidden: yes
    type: number
    sql: ${TABLE}.seasonal_period_daily ;;
  }

  dimension: holiday_effect {
    hidden: yes
    type: number
    sql: ${TABLE}.holiday_effect ;;
  }

  dimension: spikes_and_dips {
    hidden: yes
    type: number
    sql: ${TABLE}.spikes_and_dips ;;
  }

  dimension: step_changes {
    hidden: yes
    type: number
    sql: ${TABLE}.step_changes ;;
  }

  measure: count {
    type: count
  }

  measure: total_time_series_data {
    type: sum
    sql: ${time_series_data} ;;
    value_format_name: decimal_0
  }

  measure: total_time_series_adjusted_data {
    type: sum
    sql: ${time_series_adjusted_data} ;;
    value_format_name: decimal_0
  }

  measure: total_prediction_interval_lower_bound {
    type: number
    sql: SUM(${prediction_interval_lower_bound}) ;;
    value_format_name: decimal_0
  }

  measure: total_prediction_interval_upper_bound {
    type: number
    sql: SUM(${prediction_interval_upper_bound}) ;;
    value_format_name: decimal_0
  }

  measure: total_trend {
    type: sum
    sql: ${trend} ;;
    value_format_name: decimal_0
  }

  measure: total_seasonal_period_yearly {
    type: sum
    sql: ${seasonal_period_yearly} ;;
    value_format_name: decimal_0
  }

  measure: total_seasonal_period_quarterly {
    type: sum
    sql: ${seasonal_period_quarterly} ;;
    value_format_name: decimal_0
  }

  measure: total_seasonal_period_monthly {
    type: sum
    sql: ${seasonal_period_monthly} ;;
    value_format_name: decimal_0
  }

  measure: total_seasonal_period_weekly {
    type: sum
    sql: ${seasonal_period_weekly} ;;
    value_format_name: decimal_0
  }

  measure: total_seasonal_period_daily {
    type: sum
    sql: ${seasonal_period_daily} ;;
    value_format_name: decimal_0
  }

  measure: total_holiday_effect {
    type: sum
    sql: ${holiday_effect} ;;
    value_format_name: decimal_0
  }

  measure: total_spikes_and_dips {
    type: sum
    sql: ${spikes_and_dips} ;;
    value_format_name: decimal_0
  }

  measure: total_step_changes {
    type: sum
    sql: ${step_changes} ;;
    value_format_name: decimal_0
  }
}
