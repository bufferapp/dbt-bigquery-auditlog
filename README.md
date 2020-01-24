# BigQuery Auditlog

Get an overview of all cost and performance data for your BigQuery project.

## Getting Started

To use the logs from BigQuery we need to setup the [logging exports in GCP](https://cloud.google.com/bigquery/docs/reference/auditlogs/#overview).

1. Go to Stackdriver Logging _Logs Viewer_
2. Filter by `protoPayload.serviceName="bigquery.googleapis.com"` and Submit Filter
3. Click _Create Sink_, give it a name, select BigQuery as the destination and the output dataset. Check also the _Use Partitioned Tables_ option to improve performance and reduce costs in the long term.

Alternatively, you can create a logging sink using Google Cloud SDK running this command.

```bash
gcloud beta logging sinks create <sink_name> bigquery.googleapis.com/projects/<project-name>/datasets/<dataset-name> --log-filter='protoPayload.serviceName="bigquery.googleapis.com"'
```

### Installation

Include the following in your `packages.yml` file:

```yml
packages:
  - git: "https://github.com/bufferapp/dbt-bigquery-auditlog.git"
    revision: 0.0.1
```

Run `dbt deps` to install the package.

Add the source tables to your `dbt_project.yml`:

```yml
models:
  bigquery_auditlog:
    vars:
      "bigquery_auditlog_dataset.data_access": TABLE
      "bigquery_auditlog_dataset.activity": TABLE
```
