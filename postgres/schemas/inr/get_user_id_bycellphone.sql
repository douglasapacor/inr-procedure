-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_user_id_bycellphone;

CREATE OR REPLACE FUNCTION inr.get_user_id_bycellphone (
  userCellphone VARCHAR(11)
) RETURNS TABLE (
  id INTEGER
)
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    us.id 
  FROM inr."user" us 
    INNER JOIN inr.profile pr 
      ON pr.user_id = us.id
  WHERE 
    pr.cellphone = userCellphone;
END;
$$ LANGUAGE plpgsql;