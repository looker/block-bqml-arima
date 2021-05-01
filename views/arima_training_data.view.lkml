include: "/explores/field_suggestions.explore"

view: arima_training_data {
  label: "[3] BQML: Select Training Data"
  derived_table: {
    persist_for: "1 second"
    sql_create: CREATE OR REPLACE VIEW @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_training_data
                  AS  SELECT {% parameter select_time_column %}
                        , {% parameter select_data_column %}

                        {% if select_series_id_column._is_filtered %}
                          {% assign series_id = _filters['select_series_id_column'] | sql_quote | replace: '"','' | remove: "'" %}
                          , {{ series_id }}
                        {% else %}
                        {% endif %}

                      FROM ${input_data.SQL_TABLE_NAME}
    ;;
  }

  parameter: select_time_column {
    label: "Select a Time Field (REQUIRED)"
    description: "Choose the field that indicates the date or time of the data you want to forecast"
    type: unquoted
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
  }

  parameter: select_data_column {
    label: "Select the Data Field (REQUIRED)"
    description: "Choose the field that contains the data you want to forecast"
    type: unquoted
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
  }

  filter: select_series_id_column {
    hidden: yes
    label: "Select Time Series IDs (REQUIRED)"
    description: "Choose the field or fields that uniquely identify each time series"
    type: string
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
  }
}
