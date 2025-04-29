-- Active: 1744652968446@@inrpublicacoes.mysql.dbaas.com.br@3306@inrpublicacoes
DROP PROCEDURE IF EXISTS criar_boletim;

CREATE PROCEDURE criar_boletim (
    IN boletimtitulo VARCHAR(200),
    IN boletimnumero VARCHAR(10),
    IN boletimtipo INT,
    IN boletimdata char(10),
    IN criadoid INT,
    IN conteudo_itens JSON,
    OUT createdId INT
)
BEGIN
    INSERT INTO boletim (
        titulo, 
        numero, 
        boletim_tipo_id, 
        `data`, 
        aprovado, 
        publicado, 
        vizualizacao, 
        favorito, 
        ativo, 
        criado_id, 
        criado_em, 
        exc
    ) VALUES (
        boletimtitulo,
        boletimnumero,
        boletimtipo,
        boletimdata,
        'N',
        'N',
        0,
        0,
        TRUE,
        criadoid
        NOW(),
        'N'
    )

    SET createdId = LAST_INSERT_ID();

    CREATE TEMPORARY TABLE IF NOT EXISTS be_temp_itens (
        conteudo_tipo_id INT NOT NULL,
        titulo TEXT NOT NULL,
        conteudo TEXT DEFAULT NULL,
        url TEXT NOT NULL
    );

    INSERT INTO be_temp_itens (
        conteudo_tipo_id,
        titulo,
        conteudo,
        url
    )
    SELECT JSON_UNQUOTE(JSON_EXTRACT(conteudo_itens '$'))
    FROM JSON_TABLE(
        conteudo_itens, 
        '$[*]' 
        COLUMNS (
            conteudo_tipo_id INT PATH '$.conteudoTipoId',
            titulo INT PATH '$.titulo',
            conteudo TEXT PATH '$.conteudo',
            url TEXT PATH '$.url'
        )
    ) AS jt;

    INSERT INTO boletim_conteudo (
        conteudo_tipo_id,
        boletim_id,
        titulo,
        conteudo,
        url,
        click
    ) SELECT 
        conteudo_tipo_id, 
        createdId, 
        titulo, 
        conteudo, 
        url,
        0
    FROM be_temp_itens;

    DROP TEMPORARY TABLE be_temp_itens;
END;

/*
conteudoTipoId INT,
boletimId INT,
titulo text,
conteudo text,
url text
*/