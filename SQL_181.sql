SELECT first_name, last_name, sum(iif(start='s',goals,0)) goals_s, sum(goals) goals
FROM Lineups l
JOIN Players p on p.player_id=l.player_id
GROUP BY  first_name, last_name, l.player_id
HAVING sum(iif(start='s',goals,0))> 0
