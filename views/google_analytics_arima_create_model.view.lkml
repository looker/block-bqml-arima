include: "/views/arima_create_model.view"

view: google_analytics_arima_create_model {
  extends: [arima_create_model]

  derived_table: {
    create_process: {

      sql_step: CREATE OR REPLACE TABLE @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_training_data_{{ _explore._name }}
                    AS  SELECT {% parameter google_analytics_arima_training_data.select_time_column %} AS time_series_timestamp
                          , {% parameter google_analytics_arima_training_data.select_data_column %} AS time_series_data
                        FROM ${google_analytics_input_data.SQL_TABLE_NAME}
      ;;

      sql_step: CREATE OR REPLACE MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model_{{ _explore._name }}
                   OPTIONS(MODEL_TYPE = 'ARIMA_PLUS'
                    ,time_series_timestamp_col = 'time_series_timestamp'
                    ,time_series_data_col = 'time_series_data'

                    {% if arima_hyper_params.set_horizon._parameter_value == 1000 %}
                    {% else %}
                      , HORIZON = {% parameter arima_hyper_params.set_horizon %}
                    {% endif %}

                    {% if arima_hyper_params.set_holiday_region._parameter_value == 'none' %}
                    {% else %}
                    , HOLIDAY_REGION = '{% parameter arima_hyper_params.set_holiday_region %}'
                    {% endif %}

                    , AUTO_ARIMA = TRUE
                    )
                  AS (SELECT * FROM @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_training_data_{{ _explore._name }})
      ;;

      sql_step: CREATE TABLE IF NOT EXISTS @{looker_temp_dataset_name}.BQML_ARIMA_MODEL_INFO
                  (model_name     STRING,
                  time_column     STRING,
                  data_column     STRING,
                  horizon         INT64,
                  holiday_region  STRING,
                  created_at      TIMESTAMP,
                  explore         STRING)
      ;;

      sql_step: MERGE @{looker_temp_dataset_name}.BQML_ARIMA_MODEL_INFO AS T
                USING (SELECT '{% parameter model_name.select_model_name %}' AS model_name
                        , '{% parameter google_analytics_arima_training_data.select_time_column %}' AS time_column
                        , '{% parameter google_analytics_arima_training_data.select_data_column %}' AS data_column
                        , {% parameter arima_hyper_params.set_horizon %} AS horizon
                        , '{% parameter arima_hyper_params.set_holiday_region %}' AS holiday_region
                        , CURRENT_TIMESTAMP AS created_at
                        , '{{ _explore._name }}' AS explore
                      ) AS S
                ON T.model_name = S.model_name AND T.explore = S.explore
                WHEN MATCHED THEN
                  UPDATE SET time_column=S.time_column
                  , data_column=S.data_column
                  , horizon=S.horizon
                  , holiday_region=S.holiday_region
                  , created_at=S.created_at
                WHEN NOT MATCHED THEN
                  INSERT (model_name, time_column, data_column, horizon, holiday_region, created_at, explore)
                  VALUES(model_name, time_column, data_column, horizon, holiday_region, created_at, explore)
      ;;

    }
  }
}
