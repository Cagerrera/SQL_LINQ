SELECT
  ROW_NUMBER() OVER(ORDER BY maker) AS num,
  CASE WHEN mnum=1 THEN maker ELSE '' END AS maker,
  type
FROM (
  SELECT
    ROW_NUMBER() OVER(PARTITION BY maker ORDER BY maker, ord) AS mnum,
    maker,
    type
  FROM (
    SELECT DISTINCT
      maker,
      type,
      CASE WHEN LOWER(type)='pc' THEN 1
           WHEN LOWER(type)='laptop' THEN 2
           ELSE 3
      END AS ord
    FROM product
  ) AS mto
) AS mtn
