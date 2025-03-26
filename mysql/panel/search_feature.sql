-- Active: 1742934687018@@127.0.0.1@3306@desenv
DROP PROCEDURE IF EXISTS search_feature;

CREATE PROCEDURE search_feature (
  featureName VARCHAR(100),
  featureCanonical VARCHAR(100),
  featureActive BOOLEAN,
  featureIcon VARCHAR(100),
  featurePath VARCHAR(300),
  featureVisible BOOLEAN,
  featureDeviceComponentsId INTEGER,
  featureLimit INTEGER,
  featureOffset INTEGER
)
BEGIN
  DECLARE calculated_offset INTEGER;
  SET calculated_offset = featureOffset * featureLimit;

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
  FROM feature AS f
  LEFT JOIN device_component AS dc 
    ON dc.id = f.device_components_id
  WHERE 
    (featureName IS NULL OR f.name LIKE featureName || '%' )
    AND (featureIcon IS NULL OR f.icon LIKE featureIcon || '%')
    AND (featureCanonical IS NULL OR f.canonical LIKE featureCanonical || '%')
    AND (featurePath IS NULL OR f.path LIKE featurePath || '%')
    AND (featureActive IS NULL OR f.active = featureActive)
    AND (featureVisible IS NULL OR f.visible =  featureVisible)
    AND (featureDeviceComponentsId IS NULL OR f.device_components_id = featureDeviceComponentsId)
    AND f.deleted_at IS NULL
    AND f.deleted_by_id IS NULL
  ORDER BY f.name DESC
  LIMIT featureLimit
  OFFSET calculated_offset;
END;