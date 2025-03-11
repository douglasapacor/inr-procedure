-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS inr.find_members;

CREATE OR REPLACE FUNCTION inr.find_members (
    sentence VARCHAR(200)
) RETURNS TABLE(
    id INTEGER,
    name VARCHAR(200),
    photo VARCHAR(300)
)   
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        u.id,
        p.name,
        p.photo
    FROM inr.profile as p 
    INNER JOIN inr."user" as u ON 
        u.id = p.user_id
    WHERE (sentence IS NULL
        OR p.name ILIKE sentence || '%')
    AND u.active = TRUE
    AND u.deleted_by_id IS NULL
    AND u.deleted_at IS NULL
    ORDER BY
        p.name DESC
    LIMIT 10
    OFFSET 0;
END;
$$ LANGUAGE plpgsql;