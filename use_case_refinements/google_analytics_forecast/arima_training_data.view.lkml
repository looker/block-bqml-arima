include: "/views/arima_training_data.view"

view: +arima_training_data {

  parameter: select_time_column {
    hidden: yes
    default_value: "date"
    allowed_value: {
      value: "date"
    }
  }
}
