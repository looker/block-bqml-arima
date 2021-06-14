# ReadMe for LookML Developers


## About this LookML Block

An autoregressive integrated moving average (ARIMA) model can be used to predict (forecast) future points in a time-series while
automatically detecting and correcting for anomalies, seasonality, and holiday effects. It is a popular tool for data scientists
to estimate future demand, for example when creating retail sales or manufacturing production forecasts. Using this Block, Looker
developers can add this advanced analytical capability right into new or existing Explores, no data scientists required.

Using this Block, you can integrate Looker with BigQuery ML Time-series (ARIMA Plus) models to get the benefit of forecasting with
advanced analytics without needing to be an expert in data science.

BigQuery ML ARIMA Plus model includes the following functionality:
- Infer the data frequency of the time series
- Handle irregular time intervals
- Handle duplicate timestamps by taking the mean value
- Interpolate missing data using local linear interpolation
- Detect and clean spike and dip outliers
- Detect and adjust abrupt step (level) changes
- Detect and adjust holiday effects
- Detect and adjust for seasonal patterns

This Block gives business users the ability to do time-series forecasting from a new or exiting Explore. Explores created with
this Block can be used to train multiple time-series models,  evaluate them, and access their forecasts in dashboards or custom
analyses.


## Block Requirements

This Block requires a BigQuery database connection with the following:
- Service account with the **BigQuery Data Editor** and **BigQuery Job User** predefined roles
- PDTs enabled
- The Looker PDT dataset must be located in the `US` multi-region location to use this block's example Explores


## Implementation Steps

1. Install block from Looker Marketplace
  - Specify the name of a BigQuery connection and the connection's dataset for Looker PDTs
2. Create an IDE folder to save refinements for each new use case
3. Create refinements of the following LookML files in the use case's IDE folder:
  -  (REQUIRED) `input_data.view` - Include the sql definition for the input dataset. The dataset should include at least one date or timestamp column and one or more numerical fields containing time-series to be forecast.
  -  (RECOMMENDED) `model_name_suggestions.explore` - Add a *sql_always_where* clause to specify the `${model_info.explore} = *explore_name*`. This will prevent suggestions of ML models names created with other Explores.
  -  (OPTIONAL) `arima_training_data.view` - Specify allowed parameter values for "Select a Time Field" (e.g. created_date) and optionally hide the parameter. The "Select a Time Field" parameter requires the end user to select a field that uniquely identifies each point of the time series to be forecast.
4. Create a new LookML model for each use case
5. Add include statements to include `bqml_arima.explore` file and all refinement files in your use case IDE folder
6. Create an Explore in the use case's LookML model that extends the `bqml_arima` Explore
7. Join `arima_forecast` to the extending Explore (*type: full_outer*) and define the JOIN criteria between `input_data` and `arima_forecast`. (See [Example](/projects/bqml_arima_block/files/models/ecommerce_forecast.model.lkml))


## Enabling Business Users

This block comes with a [Quick Start Guide for Business Users](/projects/bqml_arima_block/documents/QUICK_START_GUIDE.md) and two example Explores.
- BQML ARIMA Plus: eCommerce Forecast
- BQML ARIMA Plus: Google Analytics Forecast


## Notes and Other Known Issues

BigQuery ML requires the target dataset for storing ML models be in the same location as the data used to
train the model. This block's example Explores use BiqQuery public data stored in the `US` multi-region location.
Therefore, to use the block's example Explores, your BiqQuery database connection must have a dataset for Looker
PDTs located in the `US` region. If you would like to use the block with data stored in other regions, simply
create another BigQuery connection in Looker with a Looker PDT dataset located in that region.

When using multiple BigQuery database connections with this block, it's recommended to use the same dataset
name for Looker PDTs in different BigQuery projects. This will prevent Looker PDT dataset references throughout
the block from breaking.
See [BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations) for more details.

Avoid using BigQuery analytic functions such as ROW_NUMBER() OVER() in the SQL definition of a use case's input data. Including
analytic functions may cause BigQuery to return an InternalError code when used with BigQuery ML functions. If your input data is
missing a primary key, CONCAT(*field_1, field_2, ...*) two or more columns to generate a unique ID instead of using ROW_NUMBER() OVER().


## Resources

[BigQuery ML Tutorial: Single time-series forecasting from Google Analytics data](https://cloud.google.com/bigquery-ml/docs/arima-single-time-series-forecasting-tutorial)

[BigQuery ML Documentation](https://cloud.google.com/bigquery-ml/docs)

[BigQuery ML Pricing](https://cloud.google.com/bigquery-ml/pricing#bqml)

[BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations)


### Find an error or have suggestions for improvements?
Blocks were designed for continuous improvement through the help of the entire Looker community, and we'd love your input. To log an error or improvement recommendations, simply create a "New Issue" in the corresponding Github repo for this Block. Please be as detailed as possible in your explanation, and we'll address it as quickly as we can.


#### Author: Chris Schmidt
