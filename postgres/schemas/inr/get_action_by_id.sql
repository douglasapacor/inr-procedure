DROP FUNCTION IF EXISTS inr.get_action_by_id;

CREATE OR REPLACE
FUNCTION inr.get_action_by_id (
  actionId INTEGER
) RETURNS TABLE(
  id INTEGER,
  name VARCHAR(40),
  canonical VARCHAR(40),
  createdById INTEGER,
  createdName VARCHAR(200),
  createdAt TIMESTAMP(3),
  updatedById INTEGER,
  updatedName VARCHAR(200),
  updatedAt TIMESTAMP(3)
)
AS $$
BEGIN
  RETURN QUERY
  SELECT
    a.id,
    a.name,
    a.canonical,
    a.created_by_id,
    p."name" as "createdName",
    a.created_at,
    a.updated_by_id,
    p2."name" as "updatedName",
    a.updated_at
  FROM
    inr."action" a
  LEFT JOIN inr.profile p on
    p.user_id = a.created_by_id
  LEFT JOIN inr.profile p2 on
    p2.user_id = a.updated_by_id
  WHERE
    a.id = actionId
  AND a.deleted_by_id ISNULL
  AND a.deleted_at ISNULL;
END;
$$ LANGUAGE PLPGSQL;