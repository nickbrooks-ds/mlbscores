INSERT INTO mlbscores 
SELECT raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') ->> 'away' AS away_team,
    raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') ->> 'home' AS home_team,
    raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') ->> 'gameID' AS gameid,
    (raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') -> 'lineScore' -> 'away' ->> 'R')::INT AS away_team_score,
    (raw_json -> 'body' -> jsonb_object_keys(raw_json -> 'body') -> 'lineScore' -> 'home' ->> 'R')::INT AS home_team_score
FROM scraper;

DELETE FROM scraper;
