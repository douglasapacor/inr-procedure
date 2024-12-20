-- Active: 1729025248584@@52.54.164.215@9002@clnxiu2o300dj9gtg4f21g3hd@inr
DROP FUNCTION IF EXISTS queue.register_device;

CREATE OR REPLACE FUNCTION queue.register_device (
    userId TEXT,
    platform VARCHAR(10),
    tokenUser TEXT
) RETURNS INTEGER AS $$
DECLARE
    res_id INTEGER;
BEGIN
  INSERT INTO queue."Devices" (
    "userId", 
    platform, 
    token, 
    "createdAt"
  ) VALUES (
    "userId",
    platform,
    tokenUser, 
    now()
  ) RETURNING id INTO res_id;
  RETURN res_id;
END;
$$ LANGUAGE plpgsql
;