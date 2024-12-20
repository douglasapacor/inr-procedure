-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS queue.unregister_device;

CREATE OR REPLACE FUNCTION queue.unregister_device (
    userId TEXT
) RETURNS INTEGER AS $$
DECLARE
  res_count integer;
BEGIN
    DELETE FROM queue."Devices" WHERE "userId" = userId;
    GET DIAGNOSTICS res_count = ROW_COUNT;
    RETURN res_count;
COMMIT;
END;
$$ LANGUAGE plpgsql
;