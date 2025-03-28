-- Active: 1743113460132@@127.0.0.1@3306@desenv
DROP PROCEDURE IF EXISTS listar_recursos;

CREATE PROCEDURE listar_recursos (
  nomeRecurso VARCHAR(150),
  limitRcurso INT,
  offsetRcurso INT
)
BEGIN
    SELECT
        r.id,
        r.nome,
        r.icone,
        r.tag
    FROM
        recurso r
    WHERE
        r.nome LIKE CONCAT(nomeRecurso, '%')
    AND r.excluido_id IS NULL
    AND r.excluido_em IS NULL
    LIMIT limitRcurso
    OFFSET offsetRcurso;
END;