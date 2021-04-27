include: "/views/input_data.view"

view: +input_data {
  derived_table: {
    sql: SELECT
        PARSE_TIMESTAMP("%Y%m%d", date) AS date,
        SUM(totals.visits) AS total_visits
      FROM
        `bigquery-public-data.google_analytics_sample.ga_sessions_*`
      GROUP BY date
       ;;
  }

  dimension: date {
    primary_key: yes
    convert_tz: no
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: total_visits {
    type: number
    sql: ${TABLE}.total_visits ;;
  }

  measure: count {
    type: count
  }
}
