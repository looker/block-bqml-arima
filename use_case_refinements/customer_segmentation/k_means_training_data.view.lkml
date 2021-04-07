include: "/views/k_means_training_data.view"

view: +k_means_training_data {
  derived_table: {
    persist_for: "1 second"
    sql_create: CREATE OR REPLACE VIEW @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_training_data
                  AS  SELECT
                        {% assign item_id = _filters['select_item_id'] | sql_quote | replace: '"','' | remove: "'" %}
                          {{ item_id }} AS item_id,
                        {% assign features = _filters['select_features'] | sql_quote | replace: '"','' | remove: "'" %}
                          {{ features }}
                      FROM @{bqml_training_dataset_name}.users
    ;;
  }

  parameter: select_training_data {
    hidden: yes
  }
}
