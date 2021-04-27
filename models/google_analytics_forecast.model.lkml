connection: "advanced_analytics_accelerator"

include: "/explores/bqml_arima.explore"
include: "/use_case_refinements/google_analytics_forecast/*.view"


explore: google_analytics_forecast {
  label: "BQML ARIMA Plus: Google Analytics Forecast"
  description: "Use this Explore to create BQML ARIMA Plus models to forecast various metrics using Google Analytics data"

  extends: [bqml_arima]

  join: arima_explain_forecast {
    type: full_outer
    relationship: one_to_one
    sql_on: ${input_data.date} = ${arima_explain_forecast.time_series_date} ;;
  }
}
