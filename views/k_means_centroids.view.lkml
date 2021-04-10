view: k_means_centroids {
  label: "[7] Centroids"

  sql_table_name: ML.CENTROIDS(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}) ;;

  dimension: centroid_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.centroid_id ;;
  }

  dimension: feature {
    type: string
    sql: ${TABLE}.feature ;;
  }

  dimension: numerical_value {
    type: number
    sql: ${TABLE}.numerical_value ;;
  }

  dimension: categorical_value {
    hidden: yes
    type: string
    sql: ${TABLE}.categorical_value ;;
  }
}

view: centroid_categorical_value {
  label: "[7] Centroids: Categorical Value"

  dimension: category {
    primary_key: yes
    required_fields: [k_means_centroids.centroid_id, k_means_centroids.feature]
  }

  dimension: value {
    required_fields: [k_means_centroids.centroid_id, k_means_centroids.feature]
  }
}
