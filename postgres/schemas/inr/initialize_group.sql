DROP FUNCTION IF EXISTS inr.initialize_group;

CREATE OR REPLACE FUNCTION inr.initialize_group ()
RETURNS INTEGER
AS $$
DECLARE
    admin_group INTEGER;
BEGIN
    INSERT INTO inr."group" (
        active, 
        canonical,
        color,
        name,
        super,
        "created_at"
    ) VALUES (
        TRUE,
        'admin',
        '#607D8B',
        'Administração de aplicação',
        TRUE,
        now()
    ) RETURNING id INTO admin_group;

    RETURN admin_group;
END;
$$ LANGUAGE plpgsql;