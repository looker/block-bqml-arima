# ReadMe for LookML Developers


## About this LookML Block

Forecasting future points in a time series often provides tremendous value to a business. Imagine what accurate predictions of monthly sales, quarterly expenses, hourly inbound calls, daily product demand could do for your business--the applications are endless.

An **ARIMA** (autoregressive integrated moving average) model is a popular tool among data scientists for estimating future demand. This type of model uses past values in a time series to predict (forecast) future points while automatically detecting and correcting for anomalies, seasonality, and holiday effects. With this Block, Looker developers can add this advanced analytical capability into new or existing Explores with a simple step-by-step workflow. Business users can use Looker to create a time-series model, evaluate the model, and access forecasts in dashboards or custom analyses.


This Block integrates the **BigQuery ML ARIMA PLUS model** including the following functionality:
- Infer the data frequency of the time series
- Handle irregular time intervals
- Handle duplicate timestamps by taking the mean value
- Interpolate missing data using local linear interpolation
- Detect and clean spike and dip outliers
- Detect and adjust abrupt step (level) changes
- Detect and adjust holiday effects
- Detect and adjust for seasonal patterns

With Looker + BQML, the forecasts and analysis are directly in the hands of business analysts.

---
> <b><font size = "3" color="#174EA6"> <i class='fa fa-info-circle'></i>  Reach out to your Looker account team if you would like to partner with Looker Professional Services to implement this Looker + BQML block or customize to support multiple time series models in a single query or to support your unique use case.</font></b>

---

## Block Requirements
### 1. An existing [BigQuery database connection](https://docs.looker.com/setup-and-management/database-config/google-bigquery#overview):
- using **Service Account** with the `BigQuery Data Editor` and `BigQuery Job User` predefined roles. Note a connection using BigQuery OAuth cannot be used as Persistent Derived Tables are not allowed.

- with **Persistent Derived Tables** (PDTs) enabled

### 2. **BigQuery Dataset for storing ARIMA PLUS model details and related tables**
- This dataset could be the same one named in your connection for Looker PDTs but does not have to be. The Service Account named in your Looker data connection must have read/write access to the dataset you choose.

- The dataset must be located in the same multi-region location as your use case data defined in the Explore (see note below). This Block creates multiple tables and views in this dataset.

During installation you will be asked for the connection and dataset name. These values will be added as constants to the Block's project manifest file. These constants will be referenced throughout the Block as ARIMA models are created.

---
 <font size = "3"><font color = "red"> <i class='fa fa-exclamation-triangle'></i><b> note:  BigQuery ML processes and stages data in the same location.</b></font></font><br> See [BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations) for more details. The example Explore included in this Block is based on BigQuery public dataset stored in the `US` multi-region location. Therefore, to use the Block’s example Explore you should name a dataset also located in the `US` multi-region. To use this Block with data stored in region or multi-region outside of the `US`, name a ARIMA model dataset located in the same region or multi-region and use refinements to hide the example Explore as it will not work in regions outside of the `US`.


 <font size = "3"><font color="red"><i class='fa fa-exclamation-triangle'></i><b> note: This Block is intended to be used with only one data connection and one dataset for model processing.</b></font></font><br>If you would like to use Block with multiple data connections, customization of the Block is required. Reach out to your Looker account team for more information and guidance from Looker Professional Services.

---


## Installation Steps
1. From the Looker Marketplace page for [BigQuery ML Time-Series Forecasting Block](/marketplace/view/bqml-arima), click `INSTALL` button
2. Review **license agreement** and click `Accept`
3. Review **required Looker permissions** and click `Accept`<br>_note these permissions allow Marketplace to install the Block and are not related to user or developer permissions on your instance_
4. Specify **configuration details**
    - Select **Connection Name** from dropdown. This value will be saved to the Block's manifest file for the constant named `CONNECTION_NAME` and referenced throughout the Block.
    - Enter **name of dataset for storing Model details and related tables**. This value can be the same dataset used for Looker PDTs as defined in the selected connection. This value will be saved to the Block's manifest file for the constant name `looker_temp_dataset_name` and referenced throughout the Block.

Upon successful completion of the installation, a green Check Mark and bar will appear. These new objects are installed:

| type | name | description |
| -------- | -------- | ---------- |
| project | marketplace_bqml-arima |
| explore | BQML ARIMA Plus: Google Analytics Forecast | found in Explore menu under Looker + BigQuery ML |
| explore | BQML ARIMA Plus: Model Info  | found in Explore menu under Looker + BigQuery ML; captures details for each ARIMA model created with the Block |

---
 <font size = "3"><font color="red"><i class='fa fa-exclamation-triangle'></i><b> note:  The marketplace_bqml-arima project is installed as a bare GIT repository.</b></font></font><br>For version control utilizing a remote repository, you will need to [update the connection settings for your Git repository](https://docs.looker.com/data-modeling/getting-started/setting-up-git-connection).

---

At this point you can begin creating your own Explores incorporating the ARIMA model workflow (see next section for details on building your own Explores) or navigate to the included explore example and create an ARIMA model.

## Building an Explore with the ARIMA Block

The installed Block provides a workflow template as part of an Explore to guide a business user through the steps necessary to create and evaluate an ARIMA model. As seen in the provided Explore `BQML ARIMA Plus: Google Analytics Forecast`, a user navigates through a series of steps to create and evaluate daily predictions of Google Analytics metrics like visits, transactions, etc. The workflow steps are:
> <b>[1] BQML: Input Data<br>
> [2] BQML: Name Your Model<br>
> [3] BQML: Select Training Data<br>
> [4] BQML: Set Model Parameters<br>
> [5] BQML: Create Model<br>
> [6] BQML: Evaluation Metrics & Coefficients<br>
> [7] BQML: Forecast<br>
> [8] BQML: Detect Anomalies</b>

For each use case, a LookML developer will create an Explore incorporating the workflow template by changing the Input Data to match a specific use case. For example, your use case may be a forecast of monthly sales. You would add a new model and explore the `marketplace_bqml-arima project` extending the ARIMA explore with the workflow already defined and modifying the input data to capture monthly sales for the desired time series forecast.

At a high-level the steps for each use case are:
><b>1)  Create Folder for all Use Case files<br>
>2)  Add New Model <br>
>3)  Make Refinements of select Explores and Views <br>
>4)  Add New Explore which Extends the Block's ARIMA Explore <br></b>

Details and code examples for each step are provided next. Note, all steps take place in `marketplace_bqml-arima` project while in **development mode**.

---
 <font size = "3"><font color="red"><i class='fa fa-exclamation-triangle'></i><b> note:  If copying/pasting example LookML from this document, ensure quotation marks are straight quotes (") </b></font></font><br>When pasting from this document, quotations may appear as curly or smart quotes (“). If necessary, re-type quotes in the LookML IDE to change to straight quotes.

---


### 1. Create Folder for all Use Case files (one folder per use case)
When you open the `marketplace_bqml-arima` project while in development mode and review the `File Browser` pane, you will see the project contains a folder called `imported_projects`. Expanding this folder you will see a subfolder named `bqml-arima`. This folder contains all the models, explores and views for the Block. These files are read-only; however, we will be including these files in the use case model and refining/extending a select few files to support the use case. You should keep all files related to the use case in a single folder. Doing so will allow easy editing of a use case. Within the project, you should create a separate folder for each use case.

| steps | example |
| -- | -- |
| Add the folder at the project's root level by clicking + at the top of `File Browser` | |
| Select Create Folder | |
| In the Create File pop-up, enter a `Name` for the use case folder<br> Note, you should use also use this same name for the Model and Explore created in next steps | monthly_sales_arima |
| Click `CREATE` |

### 2. Add New Model
Add a new model file for the use case, update the connection, and add include statements for the Block's ARIMA Explore and use case refinement files. The included Explore from the Block will be extended into the use case Explore which will be created in the next step.

| steps | example |
| -- | -- |
| From `File Browser` pane, navigate to and click on the Use Case Folder created in prior step | |
| To create the file insider the folder, click the folder's menu (found just to the right of the folder name) | |
| Select Create Model | |
| In the Create File pop-up, enter a `Name` for the use case folder  | monthly_sales_arima |
| Click `CREATE` |
| Within newly created model file, set `connection:` parameter to value used during installation of this Block | connection: thelook_bq |
| Add an include statement for all view files found in same directory (note, you may receive a warning files cannot be found but you can ignore as files will be added in following steps)| include: "*.view" |
| Add an include statement for all Explore files found in same directory (note, you may receive a warning files cannot be found but you can ignore as files will be added in following steps) | include: "*.explore" |
| Add an include statement for the Block's `bqml-arima.explore` so the file is available to this use case model and can be extended into the new Explore created in the next step.| include: "//bqml-arima/**/bqml_arima.explore" |
| Click `SAVE` | |


### 3. Make Refinements of select Explores and Views from the Block
Just like we used the bqml-arima explore as a building block for the use case explore, we will adapt the Block's `input_data.view`, `model_name_suggestions.explore` and `arima_training_data.view` for the use case using LookML refinements syntax. To create a refinement you add a plus sign (+) in front of the name to indicate that it's a refinement of an existing view. All the parameters of the existing view will be used and select parameters can be modified (i.e., overwrite the original value). For detailed explanation of refinements, refer to the [LookML refinements](https://docs.looker.com/data-modeling/learning-lookml/refinements) documentation page. Within the use case folder, add a new `input_data.view`, a new `model_name_suggestions.explore` and optionally add a new `arima_training_data.view`. Keep reading for detailed steps for each refinement file.


#### <font size=5>3a. input_data.view </font><font color='red'> (REQUIRED)

An ARIMA PLUS model uses past values in a time series to predict (forecast) future points. The input_data.view is where you define the data to use as input into the model. The Block's example input_data.view is a SQL derived table, so the use case refinement will update the derived_table syntax and all dimensions and measures to match the use case. We recommend using SQL Runner to test your query and generate the Derived Table syntax (see [SQL Runner](https://docs.looker.com/data-modeling/learning-lookml/sql-runner-create-dts) documentation for more information). The steps are below.

| steps | example |
| -- | -- |
| From `File Browser` pane, navigate to and click on the Use Case Folder | |
| To create the file insider the folder, click the folder's menu (found just to the right of the folder name) | |
| Select `Create View` | |
| In the Create File pop-up, enter `input_data` <br><br>While this file name does not have to match the original filename, we recommend you keep it the same.| input_data |
| Click `CREATE` |
| Navigate to SQL Runner by clicking on the `Develop` Menu and selecting `SQL Runner` | |
| In left pane, change `Connection` to match the connection defined during installation of this Block (see project's manifest file and value for `@CONNECTION_NAME`)  | @CONNECTION_NAME = thelook_bq |
| Write and test your SQL query to produce the desired dataset. At minimum, the query must return a time series field and one measure. The provided example creates a simple dataset with create_month and total sales. | SELECT<br>date_trunc(created_at,MONTH) as create_month<br>,sum(order_amount) as order_amount<br>FROM `ecommerce.order_facts` <br>where created_at is not null<br>group by 1|
| Once the results are as expected, click the `gear` menu (next to the Run button) and select `Get Derived Table LookML`. | |
| Copy the generated LookML (all lines) | |
| Navigate back to `input_data.view` in your Use Case Folder | |
| Delete all the notes in the file which were auto-generated when you created the file | |
| Paste the contents from SQL Runner into the file | |
| On line 1 of the file insert include statement for the Block view to be refined | include: "//bqml-arima/**/input_data.view" |
| Replace `view: sql_runner_query` with `view: +input_data` <br> <br>The plus sign (+) indicates we are modifying/refining the original input_data view defined for the Block | view: +input_data |
| Review the remaining LookML and edit as necessary with:<br>a. names, labels, group labels, descriptions<br>b. identify the primary key field<br>c. Modify date formats as necessary. For example, dates are automatically defined as a `dimension_group with type of time` so modify as necessary for timeframes or convert to a single date dimension.<d> Add any additional measures if needed (only the count measure is created by default) | dimension: create_month {<br>  type: date<br>  primary_key: yes<br>  sql: <br>${TABLE}.create_month ;;<br>} |
| Click `SAVE` | |

---
   <font size = "3"><font color="red"><i class='fa fa-exclamation-triangle'></i><b> note: Avoid using BigQuery analytic functions such as ROW_NUMBER() OVER() in the SQL definition of a use case's input data.</b></font></font> Including analytic functions may cause BigQuery to return an `InternalError` code when used with BigQuery ML functions. If your input data is missing a primary key, CONCAT(*field_1, field_2, ...*) two or more columns to generate a unique ID instead of using ROW_NUMBER() OVER().

---


#### <font size=5>3b. model_name_suggestions.explore </font><font color='red'> (REQUIRED)
To create an ARIMA model, the user must enter a name for the model and can type in any string value. The ARIMA Explore also allows the user to evaluate a model which has already been created. The `Model Name` parameter allows users to select the name from a list of existing models created by the given Explore. These suggested values come from the `BQML_ARIMA_MODEL_INFO` table stored in the Model Details dataset defined for the Block during installation. Because this table captures details for all models created with the Block across all Explores, we need to filter the suggestions by Explore name–the Explore which will be created next in `Implementation Step 4`. If you do not filter for the use case Explore, an error would occur if the user tries to evaluate a model based on different time series data.

The name suggestions come from the `model_name_suggestions.explore` and in this step we will refine the `sql_always_where` filter applied to the include the use case Explore name.

| steps | example |
| -- | -- |
| From `File Browser` pane, navigate to and click on the Use Case Folder | |
| To create the file insider the folder, click the folder's menu (found just to the right of the folder name) | |
| Select Create Generic LookML File | |
| In the Create File pop-up, enter `model_name_suggestions.explore` <br><br>While this file name does not have to match the original filename, we recommend you keep it the same. Be sure to include the `.explore` extension so you can quickly identify the type from the File Browser. | model_name_suggestions.explore |
| Click `CREATE` |
| On line 1 of the blank file, insert include statement for the Block explore to be refined | include: "//bqml-arima/**/model_name_suggestions.explore" |
| On the next lines, enter<br> a. the explore name using the + refinement syntax<br> b. update sql_always_where syntax with use case explore name | explore: +model_name_suggestions {<br>  sql_always_where: ${model_info.explore} =<font color='orange'><b>'monthly_sales_arima'</b></font>;;<br>} |


#### <font size=5>3c. arima_training_data.view </font><font color='red'> (OPTIONAL)
As part of the create ARIMA model workflow, the user is required to include the `Select a Time Field` parameter and pick the field that uniquely identifies each point of the time series. By default the list of suggested fields comes from all the columns defined in the `input_data.view` and cannot be filtered to include only dates and times (as data types cannot be determined). If the list of columns in the input_data view is large, the user may have difficulty finding the time series field.

While the parameter suggestions work as is and do not require any modification, you may elect to improve the user experience with a standard list of choices for the time series field (e.g., list only date, month, hour). Or you could specify a default field which matches the `input_data` primary key and hide the parameter, thereby eliminating this step from the user's workflow. If you would like to modify the `Select a Time Field` parameter, follow these steps.

| steps | example |
| -- | -- |
| From `File Browser` pane, navigate to and click on the Use Case Folder | |
| To create the file insider the folder, click the folder's menu (found just to the right of the folder name) | |
| Select Create View | |
| In the Create File pop-up, enter `arima_training_data` <br><br>While this file name does not have to match the original filename, we recommend you keep it the same.| arima_training_data |
| Click `CREATE` |
| On line 1 of the file insert include statement for the Block view to be refined | include: "//bqml-arima/**/arima_training_data.view" |
| Replace `view: arima_training_data` with `view: +arima_training_data` <br> <br>The plus sign (+) indicates we are modifying/refining the original arima_training_data view defined for the Block | view: +arima_training_data |
| If you want to specify the list of time series fields:<br>a. delete the auto-generated comments added when view file was created<br>b.update parameter: select_time_field with allowed_values for each time series field<br> <br><font color='red'><i class='fa fa-exclamation-triangle'></i> note: Using an allowed list could lead to errors if user selects value not included in the Input Data view</font>| parameter: select_time_column {<br>    <font color='orange'><b>allowed_value: {label: "Date" value: "create_date"}<br>    allowed_value: {label: "Month" value: "create_month"}</b></font><br>} |
| If you want to set the default and hide the parameter:<br>a. delete the auto-generated comments added when view file was created<br>b.update parameter: select_time_field with default value equal to primary key of the `input_data` view and set hidden to yes<br> <br><font color='red'><i class='fa fa-exclamation-triangle'></i> note: Using a default means the `input_data` view defined for the use case Explore must contain a field matching the default value otherwise an error may occur.</font> | parameter: select_time_column {<br>    <font color = 'orange'><b>default_value: "create_month"<br>    hidden: yes<br></b></font> } |
| Click `SAVE`| |

If you decide to remove this optional refinement, simply delete the arima_training_data.view from the use case folder.

### 4. Add New Explore which Extends the Block's ARIMA Explore
As noted earlier, all the files related to this Block are found in the `imported_projects\bqml-arima` directory. The Explore file `bqml-arima.explore` specifies all the views and join relationships to generate the stepped workflow the user will navigate through to create and evaluate an ARIMA PLUS model. For each use case, you will use the `bqml-arima` Explore as a starting point by extending it into a new Explore. The new Explore will build upon the content and settings from the original Explore and modify some of the components to fit the use case. See the [extends for Explores](https://docs.looker.com/reference/explore-params/extends) documentation page for more information on extends. In an earlier step, we added the `include: "//bqml-arima/**/bqml_arima.explore"` statement to the model file so that we could use this explore for the use case. Below are the steps for adding a new explore to the use case model file.

| steps | example                |
| -- | -- |
| Open the Use Case Model file | monthly_sales_arima.model |
| Add Explore LookML which <br> a. includes label, group_label and/or description relevant to your use case<br>b. extends the bqml-arima explore<br>c. updates the join parameters of `arima_explain_forecast` and `arima_detect_anomalies` to reflect correct date/time field to properly join to `input_data` <br> <br>The BQML ARIMA PLUS model output generates a forecast for the unit of time modeled (named __time_series_timestamp__ and defined as time dimension_group). <br><br>In the previous section, you defined the `input_data` view and the date/time field for the time series to be modeled (e.g., create_date, create_month). Because the ARIMA output produces a timestamp field with the generic name of `time_series_raw`, you will need to update the Explore to incorporate the correct join relationships between the `input_data` time series field and the time series field in ARIMA Forecasts and Anomaly Detection. Be sure to reference a timestamp field or if the time series is defined as a dimension group of `type: time` use the `raw` reference (e.g., ${create_date_raw}).  |explore: <font color='orange'><b>monthly_sales_arima</b></font> {<br>  label: <font color='orange'>"BQML ARIMA Plus: Monthly Sales ARIMA"</font><br>  description: <font color='orange'>"Use this Explore to create BQML ARIMA Plus models to forecast monthly sales"</font><br><br>  extends: [bqml_arima] <br><br>   join: arima_explain_forecast {<br>    type:full_outer<br>    relationship: one_to_one<br>    sql_on: <font color = 'orange'><b>${input_data.create_date_raw}</b></font> = ${arima_explain_forecast.time_series_raw} ;;<br>  } <br><br> join: arima_detect_anomalies {<br>    type:left_outer<br>    relationship: one_to_one<br>    sql_on: <font color = 'orange'><b>${input_data.create_date_raw}</b></font> = ${arima_detect_anomalies.time_series_raw} ;; <br>}|
| Click `SAVE`| |


## ARIMA Plus CREATE MODEL Syntax

With this block, the user will be able to control these options for the ARIMA Plus Model:

| options | description | default |
| -- | -- | -- |
| model name | name of the BigQuery ML model that you're creating or replacing |
| time_series_timestamp_col | The timestamp column name for time series models |
| time_series_data_col | The data column name for time series models |
| horizon | The number of time points to forecast | 1,000 |
| holiday_region | The geographical region based on which the holiday effect is applied in modeling | none |

The `time_series_id_col` which allows you to forecast multiple time series in a single query is not included. All other options use the default values. For information about all the possible options for the ARIMA Plus Model, see the [Create Model Syntax documentation](https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-create-time-series#create_model_syntax).

Note, this block could be customized to include additional options and parameters.


## Enabling Business Users

This block comes with a [Quick Start Guide for Business Users](https://github.com/looker/block-bqml-arima/blob/master/QUICK_START_GUIDE.md) and the following example Explore for enabling business users.
- BQML ARIMA Plus: Google Analytics Forecast


## Resources

[BigQuery ML Tutorial: Single time-series forecasting from Google Analytics data](https://cloud.google.com/bigquery-ml/docs/arima-single-time-series-forecasting-tutorial)

[BigQuery ML Documentation](https://cloud.google.com/bigquery-ml/docs)

[BigQuery ML Pricing](https://cloud.google.com/bigquery-ml/pricing#bqml)

[BigQuery ML Locations](https://cloud.google.com/bigquery-ml/docs/locations)


### Find an error or have suggestions for improvements?
Blocks were designed for continuous improvement through the help of the entire Looker community, and we'd love your input. To log an error or improvement recommendations, simply create a "New Issue" in the corresponding Github repo for this Block. Please be as detailed as possible in your explanation, and we'll address it as quickly as we can.


#### Author: Google
