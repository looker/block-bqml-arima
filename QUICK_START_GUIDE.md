# **Quick Start Guide for Business Users**

## Creating and Evaluating a Time Series Forecasting Model

Demand forecasting can apply to many different use cases across all industries. For example, media/gaming companies may use forecasts of active players per hour to ensure proper resource allocation to support demand. Or in the retail industry, companies strive to have the right amount of inventory on hand to minimize shortages and avoid excess inventory. With forecasted call volume, call centers can improve staffing allocation during the busiest times of the day. The ability to forecast accurately and promptly is critical to remain competitive in any industry.

Once a LookML Developer creates an Explore with an appropriate training dataset paired with the **BQML ARIMA Block**, a Looker business analyst can begin creating and evaluating time series forecasting models with BigQuery Machine Learning (BigQuery ML or BQML) functionality. They can also incorporate these forecasts in dashboards or custom analyses.

An **ARIMA** (autoregressive integrated moving average) model is a popular tool among data scientists for estimating future demand. This type of model uses past values in a time series to forecast future points while automatically detecting and correcting for anomalies, seasonality, and holiday effects.

ARIMA is the core algorithm used in BigQuery ML time series forecasting but not the only component. The model creation pipeline consists of these steps:
- Automatic cleaning adjustments (e.g., handle duplicate timestamps, missing data, irregular time intervals, spikes/abrupt changes)
- Holiday effects
- Seasonal and trend decomposition
- Trend modeling with ARIMA and Auto ARIMA

With BigQuery ML dozens of candidate models are trained and evaluated in parallel, and the best model is selected for you.

This Quick Start guide will outline how a business analyst can create and evaluate a forecast model. An Explore defined with BQML ARIMA Plus will include steps to **create a model** and steps to **evaluate a model**. We will describe these steps at a high-level and then discuss each step in more detail as we walk through the example Explore **BQML ARIMA Plus: Google Analytics Forecast** included with this block.

>
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i>  Note, Looker does provide Forecasting based on auto-ARIMA as part of select visualizations and works for several different databases. </font></b>While you may see similar results between the two approaches, this Block leverages the best of BigQuery Machine Learning and provides a full range of modeling components including holiday effects and anomaly detection.
>



### Create Model Steps

To create a model, you must review and make selections from *Steps 1 - 5*. You may also select from *Steps 6 - 9* when creating a model; however, these steps are not required.

| Step  | Description |
| ------------- | ------------- |
| **\[1\] BQML: Input Data**  | Data to be used for forecasting. |
| **\[2\] BQML: Name Your Model** | **REQUIRED** Name of model to be created or evaluated (no spaces allowed).  |
| **\[3\] BQML: Select Training Data**  | **REQUIRED to create model** Specify the **time** field and the **data** field to use for forecasting. For example, your time field may be `order date` and the data field may be `total revenue`. The fields available for selection come from the list of dimensions found in your *Input Data* as seen in Step 1.  |
| **\[4\] BQML: Set Model Parameters**  | Specify the **forecast horizon** or number of time points to forecast (if omitted, the model uses 1,000). If forecasting daily revenue, a value of `30` will forecast 30 days. |
| **\[5\] BQML: Create Model**  | **REQUIRED to create model** To create a model, you must add this dimension to the query (any query in Looker requires at least 1 dimension). When a model has successfully completed, the returned value will show "Complete". Inclusion of this dimension will always create a new model or replace an existing model. |

### Evaluate Model Steps

To evaluate a model which has already been created, you must specify name of the model (*Step 2*) plus make selections from *Steps 6, 7, or 8*.

| Step  | Description |
| ------------- | ------------- |
| **\[6\] BQML: Evaluation Metrics & Coefficients**  | Review indicators of the model fitting process, components of the time series model and the model coefficients. |
| **\[7\] BQML: Forecast** | Generate forecasts including upper and lower prediction intervals.  |
| **\[8\] BQML: Detect Anomalies** | Use model to identify anomalies (values that differ from expected) in the input/training data |



## **\[1\] BQML: Input Data**

The proper preparation of the input dataset is critical to the success of any machine learning model. The LookML developer who sets up the BQML ARIMA Plus Explore will need to prepare a dataset with at least one time dimension and at least one measure/metric value to be forecasted.

To illustrate, we will look at the example Explore **BQML ARIMA Plus: Google Analytics Forecast** included with the block. Our input dataset provides several metrics by day for the duration of August 1, 2016 to August 1, 2017.

Date
Bounces
Hits
New Visits
Page Views
Time on Site
Transaction Revenue
Transactions

You can use this dataset to generate a forecast model for Transactions, Page Views or any one of the metrics available (specified with **Data Field** parameter in step **\[3\] BQML: Select Training Data**).

>
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i> Note, all rows of the input dataset are used in training the model regardless of filters. </font></b> You can filter the input dataset as necessary to review and understand your data or to build visualizations; however, for modeling purposes **all** rows of the input dataset are included when creating a time series model. If you need to alter the input dataset (e.g., filter to different date range), contact a LookML Developer for assistance in refining the Explore to meet your use case.
>


## **\[2\] BQML: Name Your Model**  (*REQUIRED*)

The parameter **BQML Model Name (REQUIRED)** appears in the filter pane by default. Enter a unique name to create a new BQML model or select an existing model to use in your analysis. Name must not include spaces. If you enter a model name which already exists and run *create model*, the existing model will be replaced. Clicking into the parameter will generate a list of existing models created for the given Explore, if any.

  > For the **Google Analytics Forecast** example, enter unique name (e.g. forecast\_daily\_transactions)


## **\[3\] BQML: Select Training Data**  (*REQUIRED to create model*)

Add **Select a Time Field (REQUIRED)** to the filter pane. Leave the default filter condition of *is equal to* for string values. Click in the empty string field and a list of the dimensions found in **\[1\] BQML: Input Data** will be shown. You can only select one dimension. Be sure to select an ID dimension that uniquely identifies the time period.

  > For the **Google Analytics Forecast** example, select *date*

Add **Select the Data Field (REQUIRED)** to the filter pane. Leave the default filter condition of *is equal to* for string values. Click in the empty string field and a list of the dimensions found in **\[1\] BQML: Input Data** will be shown. You can select only one dimension.

  > For the **Google Analytics Forecast** example, select *transactions*

## **\[4\] BQML: Set Model Parameters**

If you would like to specify the number of time points to forecast, add **Forecast Horizon (optional)** to the filter pane and enter a value between 1 and 10,000. This is an *optional* parameter. If left blank or not included, the model will use 1,000.

  > For the **Google Analytics Forecast** example, add to the filter pane and type in the value 365 to forecast the 365 days after August 1, 2017.

To account for potential holiday effects on demand for a given region, add **Holiday Effects Region (optional)** to the filter pane and choose one of the possible regions (Global, North America, Japan and Asia Pacific, Europe, the Middle East and Africa or Latin America and the Caribbean). When holiday effects modeling is enabled, spikes/dips during holidays will not be treated as anomalies. If this optional parameter is left blank or not included, holiday effects modeling is disabled.

>
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i> Note to take advantage of holiday effects, your input data must have at least one year's worth of daily or weekly data.</font></b> If your input data does not meet these requirements, holiday effect modeling is disabled even if you specify a value for the parameter. <br><br><b><font size = "3" color="#174EA6"><i class='fa fa-info-circle'></i> Note, each BQML Explore may be customized. </font></b>For example, if you want to apply holiday effects at a country level (rather than region), generate multiple forecasts in a single query (e.g., create a time series model for each value of a dimension like product) or modify other ARIMA Plus Model parameters, contact your LookML Developer or Looker Professional Services team to customize an Explore for your specific use case.
>



## **\[5\] BQML: Create Model** (*REQUIRED to create model*)

To submit any query in Looker, you must include at least one dimension in the data pane. So to create the forecasting model, add the **Train Model (REQUIRED)** dimension to the data pane. Once the dimension is added, you will be able to click the **RUN** button in top right and the model will be built with BigQuery ML. Once the forecasting model has been created, the query will return a value of **Complete** for the **Train Model** dimension. The amount of time it takes to create the model will likely be at least a few minutes. The total time can vary depending on the size of the dataset.

If you select a model name which already exists, the model will be replaced with the latest iteration of the model creation step. After creating the model, you will want to remove the **Train Model (REQUIRED)** dimension from the data pane to avoid inadvertently creating the model again.

## **\[6\] BQML: Evaluation Metrics & Coefficients**

During model creation, dozens of candidate models are trained and evaluated in parallel. BigQuery ML selects the best model with the lowest Akaike Information Criterion (AIC). The `AIC` value, `Variance` and `Log Likelihood` values are relevant to the model fitting process. The time series model is defined by `non seasonal d`, `non seasonal p` and `non seasonal q` values along with `has drift`. The model's AR coefficients, MA coefficients and Interaction/Drift values are also available for review.

### **Model Components**

| Dimension  | Description |
| ------------- | ------------- |
| **Has Drift** | True if the model is fitted for drift. When Non Seasonal d is not 1, value is set to False by default as has_drift does not apply in those cases. |
| **Has Holiday Effect** | True if the model includes holiday effects adjustments. |
| **Has Spikes and Dips** | True if the model adjusts for spikes and dips. |
| **Has Step Changes** | True if the model adjusts for step changes. |
| **Non Seasonal d** | Minimum number of differencing points (differences between a data point and previous data point) needed to minimize seasonality. Value of 0 means the time series is non seasonal. |
| **Non Seasonal p** | The number of lag observations or auto-regressive terms to be used in the model. A time series is considered auto-regressive when previous values in the time series are very predictive of later values. |
| **Non Seasonal q** | Size of the moving average window over your time series data. Refers to the number of lagged forecast errors in the model. |
| **Seasonal Periods** | Levels of seasonality found in the input data, if any. Valid values: DAILY, WEEKLY, MONTHLY, QUARTERLY, YEARLY, and NO_SEASONALITY. Result can be a combination of these values, as a time series can have multiple seasonal periods. |

### **Model Coefficients**

| Dimension  | Description |
| ------------- | ------------- |
| **AR Coefficients** | The autoregressive coefficients, which correspond to non-seasonal p. If non-seasonal p is 3, you will see 3 coefficient values. |
| **MA Coefficients** | The moving-average coefficients, which correspond to non-seasonal q. If non-seasonal q is 3, you will see 3 coefficient values. |
| **Intercept or Drift** | Constant term in the ARIMA model. |

### **Model Fitting**

| Dimension  | Description |
| ------------- | ------------- |
| **AIC** | Given a set of models, AIC estimates the prediction error and the quality of each model relative to each of the other models. As BigQuery ML produces dozens of candidate models, the model with the lowest AIC value is selected. |
| **Log Likelihood** | Measures the level of fit of a model to the training dataset. |
| **Variance** | Measures how far the values of a series are from the average of the series. |


## **\[7\] BQML: Forecast**

To compute and see forecasts for future time periods, you can control two parameters:

 | Parameter  | Description |
| ------------- | ------------- |
| **Confidence Level**| Percentage of forecasted values that fall in the prediction interval. Values are greater than are equal to 0 or less than 1. Default value is 0.95. The higher the confidence level, the wider the prediction range to ensure the actual value will fall within the forecasted range. |
| **Forecast Horizon** | Number of time points to predict. Value cannot exceed the value set for the Forecast Horizon in **\[4\] BQML: Set Model Parameters** or 1000 |

To understand the accuracy of the forecasts, let's plot both the historical and forecasted values for the **Google Analytics Forecast** model just created. Follow these steps:

> 1. From the explore, expand the `filters` pane and enter the name of the model created in **\[2\] BQML: Name Your Model**
2. From the field picker expand folder **\[7\] BQML: Forecast**, add `Confidence Level` to filter pane and set value to **0.90**
3. Add `Forecast Horizon` to filter pane and set value to **90** to get the forecasts for 90 days
4. Add `Time Series Date` to filter pane and set to `is on or after` **6/1/2017** to get last 3 months of the historical data along with the forecasts
5. Add `Time Series Date` to data pane
6. Add `Total Time Series Data` (which for our example represents Transactions) to data pane
7. Add `Time Series Type` as a **Pivot** column - this will break the line into `history` and `forecast`
8. Click `RUN` to create the line chart
9. Move to visualization pane and click on `Edit`
10. On `Plot` tab, uncheck `Plot Null Values`
>

Compare the patterns between the historical values and the forecasted values–does the forecast pattern appear accurate? If we add in the upper and lower bounds of the forecasts, you can be confident that the actual value will be somewhere between that range. The `Confidence Level` parameter you set determines the width of this range. Let's take a look at a visualization of these boundaries and continue from the steps above.

>11. Remove `Time Series Type` from the data pane (if you leave as a pivot column, you will get 6 different colors in the chart and legend)
12. Add `Total Prediction Interval Lower Bound` to data pane
13. Add `Total Prediction Interval Upper Bound` to data pane
14. Optionally add `Forecast Period Highlight` to data pane (you can use to add highlight shading to the chart)
15. Click `RUN` to create the line chart
16. Move to visualization pane and click on `Edit` to open visualization settings
17. On the `Series` tab, change the colors of the Upper and Lower series to a single color a few shades lighter than the time series data
18. Also on the `Series` tab, change the **color** of the `Forecast Period Highlight` to a very light color that complements your other colors. Also, change the `chart type` to **Area**
19. Click on the `Y` and drag the `Forecast Period Highlight` from the left axes to the right axes section. Then under `Configure Axes`, click **Right 1** and unselect **Show Axis Name** and **Show Axis Value**

If desired, change the `Confidence Level` value in the filter pane and see the impact on the Upper and Lower Bounds. The higher the value, the broader the predicted range (forecasted value will remain the same). If your confidence level is set to .95 and your forecasted value is 50 for a given date with lower bound of 35 and upper bound of 65, you can say with 95% confidence that the actual value will be between 35 and 50.






## **\[8\] BQML: Detect Anomalies**
Anomaly detection attempts to find observations that deviate from expected behavior. Within this block, you can use the machine learning model to investigate anomalies in historical data found in your input dataset. Using an `Anomaly Probability Threshold` value you provide, the ARIMA Plus Model labels each data point in the input dataset as anomalous or not and include likelihood to be an anomaly. If you expand the **\[8\] BQML: Detect Anomalies** section of the field picker you will see several dimensions and measures available for building a visualization.

| Dimension  | Description |
| ------------- | ------------- |
| **Anomaly Probability Threshold** | Set the anomaly probability threshold (value >= 0 and < 1). The default value is 0.95. The time-series data value at a specific timestamp is identified as anomalous if the anomaly probability exceeds the Anomaly Probability Threshold value.  |
| **Time Series Date** | Unit of time as either Date or Timestamp. |
| **Anomaly Count** | Count of time points labeled as an anomaly. |
| **Anomaly Time Series Data** | Returns the data value for a specific timestamp if it is labeled as an anomaly. Add this metric to a time series line chart to plot/overlay the anomaly values on the historical time series  |
| **Max Anomaly Probability** | Max of anomaly probability for the selected dimension(s). Value indicates the probability that a time-series data point occurs outside of the prediction interval. For example, an anomaly probability value of 0.95 means that, among all possible values at the given timestamp, there is a 95% chance that the value is closer to the predicted value than it is to the given time series data value. |
| **Min Anomaly Probability** | Min of Anomaly Probability for the selected dimension(s). Value indicates the probability that a time-series data point occurs outside of the prediction interval. For example, an anomaly probability value of 0.95 means that, among all possible values at the given timestamp, there is a 95% chance that the value is closer to the predicted value than it is to the given time series data value. |
| **Max Upper Bound** | Max of Upper Bound for the selected dimension(s). Value reflects the upper bound of the prediction interval for a given timestamp|
| **Min Lower Bound** | Min of Lower Bound for the selected dimension(s). Value reflects the lower bound of the prediction interval for a given timestamp |

While you can create many different reports related to anomalies, let's walk through an example where you plot the historical values and highlight the anomalies along the time series.

> 1. From the explore, expand the `filters` pane and enter the name of the model created in **\[2\] BQML: Name Your Model**
2. From the field picker expand folder **\[8\] BQML: Detect Anomalies**, add `Anomaly Probability Threshold` to filter pane and set value to **0.995**
3. Add `Time Series Date` to filter pane and set to `is on or after` **1/1/2017**
4. Add `Time Series Date` to data pane
5. Add `Total Time Series Data` (which for our example represents Transactions) to data pane
6. Add `Anomaly Time Series Data` to data pane
7. Click `RUN` to create the visualization
8. In the visualization pane, select line chart visualization type and click on `Edit`
9. On `Plot` tab, uncheck `Plot Null Values`
10. On `Series` tab, select `Anomaly Times Series Data` and change `chart type` to **Scatter** and edit color as desired

>
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i> Note, to detect anomalies in new (or incoming) data,</font></b> reach out to your Looker Developer or Looker Professional Services team for customization to fit your use case.
>

## Resources

[Forecasting in Visualizations](​​https://docs.looker.com/exploring-data/visualizing-query-results/forecasting-in-visualizations)

[How to build a demand forecasting model with BigQuery ML](https://www.youtube.com/watch?v=EhnTBnNXnPY)

[BigQuery ML Documentation](https://cloud.google.com/bigquery-ml/docs)


### Find an error or have suggestions for improvements?
Blocks were designed for continuous improvement through the help of the entire Looker community, and we'd love your input. To log an error or improvement recommendations, simply create a "New Issue" in the corresponding Github repo for this Block. Please be as detailed as possible in your explanation, and we'll address it as quickly as we can.


#### Author: Google
