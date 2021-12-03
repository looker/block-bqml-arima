view: arima_detect_anomalies {
  label: "[9] BQML: Anomaly Detection"
  sql_table_name: @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_detect_anomalies_{{ _explore._name }} ;;


  # parameter: set_anomaly_prob_threshold {
  #   label: "Anomaly Probability Threshold (optional)"
  #   description: "Set the anomaly probability threshold (value >= 0 and < 1). The default value is 0.95. The actual time-series data value at a specific timestamp is identified as anomalous if the anomaly probability exceeds the Anomaly Probability Threshold value."
  #   type: number
  #   default_value: "0.95"
  # }

  dimension: time_series_timestamp {
    primary_key: yes
    hidden: yes
    type: date_raw
    sql: ${TABLE}.time_series_timestamp ;;
  }


  dimension: time_series_date {
    type: date
    sql: ${TABLE}.time_series_timestamp ;;
    datatype: timestamp
    convert_tz: no
  }

  dimension: time_series_data {
    type: number
    hidden: yes
    sql: ${TABLE}.time_series_data ;;

  }

  dimension: is_anomaly {
    type: yesno
    sql: ${TABLE}.is_anomaly ;;
  }

  dimension: anomaly_probability {
    type: number
    sql: ${TABLE}.anomaly_probability ;;
  }

  dimension: lower_bound {
    type: number
    sql: ${TABLE}.lower_bound ;;
  }

  dimension: upper_bound {
    type: number
    sql: ${TABLE}.upper_bound ;;
  }

  measure: total_time_series_data {
    type: sum
    sql: ${time_series_data} ;;
  }

  measure: anomaly_time_series_data {
    type: max
    sql: ${time_series_data} ;;
    filters: [is_anomaly: "Yes"]
  }

  measure: count {
    type: count
  }

}
