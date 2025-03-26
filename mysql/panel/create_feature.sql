-- Active: 1742934687018@@127.0.0.1@3306@desenv
DROP FUNCTION IF EXISTS create_feature;

CREATE FUNCTION create_feature (
  featureName VARCHAR(100),
  featureCanonical VARCHAR(100),
  featureActive BOOLEAN,
  featureIcon VARCHAR(100),
  featurePath VARCHAR(300),
  featureVisible BOOLEAN,
  deviceComponentsId INT,
  createdById INT,
  actions TEXT
) RETURNS INT
READS SQL DATA
BEGIN
  DECLARE ret_id INT;

  INSERT INTO feature (
    name, 
    canonical, 
    active, 
    icon, 
    path, 
    visible, 
    device_components_id, 
    created_by_id, 
    created_at
  ) VALUES (
    featureName,
    featureCanonical,
    featureActive,
    featureIcon,
    featurePath,
    featureVisible,
    deviceComponentsId,
    createdById,
    now()
  ); 

    SET ret_id = LAST_INSERT_ID();

    CREATE TEMPORARY TABLE IF NOT EXISTS temp_actions (action_id INT);

    INSERT INTO temp_actions (action_id)
    SELECT JSON_EXTRACT(action_value, '$')
    FROM JSON_TABLE(actions, '$[*]' COLUMNS (action_value INT PATH '$')) AS jt;

    INSERT INTO feature_action (feature_id, action_id)
    SELECT ret_id, action_id 
    FROM temp_actions;

    DROP TEMPORARY TABLE temp_actions;

    RETURN ret_id;
END;