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

SELECT
	CASE
  	WHEN away_team LIKE 'ARI' THEN 1
    WHEN away_team LIKE 'ATL' THEN 2
    WHEN away_team LIKE 'BAL' THEN 3
    WHEN away_team LIKE 'BOS' THEN 4
    WHEN away_team LIKE 'CHC' THEN 5
    WHEN away_team LIKE 'CHW' THEN 6
    WHEN away_team LIKE 'CIN' THEN 7
    WHEN away_team LIKE 'CLE' THEN 8
    WHEN away_team LIKE 'COL' THEN 9
    WHEN away_team LIKE 'DET' THEN 10
    WHEN away_team LIKE 'HOU' THEN 11
    WHEN away_team LIKE 'KC' THEN 12
    WHEN away_team LIKE 'LAA' THEN 13
    WHEN away_team LIKE 'LAD' THEN 14
    WHEN away_team LIKE 'MIA' THEN 15
    WHEN away_team LIKE 'MIL' THEN 16
    WHEN away_team LIKE 'MIN' THEN 17
    WHEN away_team LIKE 'NYM' THEN 18
    WHEN away_team LIKE 'NYY' THEN 19
    WHEN away_team LIKE 'OAK' THEN 20
    WHEN away_team LIKE 'PHI' THEN 21
    WHEN away_team LIKE 'PIT' THEN 22
    WHEN away_team LIKE 'SD' THEN 23
    WHEN away_team LIKE 'SF' THEN 24
    WHEN away_team LIKE 'SEA' THEN 25
    WHEN away_team LIKE 'STL' THEN 26
    WHEN away_team LIKE 'TB' THEN 27
    WHEN away_team LIKE 'TEX' THEN 28
    WHEN away_team LIKE 'TOR' THEN 29
    WHEN away_team LIKE 'WAS' THEN 30
  END AS away_id,
  CASE
  	WHEN home_team LIKE 'ARI' THEN 1
    WHEN home_team LIKE 'ATL' THEN 2
    WHEN home_team LIKE 'BAL' THEN 3
    WHEN home_team LIKE 'BOS' THEN 4
    WHEN home_team LIKE 'CHC' THEN 5
    WHEN home_team LIKE 'CHW' THEN 6
    WHEN home_team LIKE 'CIN' THEN 7
    WHEN home_team LIKE 'CLE' THEN 8
    WHEN home_team LIKE 'COL' THEN 9
    WHEN home_team LIKE 'DET' THEN 10
    WHEN home_team LIKE 'HOU' THEN 11
    WHEN home_team LIKE 'KC' THEN 12
    WHEN home_team LIKE 'LAA' THEN 13
    WHEN home_team LIKE 'LAD' THEN 14
    WHEN home_team LIKE 'MIA' THEN 15
    WHEN home_team LIKE 'MIL' THEN 16
    WHEN home_team LIKE 'MIN' THEN 17
    WHEN home_team LIKE 'NYM' THEN 18
    WHEN home_team LIKE 'NYY' THEN 19
    WHEN home_team LIKE 'OAK' THEN 20
    WHEN home_team LIKE 'PHI' THEN 21
    WHEN home_team LIKE 'PIT' THEN 22
    WHEN home_team LIKE 'SD' THEN 23
    WHEN home_team LIKE 'SF' THEN 24
    WHEN home_team LIKE 'SEA' THEN 25
    WHEN home_team LIKE 'STL' THEN 26
    WHEN home_team LIKE 'TB' THEN 27
    WHEN home_team LIKE 'TEX' THEN 28
    WHEN home_team LIKE 'TOR' THEN 29
    WHEN home_team LIKE 'WAS' THEN 30
  END AS home_id, away_team_score, home_team_score, gamedate
FROM mlbscores2;

DELETE FROM scraper;
