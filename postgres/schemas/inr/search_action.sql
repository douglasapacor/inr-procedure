-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.search_action;

CREATE OR REPLACE
FUNCTION inr.search_action (
  nameAction VARCHAR(40),
  canonicalName VARCHAR(40),
  actionLimit INTEGER,
  actionOffset INTEGER
) RETURNS TABLE(
  id INTEGER,
  name VARCHAR(100),
  canonical VARCHAR(40)
)
AS $$
BEGIN
  RETURN QUERY
  SELECT
    a.id,
    a.name,
    a.canonical
  FROM
    inr."action" a
  WHERE 
    (nameAction IS NULL 
      OR a.name ILIKE nameAction || '%')
    AND (canonicalName IS NULL 
      OR a.canonical ILIKE canonicalName || '%')
    AND a.deleted_at ISNULL
    AND a.deleted_by_id ISNULL
  ORDER BY
    a."name" DESC
  LIMIT actionLimit 
  OFFSET actionOffset * actionLimit;
END;

$$ language plpgsql;