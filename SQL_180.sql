SELECT e.last_name as defender, forward, game
FROM (
    SELECT zamenil, last_name as forward, game_id as game
    FROM (
        SELECT Lineups.player_id as zamenil, a.player_id as zamenen, a.game_id
        FROM (
            SELECT * FROM Lineups
            WHERE (time_in < 90 AND start = 'B') AND cards is NULL
        ) as a
        JOIN Lineups ON a.game_id = Lineups.game_id AND a.time_in + Lineups.time_in = 90
    ) as b
    INNER JOIN (
        SELECT player_id, last_name
        FROM Players
        WHERE role = 'FORWARD'
    ) as c ON b.zamenen = c.player_id
) as d
INNER JOIN (
    SELECT player_id, last_name
    FROM Players
    WHERE role = 'DEFENDER'
) as e ON d.zamenil = e.player_id
