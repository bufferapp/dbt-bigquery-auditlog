  with data as
  (
    select
      protopayload_auditlog.authenticationInfo.principalEmail as email,
      protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent as jobCompletedEvent
    from
      {{ var('bigquery_auditlog_dataset.data_access') }}
  )
  select
    email,
    format('%9.2f',5.0 * (sum(jobCompletedEvent.job.jobStatistics.totalBilledbytes)/power(2, 40))) as estimated_cost_usd
  from
    data
  where
    jobCompletedEvent.eventName = 'query_job_completed'
  group by email
  order by estimated_cost_usd desc