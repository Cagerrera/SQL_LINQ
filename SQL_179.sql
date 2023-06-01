SELECT first_name, last_name
FROM Players
INNER JOIN (
    SELECT c.player_id
    FROM (
        SELECT player_id
        FROM (
            SELECT player_id
            FROM Lineups
            WHERE start = 'S'
        ) a
        WHERE player_id NOT IN (
            SELECT player_id
            FROM Lineups
            WHERE start = 'B'
        )
    ) c
    INNER JOIN (
        SELECT player_id
        FROM Lineups
        WHERE time_in > 0
    ) d ON c.player_id = d.player_id
) e ON Players.player_id = e.player_id
GROUP BY first_name, last_name
