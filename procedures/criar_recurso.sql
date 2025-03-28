-- Active: 1743113460132@@127.0.0.1@3306@desenv
DROP PROCEDURE IF EXISTS criar_recurso;

CREATE PROCEDURE criar_recurso (
    IN recursoNome VARCHAR(150),
    IN recursoIcone VARCHAR(30),
    IN recursoTag VARCHAR(5),
    IN recursoCaminho VARCHAR(200),
    IN recursoAcoes VARCHAR(6),
    IN recursoAtivo BOOL,
    IN plataformaId INT,
    IN criadoId INT,
    OUT created INT
)
BEGIN
    INSERT INTO recurso 
        (
            nome, 
            icone, 
            tag, 
            caminho, 
            acoes, 
            ativo, 
            plataforma_id, 
            criado_id,
            criado_em
        ) VALUES (
            recursoNome, 
            recursoIcone, 
            recursoTag, 
            recursoCaminho, 
            recursoAcoes, 
            recursoAtivo, 
            plataformaId,
            criadoId,
            NOW()
        );

        SET created = LAST_INSERT_ID();
END;