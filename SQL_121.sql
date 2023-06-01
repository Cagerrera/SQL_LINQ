WITH t AS (
    SELECT name, launched,
        (
            SELECT CASE WHEN s.launched IS NULL THEN MAX(date) ELSE MIN(date) END
            FROM Battles
            WHERE YEAR(date) >= COALESCE(s.launched, 0)
        ) AS date
    FROM Ships s
)
SELECT t.name, t.launched, b.name
FROM t
LEFT JOIN Battles b ON t.date = b.date
