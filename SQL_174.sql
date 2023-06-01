SELECT first_name, last_name, COUNT(*)
FROM Players
INNER JOIN (
    SELECT player_id
    FROM (
        SELECT player_id
        FROM (
            SELECT player_id, game_id
            FROM Lineups
            WHERE start = 'S'
        ) a
        INNER JOIN (
            SELECT game_id
            FROM Games
            WHERE MONTH(game_date) = 12
        ) b ON a.game_id = b.game_id
    ) t
    WHERE player_id NOT IN (
        SELECT player_id
        FROM (
            SELECT player_id, game_id
            FROM Lineups
            WHERE start = 'B'
        ) c
        INNER JOIN (
            SELECT game_id
            FROM Games
            WHERE MONTH(game_date) = 12
        ) d ON c.game_id = d.game_id
    )
) q ON Players.player_id = q.player_id
GROUP BY first_name, last_name
HAVING COUNT(first_name) > 1
