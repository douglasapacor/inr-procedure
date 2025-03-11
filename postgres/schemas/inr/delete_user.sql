DROP FUNCTION IF EXISTS inr.delete_user;

CREATE OR REPLACE FUNCTION inr.delete_user (
  uuser_id INTEGER,
  deletedBy INTEGER
) RETURNS INTEGER
AS $$
DECLARE
  res_count INTEGER;
BEGIN
  DELETE FROM inr.permission WHERE user_id = uuser_id;

  WITH user_profile as (
    SELECT * 
    FROM inr.profile
    WHERE user_id = uuser_id
  ) 

  UPDATE inr.address addr
    SET
      deleted_at = now(),
      deleted_by_id = deletedBy
  FROM user_profile
  WHERE 
    addr.id = user_profile.address_id;

  UPDATE inr."user" us
    SET 
      deleted_at = now(),
      deleted_by_id = deletedBy
  WHERE 
    us.id = uuser_id;

  GET DIAGNOSTICS res_count = ROW_COUNT;
  RETURN res_count;
COMMIT;
END;
$$ LANGUAGE plpgsql;