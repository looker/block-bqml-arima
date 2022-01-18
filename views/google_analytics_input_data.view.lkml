view: google_analytics_input_data {
  label: "[1] BQML: Input Data"

  derived_table: {
    sql:  SELECT PARSE_TIMESTAMP("%Y%m%d", date) AS date
      , SUM(totals.visits) AS visits
      , SUM(totals.newVisits) AS new_visits
      , SUM(totals.pageviews) AS pageviews
      , SUM(totals.hits) AS hits
      , SUM(totals.bounces) AS bounces
      , SUM(totals.timeOnSite) AS time_on_site
      , SUM(totals.transactions) AS transactions
      , SUM(totals.transactionRevenue) AS transaction_revenue
    FROM
      `bigquery-public-data.google_analytics_sample.ga_sessions_*`
    GROUP BY date
  ;;
  }

  dimension: date {
    type: date
    primary_key: yes
    sql: ${TABLE}.date ;;
    convert_tz: no
  }

  dimension_group: create {
    type: time
    hidden: yes
    timeframes: [date,raw,time]
    sql: ${TABLE}.date ;;
    convert_tz: no
  }

  dimension: visits {
    hidden: yes
    type: number
    sql: ${TABLE}.visits ;;
  }

  dimension: new_visits {
    hidden: yes
    type: number
    sql: ${TABLE}.new_visits ;;
  }

  dimension: pageviews {
    hidden: yes
    type: number
    sql: ${TABLE}.pageviews ;;
  }

  dimension: hits {
    hidden: yes
    type: number
    sql: ${TABLE}.hits ;;
  }

  dimension: bounces {
    hidden: yes
    type: number
    sql: ${TABLE}.bounces ;;
  }

  dimension: time_on_site {
    hidden: yes
    type: number
    sql: ${TABLE}.time_on_site ;;
  }

  dimension: transactions {
    hidden: yes
    type: number
    sql: ${TABLE}.transactions ;;
  }

  dimension: transaction_revenue {
    hidden: yes
    type: number
    sql: ${TABLE}.transaction_revenue ;;
  }

  measure: total_visits {
    hidden: yes
    type: sum
    sql: ${visits} ;;
  }

  measure: total_new_visits {
    type: sum
    sql: ${new_visits} ;;
  }

  measure: total_pageviews {
    type: sum
    sql: ${pageviews} ;;
  }

  measure: total_hits {
    type: sum
    sql: ${hits} ;;
  }

  measure: total_bounces {
    type: sum
    sql: ${bounces} ;;
  }

  measure: total_time_on_site {
    type: sum
    sql: ${time_on_site} ;;
  }

  measure: total_transactions {
    type: sum
    sql: ${transactions} ;;
  }

  measure: total_transaction_revenue {
    type: sum
    sql: ${transaction_revenue} ;;
  }

  measure: row_count {
    type: count
  }
}
