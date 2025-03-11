-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.search_device_component;

CREATE OR REPLACE FUNCTION inr.search_device_component (
  nameDeviceComponent VARCHAR(40),
  dId INTEGER DEFAULT NULL,
  actionLimit INTEGER DEFAULT 10,
  actionOffset INTEGER DEFAULT 0
)RETURNS TABLE(
  id INTEGER,
  name VARCHAR(40),
  deviceId INTEGER
)
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    dc.id,
    dc.name,
    dc.device_id
  FROM 
    inr.device_component as dc
  WHERE 
    (nameDeviceComponent IS NULL 
      OR dc.name ILIKE nameDeviceComponent || '%')
    AND (dId IS NULL OR dc.device_id = dId)
    AND dc.deleted_at ISNULL
    AND dc.deleted_by_id ISNULL
  ORDER BY 
    dc.name DESC
  LIMIT actionLimit
  OFFSET actionOffset * actionLimit;
END;
$$ LANGUAGE plpgsql;