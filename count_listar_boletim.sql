-- Active: 1744652968446@@inrpublicacoes.mysql.dbaas.com.br@3306@inrpublicacoes

DROP PROCEDURE IF EXISTS count_listar_boletim;

CREATE PROCEDURE count_listar_boletim (
    searchText VARCHAR(200),
    tipo_id INT
)
BEGIN
    SELECT COUNT(b.id) 
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
		b.boletim_tipo_id = tipo_id;
END