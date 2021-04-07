view: k_means_evaluate {
  label: "5. Evaluation Info"

  sql_table_name: ML.EVALUATE(MODEL looker_pdts.{% parameter model_name.select_model_name %}) ;;

  dimension: davies_bouldin_index {
    type: number
    sql: ${TABLE}.davies_bouldin_index ;;
  }

  dimension: mean_squared_distance {
    type: number
    sql: ${TABLE}.mean_squared_distance ;;
  }
}
