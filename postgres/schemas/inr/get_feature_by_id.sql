-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_feature_by_id;

CREATE OR REPLACE FUNCTION inr.get_feature_by_id (
  fuinctionId INTEGER
) RETURNS TABLE(
  id INTEGER,
  name VARCHAR(100),
  canonical VARCHAR(100),
  active BOOLEAN,
  icon VARCHAR(100),
  path VARCHAR(300),
  visible BOOLEAN,
  device_components_id INTEGER,
  device_name VARCHAR(40),
  created_by_id INTEGER,
  created_name VARCHAR(200),
  created_at TIMESTAMP(3),
  updated_by_id INTEGER,
  updated_name VARCHAR(200),
  updated_at TIMESTAMP(3)
)
AS $$
BEGIN
  RETURN QUERY
  SELECT
    f.id,
    f.name,
    f.canonical,
    f.active,
    f.icon,
    f.path,
    f.visible,
    f.device_components_id,
    dc.name AS "device_name",
    f.created_by_id,
    p.name AS "created_name",
    f.created_at,
    f.updated_by_id,
    p2.name AS "updated_name",
    f.updated_at
  FROM inr.feature as f
  LEFT JOIN inr.device_component AS dc
    ON dc."id" = f.device_components_id
  LEFT JOIN inr.profile AS p 
    ON p.user_id = f.created_by_id
  LEFT JOIN inr.profile AS p2 
    ON p2.user_id = f.updated_by_id
  WHERE f.id = fuinctionId
  AND f.deleted_at ISNULL
  AND f.deleted_by_id ISNULL
  GROUP BY 
    f.id, dc.name, 
    p.name, 
    p2.name;
END;
$$ LANGUAGE plpgsql;