-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.search_users;

CREATE OR REPLACE FUNCTION inr.search_users (
  userName VARCHAR(200),
  userEmail VARCHAR(200),
  userCpf VARCHAR(14),
  userRg VARCHAR(11),
  userCellphone VARCHAR(11),
  groupId INTEGER,
  userActive BOOLEAN,
  userSuper BOOLEAN,
  userLimit INTEGER,
  userOffset INTEGER
) RETURNS TABLE (
  id INTEGER,
  super BOOLEAN,
  active BOOLEAN,
  "groupId" INTEGER,
  groupName VARCHAR(200),
  name VARCHAR(200),
  email VARCHAR(200),
  cpf VARCHAR(14),
  rg VARCHAR(11),
  cellphone VARCHAR(11)
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
    pr.name,
    pr.email,
    pr.cpf,
    pr.rg,
    pr.cellphone
  FROM 
    inr."user" us
  INNER JOIN inr.profile pr
    ON pr.user_id = us.id
  INNER JOIN inr."group" gr
    ON gr.id = us.group_id
  WHERE (userName IS NULL OR pr.name ILIKE userName || '%')
  AND (userEmail IS NULL OR pr.email ILIKE userEmail || '%')
  AND (userCpf IS NULL OR pr.cpf ILIKE userCpf || '%')
  AND (userRg IS NULL OR pr.rg ILIKE userRg || '%')
  AND (userCellphone IS NULL OR pr.cellphone ILIKE userCellphone || '%')
  AND (groupId IS NULL OR us."group_id" = groupId)
  AND us.active = userActive
  AND us.super = userSuper
  AND us.deleted_at IS NULL
  AND us.deleted_by_id IS NULL
  ORDER BY pr.name DESC
  LIMIT userLimit
  OFFSET userOffset * userLimit;
END;
$$ LANGUAGE plpgsql;