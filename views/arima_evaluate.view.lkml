view: arima_evaluate {
  label: "[6] BQML: Evaluation Metrics"

  sql_table_name: ML.ARIMA_EVALUATE(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model) ;;


  dimension: non_seasonal_p {
    label: "Non Seasonal p"
    type: number
    sql: ${TABLE}.non_seasonal_p ;;
  }

  dimension: non_seasonal_d {
    label: "Non Seasonal d"
    type: number
    sql: ${TABLE}.non_seasonal_d ;;
  }

  dimension: non_seasonal_q {
    label: "Non Seasonal q"
    type: number
    sql: ${TABLE}.non_seasonal_q ;;
  }

  dimension: has_drift {
    type: string
    sql: ${TABLE}.has_drift ;;
  }

  dimension: log_likelihood {
    type: number
    sql: ${TABLE}.log_likelihood ;;
  }

  dimension: aic {
    label: "AIC"
    type: number
    sql: ${TABLE}.AIC ;;
  }

  dimension: variance {
    type: number
    sql: ${TABLE}.variance ;;
  }

  dimension: seasonal_periods {
    type: string
    sql: ${TABLE}.seasonal_periods ;;
  }

  dimension: has_holiday_effect {
    type: string
    sql: ${TABLE}.has_holiday_effect ;;
  }

  dimension: has_spikes_and_dips {
    type: string
    sql: ${TABLE}.has_spikes_and_dips ;;
  }

  dimension: has_step_changes {
    type: string
    sql: ${TABLE}.has_step_changes ;;
  }

  dimension: error_message {
    type: string
    sql: ${TABLE}.error_message ;;
  }

}
