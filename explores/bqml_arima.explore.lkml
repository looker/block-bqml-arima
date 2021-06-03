include: "/views/*.view"

explore: bqml_arima {
  extension: required
  view_name: model_name
  group_label: "Advanced Analytics with BQML"
  description: "Use this Explore to build and evaluate a BQML ARIMA Plus model"

  always_filter: {
    filters: [model_name.select_model_name: ""]
  }

  join: input_data {
    type: cross
    relationship: many_to_many
  }

  join: arima_training_data {
    sql:  ;;
    relationship: one_to_one
  }

  join: arima_create_model {
    sql:  ;;
    relationship: one_to_one
  }

  join: arima_evaluate {
    type: cross
    relationship: many_to_many
  }

  join: arima_forecast {
    type: cross
    relationship: many_to_many
  }

  join: arima_explain_forecast {
    type: full_outer
    sql_on: ${arima_forecast.forecast_raw} = ${arima_explain_forecast.time_series_raw} ;;
    relationship: one_to_one
  }

  join: arima_coefficients {
    type: cross
    relationship: many_to_many
  }

  join: ar_coefficients {
    sql: LEFT JOIN UNNEST(${arima_coefficients.ar_coefficients}) as ar_coefficients ;;
    relationship: one_to_many
  }

  join: ma_coefficients {
    sql: LEFT JOIN UNNEST(${arima_coefficients.ma_coefficients}) as ma_coefficients ;;
    relationship: one_to_many
  }
}
