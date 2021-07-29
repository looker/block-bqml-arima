view: input_data {
  label: "[1] BQML: Input Data"

  derived_table: {
    sql:  SELECT PARSE_TIMESTAMP("%Y%m%d", date) AS date
        , SUM(totals.visits) AS total_visits
        , SUM(totals.newVisits) AS total_new_visits
        , SUM(totals.pageviews) AS total_pageviews
        , SUM(totals.hits) AS total_hits
        , SUM(totals.bounces) AS total_bounces
        , SUM(totals.timeOnSite) AS total_time_on_site
        , SUM(totals.transactions) AS total_transactions
        , SUM(totals.transactionRevenue) AS total_transaction_revenue
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

  dimension: total_new_visits {
    type: number
    sql: ${TABLE}.total_new_visits ;;
  }

  dimension: total_pageviews {
    type: number
    sql: ${TABLE}.total_pageviews ;;
  }

  dimension: total_hits {
    type: number
    sql: ${TABLE}.total_hits ;;
  }

  dimension: total_bounces {
    type: number
    sql: ${TABLE}.total_bounces ;;
  }

  dimension: total_time_on_site {
    type: number
    sql: ${TABLE}.total_time_on_site ;;
  }

  dimension: total_transactions {
    type: number
    sql: ${TABLE}.total_transactions ;;
  }

  dimension: total_transaction_revenue {
    type: number
    sql: ${TABLE}.total_transaction_revenue ;;
  }

  measure: count {
    type: count
  }
}
