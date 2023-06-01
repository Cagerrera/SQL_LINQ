SELECT m, t, CAST(100.0*cc/cc1 AS NUMERIC(5,2))
FROM (
    SELECT m, t, SUM(c) cc
    FROM (
        SELECT DISTINCT maker m, 'PC' t, 0 c
        FROM product
        UNION ALL
        SELECT DISTINCT maker, 'Laptop', 0
        FROM product
        UNION ALL
        SELECT DISTINCT maker, 'Printer', 0
        FROM product
        UNION ALL
        SELECT maker, type, COUNT(*)
        FROM product
        GROUP BY maker, type
    ) AS tt
    GROUP BY m, t
) tt1
JOIN (
    SELECT maker, COUNT(*) cc1
    FROM product
    GROUP BY maker
) tt2 ON m = maker
