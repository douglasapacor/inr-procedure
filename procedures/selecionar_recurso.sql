-- Active: 1743113460132@@127.0.0.1@3306@desenv

DROP PROCEDURE IF EXISTS selecionar_recurso;

CREATE PROCEDURE selecionar_recurso (
    recursoId INT
)
BEGIN
    SELECT 
        r.id,
        r.nome,
        r.icone,
        r.tag,
        r.caminho,
        r.acoes,
        r.ativo,
        r.plataforma_id,
        p.nome AS plataforma_nome,
        pf.nome
    FROM 
        recurso r
    WHERE r.id = recursoId
    AND r.plataforma_id = p.id
    AND r.criado_id = ui.id
    AND pf.usuario_id = ui.id
    AND excluido_id IS NULL
    AND excluido_em is NULL;
END;