include: "/explores/field_suggestions.explore"

view: k_means_training_data {
  label: "[2] Select Training Data"
  derived_table: {
    persist_for: "1 second"
    sql_create: CREATE OR REPLACE VIEW @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_training_data
                  AS  SELECT
                        {% assign item_id = _filters['select_item_id'] | sql_quote | replace: '"','' | remove: "'" %}
                          {{ item_id }} AS item_id,
                        {% assign features = _filters['select_features'] | sql_quote | replace: '"','' | remove: "'" %}
                          {{ features }}
                      FROM @{bqml_training_dataset_name}.{% parameter select_training_data %}
    ;;
  }

  parameter: select_training_data {
    label: "Select Training Data (REQUIRED)"
    description: "Choose a dataset to train your model"
    type: unquoted
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.table_name
  }

  filter: select_item_id {
    label: "Select an ID Field (REQUIRED)"
    description: "Choose the field that identifies the items you want to cluster"
    type: string
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
    suggest_persist_for: "0 minutes"
  }

  filter: select_features {
    label: "Select Features (REQUIRED)"
    description: "Choose the attribute fields that you want to use to cluster your data"
    type: string
    suggest_explore: field_suggestions
    suggest_dimension: field_suggestions.column_name
    suggest_persist_for: "0 minutes"
  }
}
