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
        pl.nome AS 'plataforma_nome',
        pf.nome AS 'criado_nome',
        r.criado_em,
        pfi.nome AS 'alterado_nome',
        r.alterado_em
    FROM 
        recurso r
    INNER JOIN plataforma pl 
        ON pl.id = r.plataforma_id
    INNER JOIN perfil pf
        ON pf.usuario_id = r.criado_id
    INNER JOIN perfil pfi
        ON pfi.usuario_id = r.alterado_id        
    WHERE r.id = recursoId
    AND excluido_id IS NULL
    AND excluido_em is NULL;
END;