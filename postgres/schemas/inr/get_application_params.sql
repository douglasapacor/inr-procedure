-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_application_params;

CREATE
OR
REPLACE
    FUNCTION inr.get_application_params () RETURNS
TABLE (
    name VARCHAR(100),
    value VARCHAR(100)
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    p."name",
    p."value"
  FROM
    inr.params p; 
END;
$$ LANGUAGE PLPGSQL;