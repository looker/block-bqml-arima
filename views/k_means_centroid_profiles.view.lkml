view: k_means_centroid_profiles {
  label: "[7] BQML: Centroids"

  derived_table: {
    sql:  select centroid_id
            , item_count
            , item_count / sum(item_count) over () as items_pct_total
          from (select CENTROID_ID as centroid_id
                , count(distinct item_id) as item_count
                from ${k_means_predict.SQL_TABLE_NAME}
                group by 1) a
    ;;
  }

  dimension: centroid_id {
    hidden: yes
    primary_key: yes
  }

  dimension: item_count {
    type: number
  }

  dimension: items_pct_total {
    label: "Percent of Total Items"
    type: number
    sql: ${TABLE}.items_pct_total ;;
    value_format_name: percent_2
  }
}
