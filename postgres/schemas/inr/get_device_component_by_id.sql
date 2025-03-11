-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_device_component_by_id;

CREATE OR REPLACE FUNCTION inr.get_device_component_by_id(
  getId INTEGER
) RETURNS TABLE(
  id INTEGER,
  name VARCHAR(40),
  deviceId INTEGER,
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
    dc.id, 
    dc.name, 
    dc.device_id, 
    dc.created_by_id, 
    p.name as "createdName", 
    dc.created_at, 
    dc.updated_by_id, 
    p2.name as "updatedName", 
    dc.updated_at
  FROM inr.device_component as dc
  LEFT JOIN inr.profile as p ON 
    p.user_id = dc.created_by_id
  LEFT JOIN inr.profile as p2 ON 
    p2.user_id = dc.updated_by_id
  WHERE dc.id = getId
  AND dc.deleted_at ISNULL
  AND dc.deleted_by_id ISNULL;
END;
$$ LANGUAGE plpgsql;