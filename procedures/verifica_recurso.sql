-- Active: 1743113460132@@127.0.0.1@3306@desenv

DROP PROCEDURE IF EXISTS verifica_recurso;

CREATE PROCEDURE verifica_recurso (
  recursoNome VARCHAR(150)
)
BEGIN
    SELECT 
        COUNT(id) AS 'count'
    FROM 
        recurso 
    WHERE 
        nome = recursoNome
    AND 
        excluido_id IS NULL
    AND
        excluido_em IS NULL;
END;