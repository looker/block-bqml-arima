#identifies time series values that deviate from the common behavior and patterns of the data


view: arima_detect_anomalies {
  label: "[9] BQML: Anomaly Detection"
  sql_table_name: ML.DETECT_ANOMALIES(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model_{{ _explore._name }}
  , STRUCT({% parameter set_anomaly_prob_threshold %} AS anomaly_prob_threshold))
  ;;


  parameter: set_anomaly_prob_threshold {
    label: "Anomaly Probability Threshold (optional)"
    description: "Set the anomaly probability threshold (value >= 0 and < 1). The default value is 0.95. The time-series data value at a specific timestamp is identified as anomalous if the anomaly probability exceeds the Anomaly Probability Threshold value."
    type: number
    default_value: "0.95"
  }

  dimension: time_series_raw {
    primary_key: yes
    hidden: yes
    type: date_raw
    sql: ${TABLE}.time_series_timestamp ;;
  }

  dimension: time_series_timestamp {
    group_label: "Time Series Date"
    group_item_label: "Time"
    type: date_time
    sql: ${TABLE}.time_series_timestamp ;;
  }

  dimension: time_series_date {
    group_label: "Time Series Date"
    group_item_label: "Date"
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
    description: "A time-series data value at a specific timestamp is identified as anomalous if the anomaly prediction exceeds the user-specified Anomaly Probability Threshold"
    sql: ${TABLE}.is_anomaly ;;
  }

  dimension: anomaly_probability {
    type: number
    description: "Indicates the probability that this point is an anomaly. For example, an anomaly_probability value of 0.95 means that, among all possible values at the given timestamp, there is a 95% chance that the value is closer to the predicted value than it is to the given time series data value. This indicates a 95% probability that the given time series data value is an anomaly."
    hidden: yes
    sql: ${TABLE}.anomaly_probability ;;
  }

  dimension: lower_bound {
    type: number
    hidden: yes
    sql: ${TABLE}.lower_bound ;;
  }

  dimension: upper_bound {
    type: number
    hidden: yes
    sql: ${TABLE}.upper_bound ;;
  }

  measure: total_time_series_data {
    type: sum
    sql: ${time_series_data} ;;
  }

  measure: anomaly_time_series_data {
    description: "Show time series data where is_anomaly = 'Yes' else leave null. Can add this to a time series line chart to plot/overlay the anomaly values (e.g., change series chart type to scatter)"
    type: number
    sql: sum(case when ${is_anomaly} then ${time_series_data} else null end) ;;
  }

  measure: max_anomaly_probability {
    type: max
    description: "Indicates the probability that a time-series data point is an anomaly. For example, an anomaly_probability value of 0.95 means that, among all possible values at the given timestamp, there is a 95% chance that the value is closer to the predicted value than it is to the given time series data value. This indicates a 95% probability that the given time series data value is an anomaly."
    sql: ${anomaly_probability} ;;
  }

  measure: min_anomaly_probability {
    type: min
    description: "Indicates the probability that a time-series data point is an anomaly. For example, an anomaly_probability value of 0.95 means that, among all possible values at the given timestamp, there is a 95% chance that the value is closer to the predicted value than it is to the given time series data value. This indicates a 95% probability that the given time series data value is an anomaly."
    sql: ${anomaly_probability} ;;
  }

  measure: min_lower_bound {
    type: min
    sql: ${lower_bound} ;;
  }

  measure: max_upper_bound {
    type: max
    sql: ${upper_bound} ;;
  }

  measure: anomaly_count {
    type: count
    description: "Number of Anomalies Found"
    filters: [is_anomaly: "Yes"]
  }



}
