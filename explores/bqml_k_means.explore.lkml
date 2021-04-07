include: "/views/*.view"

explore: bqml_k_means {
  extension: required
  view_name: model_name
  group_label: "Advanced Analytics with BQML"
  description: "Use this Explore to build and evaluate a BQML K-means Clustering model"

  always_filter: {
    filters: [model_name.select_model_name: ""]
  }

  join: k_means_training_data {
    sql:  ;;
  relationship: one_to_one
  }

  join: k_means_create_model {
    sql:  ;;
  relationship: one_to_one
  }

  join: k_means_evaluate {
    type: cross
    relationship: one_to_one
  }

  join: k_means_predict {
    type: left_outer
    sql:  ;;
  relationship: one_to_one
  }

  join: k_means_centroids {
    type: left_outer
    sql_on: ${k_means_predict.centroid_id} = ${k_means_centroids.centroid_id} ;;
    relationship: many_to_one
  }

  join: centroid_categorical_value {
    sql: LEFT JOIN UNNEST(k_means_centroids.categorical_value) as centroid_categorical_value ;;
    relationship: one_to_many
  }
}
