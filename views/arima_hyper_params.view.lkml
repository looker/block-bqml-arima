view: arima_hyper_params {
  label: "[4] BQML: Set Model Parameters"


  parameter: set_horizon {
    label: "Forecast Horizon (optional)"
    description: "Choose the number of time points to forecast. The default value is 1,000. The maximum value is 10,000"
    type: number
    default_value: "1000"
  }

  parameter: set_holiday_region {
    label: "Holiday Effects Region (optional)"
    description: "Choose a geographical region if you would like to adjust for holiday effects. By default, holiday effect modeling is disabled."
    type: unquoted
    default_value: "none"
    allowed_value: {
      label: "No Holiday Adjustment"
      value: "none"
    }
    allowed_value: {
      label: "Global"
      value: "GLOBAL"
    }
    allowed_value: {
      label: "North America"
      value: "NA"
    }
    allowed_value: {
      label: "Japan and Asia Pacific"
      value: "JAPAC"
    }
    allowed_value: {
      label: "Europe, the Middle East and Africa"
      value: "EMEA"
    }
    allowed_value: {
      label: "Latin America and the Caribbean"
      value: "LAC"
    }
  }
}
