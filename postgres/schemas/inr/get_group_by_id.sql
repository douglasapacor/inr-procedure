-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_group_by_id;

CREATE OR REPLACE FUNCTION inr.get_group_by_id (
  gId INTEGER
) RETURNS TABLE(
  id INTEGER,
  name VARCHAR(100),
  canonical VARCHAR(100),
  color VARCHAR(7),
  active BOOLEAN ,
  super BOOLEAN,
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
    g.id,
    g.name,
    g.canonical,
    g.color,
    g.active,
    g.super,
    g.created_by_id,
    p.name AS created_name,
    g.created_at,
    g.updated_by_id,
    p2.name AS updated_name,
    g.updated_at
  FROM inr."group" AS g
  LEFT JOIN inr.profile AS p 
    ON p.user_id = g.created_by_id
  LEFT JOIN inr.profile AS p2 
    ON p2.user_id = g.updated_by_id
  WHERE g.id = gId;
END;
$$ LANGUAGE plpgsql;