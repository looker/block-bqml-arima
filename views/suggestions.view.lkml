explore: suggestions {
  hidden: yes
  persist_for: "0 minutes"
}

view: suggestions {
  derived_table: {
    sql:  SELECT table_name, column_name
          FROM bqml_training_data.INFORMATION_SCHEMA.COLUMNS
    ;;
  }

  dimension: table_name {}
  dimension: column_name {}
}
