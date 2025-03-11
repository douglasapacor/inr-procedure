-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.update_params;

CREATE OR REPLACE FUNCTION inr.update_params (
  paramName VARCHAR(30),
  paramValue VARCHAR(10)
) RETURNS INTEGER
AS $$
DECLARE
  res_count integer;
BEGIN
  UPDATE
      inr.params
  SET
      value = paramValue
  WHERE
      name = paramName;

  GET DIAGNOSTICS res_count = ROW_COUNT;
  RETURN res_count;
COMMIT;
END;
$$ LANGUAGE plpgsql
;