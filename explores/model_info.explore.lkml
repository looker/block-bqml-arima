include: "/views/model_info.view"

explore: model_info {
  group_label: "Advanced Analytics with BQML"
  label: "BQML K-Means: Model Info"
  fields: [ALL_FIELDS*, -model_info.select_model_name]
}
