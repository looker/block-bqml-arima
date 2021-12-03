include: "/explores/field_suggestions.explore"

view: arima_training_data {
  label: "[3] BQML: Select Training Data"

  parameter: select_time_column {
    label: "Select a Time Field (REQUIRED)"
    description: "Choose the field that indicates the date or time of the data you want to forecast"
    type: unquoted
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
  }

  parameter: select_data_column {
    label: "Select the Data Field (REQUIRED)"
    description: "Choose the field that contains the data you want to forecast"
    type: unquoted
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
  }


  parameter: set_anomaly_prob_threshold {
    label: "Anomaly Probability Threshold (optional)"
    description: "Set the anomaly probability threshold (value >= 0 and < 1). The default value is 0.95. The actual time-series data value at a specific timestamp is identified as anomalous if the anomaly probability exceeds the Anomaly Probability Threshold value."
    type: number
    default_value: "0.95"
  }
}
