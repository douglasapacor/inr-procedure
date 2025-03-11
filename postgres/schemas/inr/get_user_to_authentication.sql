-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_user_to_authentication;

CREATE OR REPLACE FUNCTION inr.get_user_to_authentication (
  uuserId INTEGER
) RETURNS TABLE (
  id INTEGER,
  active BOOLEAN,
  need_change BOOLEAN,
  password VARCHAR(200),
  super BOOLEAN,  
  group_id INTEGER,
  group_name VARCHAR(100),
  group_canonical_name VARCHAR(100),
  group_super BOOLEAN,
  name VARCHAR(200),
  email VARCHAR(200),
  cpf  VARCHAR(14),
  rg VARCHAR(11),
  cellphone  VARCHAR(11)
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    us.id, 
    us.active, 
    us.need_change,
    us.password,
    us.super, 
    us.group_id,
    gr.name AS "group_name",
    gr.canonical AS "group_canonical_name",
    gr.super AS "group_super",
    pr.name,
    pr.email,
    pr.cpf,
    pr.rg,
    pr.cellphone
  FROM inr.user us
  INNER JOIN inr.profile pr
    ON pr.user_id = uuserId
  INNER JOIN inr."group"gr
    ON gr.id = us.group_id
  WHERE 
    us.id = uuserId
  AND 
    us.active = TRUE    
  AND 
    us.deleted_at IS NULL
  AND 
    us.deleted_by_id IS NULL;
END;
$$ LANGUAGE plpgsql;