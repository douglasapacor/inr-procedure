-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS queue.add_task;

CREATE OR REPLACE FUNCTION queue.add_task (
    taskName VARCHAR(500),
    retries INTEGER,
    priority INTEGER,
    maxRetries INTEGER
) RETURNS INTEGER AS $$
DECLARE
    res_id INTEGER;
BEGIN
    INSERT INTO queue."Task" (
        "taskName",
        retries,
        priority,
        "maxRetries"
    ) VALUES (
        taskName,
        retries,
        priority,
        maxRetries
    ) RETURNING id res_id;
    RETURN ret_id;
COMMIT;    
END;
$$ LANGUAGE plpgsql
;