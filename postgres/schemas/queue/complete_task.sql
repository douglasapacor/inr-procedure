-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr

DROP FUNCTION IF EXISTS inr.complete_task;

CREATE OR REPLACE FUNCTION inr.complete_task (
    taskId INTEGER
) RETURNS INTEGER AS $$
DECLARE
  res_count integer;
BEGIN
    DELETE from queue."Task" WHERE id = taskId;
    GET DIAGNOSTICS res_count = ROW_COUNT;
    RETURN res_count;
COMMIT;
END;
$$ LANGUAGE plpgsql
;