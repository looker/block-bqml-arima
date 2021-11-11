include: "/views/arima_create_model.view"

view: google_analytics_arima_create_model {
  extends: [arima_create_model]

  derived_table: {
    create_process: {

      sql_step: CREATE OR REPLACE TABLE @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_training_data_{{ _explore._name }}
                    AS  SELECT {% parameter google_analytics_arima_training_data.select_time_column %}
                          , {% parameter google_analytics_arima_training_data.select_data_column %}
                        FROM ${google_analytics_input_data.SQL_TABLE_NAME}
      ;;
    }
  }
}
