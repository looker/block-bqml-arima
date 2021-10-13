# ReadMe for LookML Developers


## About this LookML Block

Forecasting future points in a time series often provides tremendous value to a business. Imagine what accurate predictions of monthly sales, quarterly expenses, hourly inbound calls, daily product demand could do for your business--the applications are endless.

An **ARIMA** (autoregressive integrated moving average) model is a popular tool among data scientists for estimating future demand. This type of model uses past values in a time series to predict (forecast) future points while automatically detecting and correcting for anomalies, seasonality, and holiday effects. With this Block, Looker developers can add this advanced analytical capability into new or existing Explores with a simple step-by-step workflow, no data scientists required. Business users can use Looker to train multiple time-series models, evaluate them, and access their forecasts in dashboards or custom analyses.


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
### 1. An existing [BigQuery database connection](https://docs.looker.com/setup-and-management/database-config/google-bigquery#overview) with:
- **Service Account** with the `BigQuery Data Editor` and `BigQuery Job User` predefined roles. Note BigQuery OAuth connection cannot be used.
- **Persistent Derived Tables** (PDTs) enabled

### 2. **BigQuery Dataset for capturing model details**
- This dataset could be the same one named in your connection for Looker PDTs but does not have to be. The Service Account named in your Looker data connection must have read/write access to the dataset you choose.
- The dataset must be located in same multi-region location as your use case data as defined in the Explore (see note below). This Block creates multiple tables in this dataset.

During installation you will be asked for the connection and dataset name. These values will be added as constants to the Block's project manifest file. These constants will be referenced throughout the Block as ARIMA models are created.


> <font size = "3"><font color="red"><b>Note:  BigQuery ML processes and stages data in the same location.</b></font></font> See [BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations) for more details.
>
> The example Explore included in this Block is based on BigQuery public dataset stored in the `US` multi-region location. Therefore, to use the Block’s example Explore the database connection must name a PDT dataset also located in the `US` multi-region. To use this Block with data stored in another region or multi-region, create another BigQuery connection in Looker with a PDT dataset located in the same region or multi-region.


> <font size = "3"><font color="red"><b>Note:  This Block is intended to be used with only one data connection and one dataset for model processing.</b></font></font><br>If you would like to use Block with multiple data connections, customization of the Block is required. Reach out to Looker Professional Services for more information and guidance.



## Installation Steps
1. From the Looker Marketplace page for [BigQuery ML Time-Series Forecasting Block](/marketplace/view/bqml-arima), click `INSTALL` button on left
2. Review **license agreement** and click `Accept`
3. Review **required Looker permissions** and click `Accept`
4. Specify **configuration details**
    - Select **Connection Name** from dropdown. This value will be saved to the Block's manifest file for the constant named `CONNECTION_NAME`
    - Enter **name of dataset for Looker PDTs**. This value will be saved to the Block's manifest file for the constant name `looker_temp_dataset_name`. Value must match the selected connection's settings.
    - Click `INSTALL`

Upon successful completion of the installation, a green Check Mark and bar just below the “Search Marketplace” text bar. These new objects are installed:

| type | name | description |
| -------- | -------- | ---------- |
| project | marketplace_bqml-arima |
| explore | BQML ARIMA Plus: Google Analytics Forecast | found in Explore menu under Looker + BigQuery ML |
| explore | BQML ARIMA Plus: Model Info  | found in Explore menu under Looker + BigQuery ML; captures details for each ARIMA model created with the Block |

At this point you can begin creating your own explores incorporating this block (see next section for details on building your own explores) or navigate to the included explore example and create an ARIMA model (see README for Business Users).

## Building an Explore with the ARIMA Block

The installed Block provides a workflow template as part of an Explore to guide a business user through the steps necessary to create and evaluate an ARIMA model. As seen in the provided Explore `BQML ARIMA Plus: Google Analytics Forecast`, a user navigates through series of steps **[1] BQML: Input Data**, **[2] BQML: Name Your Model**, **[3] BQML: Select Training Data** and so on in order to create and evaluate daily predictions of Google Analytics metrics like visits, transactions, etc.

For each use case, a LookML developer will create an Explore incorporating the workflow template but changing the Input Data to match a specific use case. For example, your use case may be a forecast of monthly sales. You would add a new model  to marketplace_bqml-arima project and include elements of the ARIMA block while making refinements for the input data and explore definition.
At a high-level the steps are:

> <b> 1. Create Folder for all Use Case files </b>
> <b> 2. Add New Model </b>
> <b> 3. Add New Explore which Extends the Block's Explore </b>
> <b> 4. Make Refinements of select Explores and Views from the Block</b>

Details and code examples for each step are provided next.
Note, all steps take place in `marketplace_bqml-arima` project while in development mode.

### 1. Create Folder for all Use Case files
When you open `marketplace_bqml-arima` project while in development mode and review the `File Browser` pane, you will see the project contains a folder called `imported_projects`. Expanding this folder you will see a subfolder named `bqml-arima`. This folder contains all the models, explores and views for the Block. These files are read-only; however, we will be including these files in the use case model and refining/extending a select few files to support the use case. You should keep all files related to the use case in a single folder. Doing so will allow easy editing of a use case. Within the project, you should create a separate folder for each use case.

| steps | example |
| -- | -- |
| Add the folder at the project's root level by clicking + at the top of `File Browser` | |
| Select Create Folder | |
| In the Create File pop-up, enter a `Name` for the use case folder | `monthly_sales_arima` (You may use the same use case name for the Model and Explore created in next steps) |
| Click `CREATE` |

### 2. Add New Model
Add a new model file for the use case, update the connection, and add include statements for the Block's explore and use case refinement files. The include explore from the Block will be extended into the use case explore which will be created in next step.

| steps | example |
| -- | -- |
| From `File Browser` pane, navigate to and click on the Use Case Folder created in prior step | |
| To create the file insider the folder, click the folder's menu (found just to the right of the folder name) | |
| Select Create Model | |
| In the Create File pop-up, enter a `Name` for the use case folder  | monthly_sales_arima |
| Click `CREATE` |
| Within newly created model file, edit the `connection:` parameter with correct value | connection: thelook_bq |
| Add include parameter for all view files found in same directory (note, you may receive a warning no files are found but can ignore as we will add those files in following steps)| include: '*.view' |
| Add include parameter for all explore files found in same directory (note, you may receive a warning no files are found but can ignore as we will add those files in following steps) | include: '*.explore' |
| Add include parameter for the Block's bqml-arima.explore so the file is available to this use case model and can be extended into the new explore which will be created in next step.| include: "//bqml-arima/**/bqml_arima.explore" |
| Click `SAVE` | |

### 3. Add New Explore which Extends the Block's Explore
As noted earlier all the files related to this block are found in the `imported_projects\bqml-arima` directory. The explore file `bqml-arima.explore` specifies all the views and join relationships to generate the [1], [2], [3]...[N] stepped workflow the user will navigate through to create evaluate an ARIMA model. For a specific use case, you will use the bqml-arima explore as a starting point by extending it into a new explore. The new explore will build upon the content and settings from the bqml-arima explore and modify some of the parameters to fit the use case. See the [extends for Explores](https://docs.looker.com/reference/explore-params/extends) documentation page for more information on extends. In the previous step, we added the `include: "//bqml-arima/**/bqml_arima.explore"` statement to the model file so that we could use this explore for the use case. Below are the steps for adding a new explore to the use case model file.

| steps | example                |
| -- | -- |
| Open the Use Case Model file | monthly_sales_arima.model |
| Add Explore LookML which <br> a. includes label, group_label and/or description relevant to your use case<br>b. extends the bqml-arima explore<br>c. updates the join parameter between `arima_forecast` and `input_data` to reflect correct unit of time<br>The BQML ARIMA model output generates a forecast for the unit of time modeled and is named __forecast_date__. <br>The unit of time modeled could vary by use case (e.g., month, day, hour), so need to update the explore to capture the correct unit of time defined in the use case's `input_data` file (note we will walk through steps of generating this file as part of the Refinement steps).<br><br>In the example, edit the terms in <b><font color='orange'>orange</font></b> to fit your use case.|explore: <font color='orange'><b>monthly_sales_arima</b></font> {<br>  label: <font color='orange'>"BQML ARIMA Plus: Monthly Sales ARIMA"</font><br>  description: <font color='orange'>"Use this Explore to create BQML ARIMA Plus models to forecast monthly sales"</font><br><br>  extends: [bqml_arima] <br><br>   join: arima_forecast {<br>    type:full_outer<br>    relationship: one_to_one<br>    sql_on: <font color = 'orange'><b>${input_data.create_month}</b></font> = ${arima_forecast.forecast_date} ;;<br>  }<br>} |
| Click `SAVE`| |

Note, you may receive a warning that the field you entered in the JOIN for input_data does note exist. This warning can be ignored for now as we will create the refinement view in the next step.

### 4. Make Refinements of select Explores and Views from the Block
Just like we used the bqml-arima explore as a building block for the use case explore, we will adapt the Block's `input_data.view`, `model_name_suggestions.explore` and `arima_training_data.view` for the use case using LookML refinements syntax. To create a refinement you add a plus sign (+) in front of the name to indicate that it's a refinement of an existing view. All the parameters of the existing view will be used and select parameters can be modified (and overwrite the original value). For detailed explanation of refinements, refer to the [LookML refinements](https://docs.looker.com/data-modeling/learning-lookml/refinements) documentation page. Within the use case folder, add a new `input_data.view`, a new `model_name_suggestions.explore` and optionally add a new `arima_training_data.view`.


#### input_data.view
An ARIMA model uses past values in a time series to predict (forecast) future points. The input_data.view is where you define the data to use as input into the model. The Block's example input_data.view is a SQL derived table, so the use case refinement will update the derived_table syntax and all dimensions and measure to match the use case. We recommend using SQL Runner to test your query and generate the Derived Table syntax. The steps are below.


  > <font size = "3"><font color="red"><b>Note: Avoid using BigQuery analytic functions such as ROW_NUMBER() OVER() in the SQL definition of a use case's input data.</b></font></font> Including analytic functions may cause BigQuery to return an `InternalError` code when used with BigQuery ML functions. If your input data is missing a primary key, CONCAT(*field_1, field_2, ...*) two or more columns to generate a unique ID instead of using ROW_NUMBER() OVER().


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
