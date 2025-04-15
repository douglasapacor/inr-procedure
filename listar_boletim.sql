-- Active: 1744652968446@@inrpublicacoes.mysql.dbaas.com.br@3306@inrpublicacoes

DROP PROCEDURE IF EXISTS listar_boletim;

CREATE PROCEDURE listar_boletim (
    searchText VARCHAR(200),
    usuario_id INT,
    tipo_id INT,
    total INT,
    pagina INT
)
BEGIN
    SELECT 
		b.id, 
		b.titulo, 
		b.numero, 
		b.data, 
		bt.nome AS 'tipo',
		CASE
			WHEN (SELECT COUNT(id) 
                    FROM boletim_favorito blf
                    WHERE blf.boletim_id = b.id 
                    AND blf.usuario_id = usuario_id) > 0 THEN
				TRUE
			ELSE
				FALSE
		END AS 'favorito'
	FROM
		boletim b
	INNER JOIN
		boletim_tipo bt 
	ON 
		bt.id = b.boletim_tipo_id
	WHERE 
		(b.numero LIKE CONCAT(searchText, '%') OR b.data LIKE CONCAT(searchText, '%'))
	AND 
        b.aprovado = 'S' 
	AND 
		b.publicado = 'S'
	AND 
		b.ativo = TRUE
	AND 
		b.exc = 'N'
	AND 
		b.boletim_tipo_id = tipo_id
	ORDER BY 
		b.numero DESC
	LIMIT total 
	OFFSET pagina;    
END;