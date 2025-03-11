-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.search_feature;

CREATE OR REPLACE FUNCTION inr.search_feature (
  featureName VARCHAR(100),
  featureCanonical VARCHAR(100),
  featureActive BOOLEAN,
  featureIcon VARCHAR(100),
  featurePath VARCHAR(300),
  featureVisible BOOLEAN,
  featureDeviceComponentsId INTEGER,
  featureLimit INTEGER,
  featureOffset INTEGER
) RETURNS TABLE(
  id INTEGER,
  name VARCHAR(100),
  canonical VARCHAR(100),
  active BOOLEAN,
  icon VARCHAR(100),
  path VARCHAR(300),
  visible BOOLEAN,
  device_components_id INTEGER,
  device_components_name VARCHAR(40)
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
    dc.name AS "device_components_name" 
  FROM inr.feature AS f
  LEFT JOIN inr.device_component AS dc 
    ON dc.id = f."device_components_id"
  WHERE 
    (featureName IS NULL OR f.name ILIKE featureName || '%' )
    AND (featureIcon IS NULL OR f.icon ILIKE featureIcon || '%')
    AND (featureCanonical IS NULL OR f.canonical ILIKE featureCanonical || '%')
    AND (featurePath IS NULL OR f.path ILIKE featurePath || '%')
    AND (featureActive IS NULL OR f.active = featureActive)
    AND (featureVisible IS NULL OR f.visible =  featureVisible)
    AND (featureDeviceComponentsId IS NULL OR f.device_components_id = featureDeviceComponentsId)
    AND f.deleted_at IS NULL
    AND f.deleted_by_id IS NULL
  ORDER BY f.name DESC
  LIMIT featureLimit
  OFFSET featureOffset * featureLimit;
END;
$$ LANGUAGE plpgsql;