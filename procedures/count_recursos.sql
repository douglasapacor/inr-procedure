-- Active: 1743113460132@@127.0.0.1@3306@desenv
DROP PROCEDURE IF EXISTS count_recursos;

CREATE PROCEDURE count_recursos (
  nomeRecurso VARCHAR(150)
)
BEGIN
    SELECT
        count(r.id) AS 'count'
    FROM
        recurso r
    WHERE
        r.nome LIKE CONCAT(nomeRecurso, '%')
        AND r.excluido_id IS NULL
        AND r.excluido_em IS NULL;
END;