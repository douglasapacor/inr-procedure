-- Active: 1743113460132@@127.0.0.1@3306@desenv

DROP PROCEDURE IF EXISTS editar_recurso;

CREATE PROCEDURE editar_recurso (
    recursoId INT,
    recursoNome VARCHAR(150),
    recursoIcone VARCHAR(30),
    recursoTag VARCHAR(5),
    recursoCaminho VARCHAR(200),
    recursoAcoes VARCHAR(6),
    recursoAtivo BOOL,
    plataformaId INT,
    alteradoId INT
)
BEGIN
    UPDATE recurso SET
        nome = recursoNome,
        icone = recursoIcone,
        tag = recursoTag,
        caminho = recursoCaminho,
        acoes = recursoAcoes,
        ativo = recursoAtivo,
        plataforma_id = plataformaId,
        alterado_id = alteradoId,
        alterado_em = NOW()
    WHERE id = recursoId;
END;