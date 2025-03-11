-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_feature_action;

CREATE OR REPLACE FUNCTION inr.get_feature_action (
  fId INTEGER
)RETURNS TABLE(
  id INTEGER,
  name VARCHAR(40)
)
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    fa.action_id AS "id",
    ac.name
  FROM inr.feature_action AS fa
  LEFT JOIN inr."action" AS ac 
    ON ac.id = fa.action_id
  WHERE 
    fa.feature_id = fId;
END;
$$ LANGUAGE plpgsql;