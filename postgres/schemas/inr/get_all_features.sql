-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_all_features;

CREATE OR REPLACE FUNCTION inr.get_all_features ()
RETURNS TABLE (
    id INTEGER,
    name VARCHAR(100),
    icon VARCHAR(100),
    path VARCHAR(300),
    visible BOOLEAN,
    deviceComponentsName VARCHAR(40)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        f.id,
        f.name,
        f.icon,
        f.path,
        f.visible,
        dc.name AS "deviceComponentsName"
    FROM inr.feature f
    INNER JOIN inr.device_component dc ON 
        dc.id = f.device_components_id
    WHERE f.deleted_at IS NULL 
    AND f.deleted_by_id IS NULL;
END;
$$ LANGUAGE plpgsql;