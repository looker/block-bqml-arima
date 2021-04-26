view: arima_create_model {
  derived_table: {
    persist_for: "1 second"

    create_process: {

      sql_step: CREATE OR REPLACE MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model
                  OPTIONS(MODEL_TYPE = 'ARIMA_PLUS'
                    , time_series_timestamp_col = '{% parameter arima_training_data.select_time_column %}'
                    , time_series_data_col = '{% parameter arima_training_data.select_data_column %}'

                    {% if arima_training_data.select_series_id_column._is_filtered %}
                      {% assign series_id = _filters['arima_training_data.select_series_id_column'] | sql_quote | remove: "'" | replace: '"',"'" %}
                      , time_series_id_col = [{{ series_id }}]
                    {% else %}
                    {% endif %}

                    {% if horizon._parameter_value == 1000 %}
                    {% else %}
                      , HORIZON = {% parameter horizon %}
                    {% endif %}

                    , AUTO_ARIMA = TRUE)
                  AS (SELECT * FROM @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_training_data)
      ;;

      sql_step: CREATE TABLE IF NOT EXISTS @{looker_temp_dataset_name}.BQML_ARIMA_MODEL_INFO
                  (model_name STRING,
                  time_column STRING,
                  data_column STRING,
                  series_id   ARRAY<STRING>,
                  horizon     INT64,
                  created_at  TIMESTAMP)
      ;;

      sql_step: MERGE @{looker_temp_dataset_name}.BQML_ARIMA_MODEL_INFO AS T
                USING (SELECT '{% parameter model_name.select_model_name %}' AS model_name
                        , '{% parameter arima_training_data.select_time_column %}' AS time_column
                        , '{% parameter arima_training_data.select_data_column %}' AS data_column
                        {% assign series_id = _filters['arima_training_data.select_series_id_column'] | sql_quote | remove: "'" | replace: '"',"'" %}
                        , [{{ series_id }}] AS series_id
                        , {% parameter horizon %} AS horizon
                        , CURRENT_TIMESTAMP AS created_at
                      ) AS S
                ON T.model_name = S.model_name
                WHEN MATCHED THEN
                UPDATE SET time_column=S.time_column
                , data_column=S.data_column
                , series_id=S.series_id
                , horizon=S.horizon
                , created_at=S.created_at
                WHEN NOT MATCHED THEN
                INSERT (model_name, time_column, data_column, series_id, horizon, created_at)
                VALUES(model_name, time_column, data_column, series_id, horizon, created_at)
      ;;
    }
  }

  parameter: horizon {
    view_label: "[3] BQML: Choose Model Parameters"
    label: "Forecast Horizon (optional)"
    description: "Choose the number of time points to forecast. The default value is 1,000. The maximum value is 10,000"
    type: number
    default_value: "1000"
  }

  dimension: status {
    view_label: "[4] BQML: Create Model"
    label: "Build Status (REQUIRED)"
    description: "Selecting this field is required to start building your model"
    type: string
    sql: 'Complete' ;;
  }
}
