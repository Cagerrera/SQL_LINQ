SELECT last_name, first_name
FROM Players
LEFT JOIN Lineups ON Players.player_id = Lineups.player_id
WHERE Lineups.player_id IS NULL
UNION (
    SELECT last_name, first_name
    FROM Players
    INNER JOIN (
        SELECT *
        FROM (
            SELECT player_id
            FROM Lineups
            WHERE time_in IS NULL
        ) a
        WHERE player_id NOT IN (
            SELECT player_id
            FROM Lineups
            WHERE time_in IS NOT NULL
        )
        GROUP BY player_id
    ) a ON a.player_id = Players.player_id
)
