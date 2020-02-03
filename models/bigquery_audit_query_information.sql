select  
	protopayload_auditlog.authenticationInfo.principalEmail as user
  , protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobStatistics.totalProcessedBytes as bytes_scanned
  , protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobStatistics.startTime as start_time
  , protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobStatistics.endTime as end_time
  , protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobConfiguration.query.query
	, 5 * protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobStatistics.totalProcessedBytes/power(2,40) as cost_usd
from {{ var('bigquery_auditlog_dataset.data_access') }}
where protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.eventName="query_job_completed"
and protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobStatistics.totalProcessedBytes is not null