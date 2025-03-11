-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_group_feature;

CREATE OR REPLACE FUNCTION inr.get_group_feature (
  gId INTEGER
)RETURNS TABLE(
  feature_id INTEGER,
  name VARCHAR(100),
  free_for_group BOOLEAN
)
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    gf.feature_id, 
    f.name,
    gf.free_for_group
  FROM inr.group_feature AS gf
  LEFT JOIN inr.feature f 
    ON f.id = gf.feature_id
  WHERE gf.group_id = gId;
END;
$$ LANGUAGE plpgsql;