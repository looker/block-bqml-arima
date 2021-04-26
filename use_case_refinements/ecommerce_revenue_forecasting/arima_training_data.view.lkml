include: "/views/arima_training_data.view"

view: +arima_training_data {

  filter: select_series_id_column {
    hidden: yes
  }
}
