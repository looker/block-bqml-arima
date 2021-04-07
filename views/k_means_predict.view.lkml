view: k_means_predict {
  label: "6. Predictions"

  sql_table_name: ML.PREDICT(MODEL looker_pdts.{% parameter model_name.select_model_name %},
                      TABLE looker_pdts.{% parameter model_name.select_model_name %}_training_data
                    )
  ;;

    dimension: item_id {
      primary_key: yes
      type: string
      sql: ${TABLE}.item_id ;;
    }

    dimension: centroid_id {
      type: string
      sql: ${TABLE}.CENTROID_ID ;;
    }

    # dimension: nearest_centroids_distance {
    #   type: string
    #   sql: ${TABLE}.NEAREST_CENTROIDS_DISTANCE ;;
    # }

    measure: count {
      type: count
    }
  }
