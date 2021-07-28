include: "/views/arima_training_data.view"

view: +arima_training_data {

  parameter: select_time_column {
    hidden: yes
    default_value: "created_date"
    allowed_value: {
      value: "created_date"
    }
  }
}
