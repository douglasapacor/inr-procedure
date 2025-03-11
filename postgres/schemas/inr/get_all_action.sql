-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_all_action;

CREATE OR REPLACE FUNCTION inr.get_all_action ()
RETURNS TABLE(
  id INTEGER,
  name VARCHAR(40),
  canonical VARCHAR(40)
)
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    ac.id,
    ac.name,
    ac.canonical  
  FROM inr."action" ac
  WHERE ac.deleted_at IS NULL 
  AND ac.deleted_by_id IS NULL;
END;
$$ LANGUAGE plpgsql;