connection: "@{CONNECTION_NAME}"

include: "/views/model_info.view"

explore: model_info {
  group_label: "Looker + BigQuery ML"
  label: "BQML ARIMA Plus: Model Info"
  description: "View all BQML ARIMA Plus models created with Looker"
  persist_for: "0 minutes"
}
