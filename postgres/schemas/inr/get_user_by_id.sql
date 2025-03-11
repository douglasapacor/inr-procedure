-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.get_user_by_id;

CREATE OR REPLACE FUNCTION inr.get_user_by_id (
  uuser_id INTEGER
) RETURNS TABLE(
  id INTEGER,
  super BOOLEAN,
  active BOOLEAN,
  group_id INTEGER,
  group_name VARCHAR(100),
  created_by_id INTEGER,
  created_name VARCHAR(200),
  created_at TIMESTAMP(3),
  updated_by_id INTEGER,
  updated_name VARCHAR(200),
  updated_at TIMESTAMP(3),
  name VARCHAR(200),
  email VARCHAR(200),
  cpf VARCHAR(14),
  rg VARCHAR(11),
  cellphone VARCHAR(11),
  address_id INTEGER,
  cep VARCHAR(8),
  street VARCHAR(200),
  street_number VARCHAR(10),
  neighborhood VARCHAR(100),
  city_ibge INTEGER,
  city_name VARCHAR(300),
  estate_Ibge INTEGER,
  estate_name VARCHAR(300),
  acronym VARCHAR(2)
)
AS $$
BEGIN
  RETURN QUERY
  SELECT
    us.id,
    us.super,
    us.active,
    us.group_id,
    gr.name AS "group_name",
    us.created_by_id,
    pr.name AS "created_name",
    us."created_at",
    us."updated_by_id",
    pr2.name AS "updated_name",
    us."updated_at",
    pr3.name,
    pr3.email,
    pr3.cpf,
    pr3.rg,
    pr3.cellphone,
    pr3.address_id,
    addr.cep,
    addr.street,
    addr.street_number,
    addr.neighborhood,
    addr.city_ibge,
    ci.name AS "city_name",
    st.ibge AS "estate_Ibge",
    st.name AS "estate_name",
    st.acronym
  FROM inr."user" AS us
  LEFT JOIN inr.profile AS pr 
    ON pr.user_id = us.created_by_id
  LEFT JOIN inr."group" AS gr
    ON gr.id = us.group_id
  LEFT JOIN inr.profile pr2
    ON pr2.user_id = us.updated_by_id
  LEFT JOIN inr.profile pr3
    ON pr3.user_id = us.id
  LEFT JOIN inr.address AS addr
    ON addr.id = pr3.address_id
  LEFT JOIN inr.city AS ci
    ON ci.ibge = addr.city_ibge
  LEFT JOIN inr.state AS st
    ON st.ibge = ci.state_ibge
  WHERE 
    us.id = uuser_id
  AND
    us.deleted_at IS NULL
  AND 
    us.deleted_by_id IS NULL;
END;
$$ LANGUAGE plpgsql;