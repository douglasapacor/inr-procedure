-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.update_action;

CREATE OR REPLACE
FUNCTION inr.update_action (
  actionId INTEGER,
  actionName VARCHAR(40),
  canonicalName VARCHAR(40),
  updatedBy INTEGER
) RETURNS INTEGER
AS $$
DECLARE
  res_count integer;
BEGIN
  UPDATE
    inr."action"
  SET
    name = actionName,
    canonical = canonicalName,
    updated_by_id = updatedBy,
    updated_at = now()
  WHERE
    id = actionId;
    
  GET DIAGNOSTICS res_count = ROW_COUNT;
  RETURN res_count;

  COMMIT;
END;
$$ LANGUAGE PLPGSQL;