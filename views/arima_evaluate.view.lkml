## returns evaluation metrics for the chosen model that best fits the time series data (show_all_candidate_models = FALSE)
view: arima_evaluate {
  label: "[6] BQML: Evaluation Metrics & Coefficients"

  sql_table_name: ML.ARIMA_EVALUATE(MODEL @{looker_temp_dataset_name}.{% parameter model_name.select_model_name %}_arima_model_{{ _explore._name }}
                    , STRUCT(FALSE AS show_all_candidate_models))
  ;;


  dimension: non_seasonal_p {
    group_label: " Model Components"
    label: "Non Seasonal p"
    description: "Number of lag observations or autoregressive terms in the model"
    type: number
    sql: ${TABLE}.non_seasonal_p ;;
  }

  dimension: non_seasonal_d {
    group_label: " Model Components"
    label: "Non Seasonal d"
    description: "Difference in the nonseasonal observations"
    type: number
    sql: ${TABLE}.non_seasonal_d ;;
  }

  dimension: non_seasonal_q {
    group_label: " Model Components"
    label: "Non Seasonal q"
    description: "Size of the moving average window"
    type: number
    sql: ${TABLE}.non_seasonal_q ;;
  }

  dimension: has_drift {
    group_label: " Model Components"
    type: string
    sql: ${TABLE}.has_drift ;;
  }

  dimension: log_likelihood {
    group_label: "Model Fitting"
    type: number
    sql: ${TABLE}.log_likelihood ;;
  }

  dimension: aic {
    group_label: "Model Fitting"
    label: "AIC"
    type: number
    description: "Compares the quality of a set of models. BigQuery ML generates dozens of candidate models and chooses the best one with lowest AIC value "
    sql: ${TABLE}.AIC ;;
    value_format_name: decimal_4
  }

  dimension: variance {
    group_label: "Model Fitting"
    type: number
    sql: ${TABLE}.variance ;;
    value_format_name: decimal_4
  }

  dimension: seasonal_periods {
    group_label: " Model Components"
    type: string
    sql: ARRAY_TO_STRING(${TABLE}.seasonal_periods, ", ") ;;
  }

  dimension: has_holiday_effect {
    group_label: " Model Components"
    type: string
    sql: ${TABLE}.has_holiday_effect ;;
  }

  dimension: has_spikes_and_dips {
    group_label: " Model Components"
    type: string
    sql: ${TABLE}.has_spikes_and_dips ;;
  }

  dimension: has_step_changes {
    group_label: " Model Components"
    type: string
    sql: ${TABLE}.has_step_changes ;;
  }

  dimension: error_message {
    type: string
    hidden: yes
    description: "Will indicate if a possible error incurred during the ARIMA fitting process"
    sql: ${TABLE}.error_message ;;
  }

}
