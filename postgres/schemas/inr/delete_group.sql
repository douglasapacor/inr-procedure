DROP FUNCTION IF EXISTS inr.delete_group;

CREATE OR REPLACE FUNCTION inr.delete_group (
  groupId INTEGER,
  deletedBy INTEGER
) RETURNS INTEGER
AS $$
DECLARE
    res_count integer;
BEGIN
  DELETE 
    FROM inr.group_feature
  WHERE 
    "group_id" = groupId;
    
  UPDATE inr.group SET
    deleted_by_id = deletedBy,
    deleted_at = now()
  WHERE id = groupId;

  GET DIAGNOSTICS res_count = ROW_COUNT;
  RETURN res_count;
COMMIT;
END;
$$ LANGUAGE plpgsql;