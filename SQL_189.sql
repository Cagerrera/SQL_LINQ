WITH results (game, mygoals, theirgoals, points) AS
(SELECT a.game_id as game, (coalesce(SUM(a.goals),0) + coalesce(b.own,0)), coalesce(b.goals,0),
CASE
WHEN (coalesce(SUM(a.goals),0) + coalesce(b.own,0)) > coalesce(b.goals,0)
THEN 3
WHEN (coalesce(SUM(a.goals),0) + coalesce(b.own,0)) < coalesce(b.goals,0)
THEN 0
WHEN (coalesce(SUM(a.goals),0) + coalesce(b.own,0)) = coalesce(b.goals,0)
THEN 1
END as points
FROM Lineups as a
JOIN
Games as b ON a.game_id = b.game_id
GROUP BY a.game_id, b.goals, b.own)


SELECT DISTINCT
FIRST_VALUE(game) OVER (PARTITION BY groups ORDER BY game) as game_id,
FIRST_VALUE(games) OVER (PARTITION BY groups ORDER BY game) as games,
FIRST_VALUE(poinert) OVER (PARTITION BY groups ORDER BY game) as points
FROM (
SELECT game, groups,
COUNT(game) OVER (PARTITION BY groups ORDER BY game DESC) as games,
SUM(points) OVER (PARTITION BY groups ORDER BY game DESC) as poinert
FROM
(SELECT game, points, coalesce(MAX(groups), 0) as groups
FROM results as t
LEFT JOIN
(SELECT game as non,
ROW_NUMBER() OVER (ORDER BY game) AS groups
FROM results WHERE points = 0) as q ON t.game >= q.non GROUP BY game, points) as e WHERE points > 0) as e WHERE games >= 2 