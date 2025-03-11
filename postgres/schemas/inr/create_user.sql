-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.create_user;

CREATE OR REPLACE FUNCTION inr.create_user (
  userSuper BOOLEAN,
  userGroupId INTEGER,
  userPassword VARCHAR(500),
  userActive BOOLEAN,
  needChange BOOLEAN,
  userCreatedBy INTEGER,
  userName VARCHAR(200),
  userEmail VARCHAR(200),
  userRg VARCHAR(200),
  userCpf VARCHAR(200),
  userCellphone VARCHAR(200),
  userAddress JSONB
) RETURNS INTEGER
AS $$
DECLARE
  user_id_var INTEGER;
  address_id_var INTEGER;
BEGIN

  INSERT INTO inr.user (
    super,
    group_id,
    password,
    need_change,
    active,
    connected,
    created_by_id,
    created_at
  ) VALUES (
    userSuper,
    userGroupId,
    userPassword,
    needChange,
    userActive,
    true,
    userCreatedBy,
    now()
  ) RETURNING id INTO user_id_var;

  CASE WHEN (userAddress IS NOT NULL) THEN
    INSERT INTO inr.address(
      cep, 
      street, 
      street_number, 
      neighborhood, 
      city_ibge, 
      observation, 
      created_by_id, 
      created_at 
    ) VALUES (
      userAddress->>'cep',
      userAddress->>'street',
      userAddress->>'streetNumber',
      userAddress->>'neighborhood',
      CAST(userAddress->>'cityIbge' as INT),
      userAddress->>'observation',
      userCreatedBy,
      now()
    ) RETURNING id INTO address_id_var;    
    
    INSERT INTO inr.profile (
      name,
      email,
      rg,
      cpf,
      cellphone,      
      address_id,
      user_id
    ) VALUES (
      userName,
      userEmail,
      userRg,
      userCpf,
      userCellphone,
      address_id_var,
      user_id_var
    );
  ELSE
    INSERT INTO inr.profile (
      name,
      email,
      rg,
      cpf,
      cellphone,
      user_id
    ) VALUES (
      userName,
      userEmail,
      userRg,
      userCpf,
      userCellphone,
      user_id_var
    );
  END CASE;
  RETURN user_id_var;
COMMIT;
END;
$$ LANGUAGE plpgsql;