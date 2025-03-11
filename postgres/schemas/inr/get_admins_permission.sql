DROP FUNCTION IF EXISTS inr.get_admins_permission;

CREATE OR REPLACE FUNCTION inr.get_admins_permission ()
RETURNS TABLE (
  featureId INTEGER,
  featureName VARCHAR(100),
  featureIcon VARCHAR(100),
  featurePath VARCHAR(300),
  featureCanonical VARCHAR(100),
  featureDeviceComponentId INTEGER,
  featureVisible BOOLEAN,
  deviceName VARCHAR(100),
  featureDeviceId INTEGER,
  actions JSONB
)
AS $$
BEGIN
  RETURN QUERY
  SELECT
    f.id as "featureId",
    f."name" as "featureName",
    f.icon,
    f."path",
    f.canonical,
    f.device_components_id,
    f.visible,
    dc."name" as "deviceName",
    dc.device_id,
    (
    SELECT
      json_agg(jsonb_build_object('id',
      fa.action_id,
      'name',
      ac.name,
      'canonical',
      ac.canonical))::JSONB
    FROM
      inr.feature_action fa
    INNER JOIN inr."action" ac
    ON
      ac.id = fa.action_id
    WHERE
      fa.feature_id = f.id
      AND 
      ac.deleted_at IS NULL
      AND
      ac.deleted_by_id IS NULL
    ) AS actions
  FROM
    inr.feature f
  INNER JOIN device_component dc ON
    dc.id = f.device_components_id
  WHERE
    f.deleted_by_id IS NULL
    AND f.deleted_at IS NULL;
END;
$$ LANGUAGE plpgsql;