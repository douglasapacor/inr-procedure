-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.create_user_for_initialize;

CREATE OR REPLACE FUNCTION inr.create_user_for_initialize (
    groupId INTEGER
) 
RETURNS INTEGER
AS $$
DECLARE
    user_id INTEGER;
BEGIN
    INSERT INTO inr."user" (
        active,
        created_at,
        group_id,
        password,
        super,
        need_change
    ) VALUES (
        TRUE,
        now(),
        groupId,
        'sdfkljredlg@jmxnwez#çaudgh%djfg',
        TRUE,
        FALSE
    ) RETURNING id INTO user_id;

    INSERT INTO "profile" (
        "user_id",
        cpf,
        name
    ) VALUES (
        user_id,
        '111.111.111-11',
        'Sistema'
    );

    RETURN user_id;
END;
$$ LANGUAGE plpgsql;