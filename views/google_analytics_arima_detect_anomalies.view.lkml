include: "/views/arima_detect_anomalies.view"

view: google_analytics_arima_detect_anomalies {
  extends: [arima_detect_anomalies]
    derived_table: {
      sql: SELECT
        {% parameter google_analytics_arima_training_data.select_time_column %} as time_series_timestamp
        ,{% parameter google_analytics_arima_training_data.select_data_column %}  as time_series_data
        ,is_anomaly
        ,anomaly_probability
        ,lower_bound
        ,upper_bound
      FROM
        ML.DETECT_ANOMALIES(MODEL  @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model_{{ _explore._name }},STRUCT({% parameter set_anomaly_prob_threshold %} AS anomaly_prob_threshold))
       ;;
    }

 }
