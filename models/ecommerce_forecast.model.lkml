connection: "@{database_connection}"

include: "/explores/bqml_arima.explore"
include: "/use_case_refinements/ecommerce_forecast/*"


explore: ecommerce_forecast {
  label: "BQML ARIMA Plus: eCommerce Forecast"
  description: "Use this Explore to create BQML ARIMA Plus models to forecast various metrics using Looker's eCommerce dataset"

  extends: [bqml_arima]

  join: arima_forecast {
    type: full_outer
    relationship: one_to_one
    sql_on: ${input_data.created_date} = ${arima_forecast.forecast_date} ;;
  }

  query: create_model {
    label: "Create Model"
    description: "Important: Provide a unique name for your ML model"
    dimensions: [arima_create_model.train_model]
    filters: [model_name.select_model_name: "", arima_training_data.select_data_column: "\"total_revenue\""]
  }

  query: evaluate_model {
    label: "Evaluate Model"
    description: "Important: Specify model name from Create Model"
    dimensions: [
      arima_evaluate.aic,
      arima_evaluate.has_drift,
      arima_evaluate.has_holiday_effect,
      arima_evaluate.has_spikes_and_dips,
      arima_evaluate.has_step_changes,
      arima_evaluate.seasonal_periods,
      arima_evaluate.variance
    ]
    filters: [model_name.select_model_name: ""]
  }

  query: get_forecast {
    label: "Get Forecast"
    description: "Important: Specify model name from Create Model"
    dimensions: [arima_forecast.forecast_date]
    measures: [arima_forecast.total_forecast]
    filters: [model_name.select_model_name: ""]
  }
}
