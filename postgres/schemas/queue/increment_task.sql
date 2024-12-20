-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS queue.increment_task;

CREATE OR REPLACE FUNCTION queue.increment_task (
    taskId INTEGER
) RETURNS INTEGER AS $$
DECLARE
  res_count integer;
BEGIN
    UPDATE queue."Task" SET
        retries = retries + 1
    WHERE id = taskId;
    GET DIAGNOSTICS res_count = ROW_COUNT;
    RETURN res_count;    
COMMIT;
END;
$$ LANGUAGE plpgsql
;