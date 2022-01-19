include: "/views/*.view"

explore: bqml_arima {
  extension: required
  view_name: model_name
  group_label: "Looker + BigQuery ML"
  description: "Use this Explore to build and evaluate a BQML ARIMA Plus model"
  persist_for: "0 minutes"

  always_filter: {
    filters: [model_name.select_model_name: ""]
  }

  join: input_data {
    type: cross
    relationship: one_to_many
  }

  join: arima_training_data {
    sql:  ;;
    relationship: many_to_one
  }

  join: arima_hyper_params {
    sql:  ;;
    relationship: many_to_one
  }

  join: arima_create_model {
    sql:  ;;
    relationship: many_to_one
  }

  join: arima_evaluate {
    type: cross
    relationship: many_to_many
  }

  ## type, sql_on an drelationship will be updated in the use case explore to define relationship
  ## between the input_data timestamp and  ${arima_explain_forecast.time_series_raw}
  join: arima_explain_forecast {
    type: full_outer
    relationship: many_to_many
  }

 ## type, sql_on and relationship will be updated in the use case explore to define relationship
 ## between the input_data timestamp and ${arima_detect_anomalies.time_series_raw}
  join: arima_detect_anomalies {
    type: left_outer
    relationship: one_to_one
  }

  join: arima_coefficients {
    type: cross
    relationship: many_to_many
  }

  # join: ar_coefficients {
  #   sql: LEFT JOIN UNNEST(${arima_coefficients.ar_coefficients}) as ar_coefficients ;;
  #   relationship: one_to_many
  # }

  # join: ma_coefficients {
  #   sql: LEFT JOIN UNNEST(${arima_coefficients.ma_coefficients}) as ma_coefficients ;;
  #   relationship: one_to_many
  # }
}
