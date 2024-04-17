INSERT INTO mlbscores 
SELECT raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') ->> 'away' AS away_team,
    raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') ->> 'home' AS home_team,
    raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') ->> 'gameID' AS gameid,
    (raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') -> 'lineScore' -> 'away' ->> 'R')::INT AS away_team_score,
    (raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') -> 'lineScore' -> 'home' ->> 'R')::INT AS home_team_score
FROM scraper;

INSERT INTO mlbscores2
SELECT away_team, home_team, gameid, away_team_score, home_team_score,
CONCAT(month, '/', day, '/', year)::DATE AS gamedate FROM 
	(SELECT away_team, home_team, gameid, away_team_score, home_team_score,
   substring(gameid, 5,2) AS month, substring(gameid, 7,2) as day, substring(gameid, 1,4) as year FROM mlbscores);

DELETE FROM scraper;
