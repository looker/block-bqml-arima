include: "/views/field_suggestions.view"

view: +field_suggestions {
  derived_table: {
    sql:  SELECT table_name, column_name
      FROM @{bqml_training_dataset_name}.INFORMATION_SCHEMA.COLUMNS
      WHERE table_name = 'users'
    ;;
  }
}
