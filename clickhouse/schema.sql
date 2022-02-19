CREATE TABLE IF NOT EXISTS filters (
  timestamp UInt64,
  userId Nullable(UInt32),
  sessionId Nullable(String),
  name String,
  value String,
  siteVersion Enum8('desktop' = 1, 'mobile' = 2, 'tablet_webview' = 3, 'mobile_webview' = 4),
  ccPath String
) ENGINE = Kafka SETTINGS kafka_broker_list = 'localhost:9092',
  kafka_topic_list = 'filters',
  kafka_group_name = 'statistics',
  kafka_format = 'JSONEachRow',
  kafka_num_consumers = 2;


CREATE TABLE IF NOT EXISTS filters_stats (
  timestamp UInt64,
  userId Nullable(UInt32),
  sessionId Nullable(String),
  name String,
  value String,
  siteVersion Enum8('desktop' = 1, 'mobile' = 2, 'tablet_webview' = 3, 'mobile_webview' = 4),
  ccPath String
) ENGINE = MergeTree()
ORDER BY timestamp;

CREATE MATERIALIZED VIEW IF NOT EXISTS filters_consumer TO filters_stats
  AS SELECT * FROM filters;