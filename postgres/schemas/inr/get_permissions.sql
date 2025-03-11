-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_permissions;

CREATE OR REPLACE FUNCTION inr.get_permissions (
  uuser_id INTEGER
) RETURNS TABLE (
  id INTEGER,
  name VARCHAR(100),
  icon VARCHAR(100),
  path VARCHAR(300),
  canonical VARCHAR(100),
  device_id INTEGER,
  visible BOOLEAN,
  device_name VARCHAR(100),
  device_id INTEGER,
  actions JSONB
)
AS $$
BEGIN
  RETURN QUERY  
  SELECT
    DISTINCT(pm."feature_id") AS "id",
    fe.name,
    fe.icon,
    fe.path,
    fe.canonical,
    fe.device_components_id,
    fe.visible,
    dc.name AS "device_name",
    dc."device_id",
    (
      SELECT 
        json_agg(jsonb_build_object('id', fa."action_id", 'name', ac.name, 'canonical', ac.canonical))::JSONB
      FROM 
        inr.feature_action fa
      INNER JOIN inr."action" ac
        ON ac.id = fa.action_id
      WHERE 
        fa.feature_id = pm.feature_id
      AND 
        ac.deleted_at IS NULL
      AND
        ac.deleted_by_id IS NULL
    ) AS actions
  FROM inr.permission pm
  LEFT JOIN inr.feature fe
    ON fe.id = pm."feature_id"
  LEFT JOIN inr.device_component dc
    ON dc.id = fe.device_components_id
  WHERE pm.user_id = uuser_id
  AND pm.deleted_at IS NULL
  AND pm.deleted_by_id IS NULL
  AND fe.deleted_at IS NULL
  AND fe.deleted_by_id IS NULL;
END;
$$ LANGUAGE plpgsql;