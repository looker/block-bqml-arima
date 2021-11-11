include: "/views/arima_training_data.view"
include: "/explores/google_analytics_field_suggestions.explore"

view: google_analytics_arima_training_data {
  extends: [arima_training_data]

  parameter: select_time_column {
    suggest_explore: google_analytics_field_suggestions
    suggest_dimension: google_analytics_field_suggestions.column_name
  }

  parameter: select_data_column {
    suggest_explore: google_analytics_field_suggestions
    suggest_dimension: google_analytics_field_suggestions.column_name
  }
}
