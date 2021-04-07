view: field_suggestions {
  derived_table: {
    sql:  SELECT table_name, column_name
          FROM @{bqml_training_dataset_name}.INFORMATION_SCHEMA.COLUMNS
    ;;
  }

  dimension: table_name {}
  dimension: column_name {}
}
