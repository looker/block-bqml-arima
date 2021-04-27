include: "/views/*.view"

explore: bqml_arima {
  extension: required
  view_name: input_data
  group_label: "Advanced Analytics with BQML"
  description: "Use this Explore to build and evaluate a BQML ARIMA Plus model"

  always_filter: {
    filters: [model_name.select_model_name: ""]
  }

  join: model_name {
    sql:  ;;
    relationship: one_to_one
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

  join: arima_coefficients {
    type: cross
    relationship: many_to_many
  }

  join: arima_explain_forecast {
    type: full_outer
    relationship: one_to_one
    sql_on: ;;
  }

}
