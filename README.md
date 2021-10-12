# ReadMe for LookML Developers


## About this LookML Block

Forecasting future points in a time series often provides tremendous value to a business. Imagine what accurate predictions of monthly sales, quarterly expenses, hourly inbound calls, daily product demand could do for your business--the applications are endless.

An **ARIMA** (autoregressive integrated moving average) model is a popular tool among data scientists for estimating future demand. This type of model uses past values in a time series to predict (forecast) future points while automatically detecting and correcting for anomalies, seasonality, and holiday effects. It is
With this Block, Looker developers can add this advanced analytical capability into new or existing Explores with a simple step-by-step workflow, no data scientists required. Business users can use Looker to train multiple time-series models, evaluate them, and access their forecasts in dashboards or custom analyses.


This Block integrates the BigQuery ML ARIMA Plus model including the following functionality:
- Infer the data frequency of the time series
- Handle irregular time intervals
- Handle duplicate timestamps by taking the mean value
- Interpolate missing data using local linear interpolation
- Detect and clean spike and dip outliers
- Detect and adjust abrupt step (level) changes
- Detect and adjust holiday effects
- Detect and adjust for seasonal patterns

With Looker + BQML, the forecasts and analysis are directly in the hands of business analysts.


## Block Requirements
An existing [BigQuery database connection](https://docs.looker.com/setup-and-management/database-config/google-bigquery#overview) with:
- **Service Account** with the `BigQuery Data Editor` and `BigQuery Job User` predefined roles
- **Persistent Derived Tables** (PDTs) enabled
- **Dataset for Looker PDTs** located in same multi-region location as training data defined in the Explore (see note below). This Block will also create tables/views in this dataset.

> <font size = "4"><font color="red"><b>Note:  BigQuery ML processes and stages data in the same location.</b></font></font> See [BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations) for more details.
>
> The example Explore included in this Block is based on BigQuery public dataset stored in the `US` multi-region location. Therefore, to use the Block’s example Explore the database connection must name a PDT dataset also located in the `US` multi-region. To use this Block with data stored in another region or multi-region, create another BigQuery connection in Looker with a PDT dataset located in the same region or multi-region.




> <font size = "4"><font color="red"><b>Note:  When using this Block with multiple database connections, each connection should use the same name for the PDT dataset.</b></font></font><br> During installation you will be asked for the name of the connection's Looker PDT dataset. This value will be added as a constant to the Block's project manifest file. By naming the dataset the same across connections, you will prevent references to the constant throughout the Block from breaking.


## Installation Steps
1. From the Looker Marketplace page for [BigQuery ML Time-Series Forecasting Block](/marketplace/view/bqml-arima), click `INSTALL` button on left
2. Review **license agreement** and click `Accept`
3. Review **required Looker permissions** and click `Accept`
4. Specify **configuration details**
    - Select **Connection Name** from dropdown. This value will be saved to the Block's manifest file for the constant named `CONNECTION_NAME`
    - Enter **name of dataset for Looker PDTs**. This value will be saved to the Block's manifest file for the constant name `looker_temp_dataset_name`. Value must match the selected connection's settings.
    - Click `INSTALL`

Upon successful completion of the installation, a green Check Mark and bar just below the “Search Marketplace” text bar.

## Building an Explore with the ARIMA Block

2. Create an IDE folder to save refinements for each new use case
3. Create refinements of the following LookML files in the use case's IDE folder:
  -  (REQUIRED) `input_data.view` - Include the sql definition for the input dataset. The dataset should include at least one date or timestamp column and one or more numerical fields containing time-series to be forecast.
  -  (REQUIRED) `model_name_suggestions.explore` - Add a *sql_always_where* clause to specify the `${model_info.explore} = explore_name`. This will prevent suggestions of ML models names created with other Explores.
  -  (OPTIONAL) `arima_training_data.view` - Specify allowed parameter values and a default value for "Select a Time Field" (e.g. date) and optionally hide the parameter. The "Select a Time Field" parameter requires the end user to select a field that uniquely identifies each point of the time series to be forecast.
4. Create a new LookML model for each use case (See [Example](https://github.com/looker/block-bqml-arima/blob/master/models/google_analytics_forecast.model.lkml))
  - Add include statements to include `bqml_arima.explore` file and all refinement files in your use case IDE folder
  - Create an Explore in the use case's LookML model that extends the `bqml_arima` Explore
  - Join `arima_forecast` to the extending Explore (*type: full_outer*) and define the JOIN criteria between `input_data` and `arima_forecast`

  > <font size = "4"><font color="red"><b>Note: Avoid using BigQuery `analytic functions` such as ROW_NUMBER() OVER() in the SQL definition of a use case's input data.</b></font></font> Including analytic functions may cause BigQuery to return an `InternalError` code when used with BigQuery ML functions. If your input data is missing a primary key, CONCAT(*field_1, field_2, ...*) two or more columns to generate a unique ID instead of using ROW_NUMBER() OVER().


## Enabling Business Users

This block comes with the following example Explore for enabling business users.
- BQML ARIMA Plus: Google Analytics Forecast


## Resources

[BigQuery ML Tutorial: Single time-series forecasting from Google Analytics data](https://cloud.google.com/bigquery-ml/docs/arima-single-time-series-forecasting-tutorial)

[BigQuery ML Documentation](https://cloud.google.com/bigquery-ml/docs)

[BigQuery ML Pricing](https://cloud.google.com/bigquery-ml/pricing#bqml)

[BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations)


### Find an error or have suggestions for improvements?
Blocks were designed for continuous improvement through the help of the entire Looker community, and we'd love your input. To log an error or improvement recommendations, simply create a "New Issue" in the corresponding Github repo for this Block. Please be as detailed as possible in your explanation, and we'll address it as quickly as we can.


#### Author: Google
