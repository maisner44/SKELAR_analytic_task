
WITH user_ts AS (
  SELECT
    id_user,
    id_region,
    SUM(amount) AS total_spend
  FROM `nice-storm-456819-p6.task_1_2.task_1_2_table`
  WHERE status = 'success'
  GROUP BY id_user, id_region
),
avg_ts AS (
  SELECT
    id_region,
    AVG(total_spend) AS avg_ts
  FROM user_ts
  GROUP BY id_region
)
SELECT
  ut.id_user,
  ut.id_region,
  ut.total_spend,
  ROUND(a.avg_ts, 2) AS avg_ts
FROM user_ts ut
JOIN avg_ts a
  ON ut.id_region = a.id_region
WHERE ut.total_spend > a.avg_ts;