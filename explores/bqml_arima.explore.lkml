include: "/views/*.view"

explore: bqml_arima {
  extension: required
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
    relationship: one_to_one
  }

  join: arima_coefficients {
    type: cross
    relationship: one_to_one
  }


  # join: k_means_predict {
  #   type: left_outer
  #   sql_on: TRUE ;;
  #   relationship: one_to_one
  # }

}
