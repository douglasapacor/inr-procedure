-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.count_feature;

CREATE OR REPLACE FUNCTION inr.count_feature (
  featureName VARCHAR(100),
  featureCanonical VARCHAR(100),
  featureActive BOOLEAN,
  featureIcon VARCHAR(100),
  featurePath VARCHAR(300),
  featureVisible BOOLEAN,
  featureDeviceComponentsId INTEGER  
) RETURNS INTEGER
AS $$
BEGIN
  RETURN(
    SELECT
      count(f.id)
    FROM inr.feature AS f
    WHERE
      (featureName IS NULL OR f.name ILIKE featureName || '%' )
      AND (featureIcon IS NULL OR f.icon ILIKE featureIcon || '%')
      AND (featureCanonical IS NULL OR f.canonical ILIKE featureCanonical || '%')
      AND (featurePath IS NULL OR f.path ILIKE featurePath || '%')
      AND (featureActive IS NULL OR f.active = featureActive)
      AND (featureVisible IS NULL OR f.visible =  featureVisible)
      AND (featureDeviceComponentsId IS NULL OR f.device_components_id = featureDeviceComponentsId)
      AND f.deleted_at ISNULL
      AND f.deleted_by_id ISNULL
  );
END;
$$ LANGUAGE plpgsql;