-- Active: 1728923473005@@inrpublicacoes.mysql.dbaas.com.br@3306@inrpublicacoes
DROP PROCEDURE IF EXISTS get_news_home;

CREATE PROCEDURE get_news_home (
  l INT,
  o INT
)
BEGIN
    SELECT 
        idnoticia,
        titulo,
        fonte,
        DATE_FORMAT(data_registro, '%d/%m/%Y') AS datacad
    FROM noticia
    WHERE legado = 'N'
      AND  exc = 'N'
      AND dt_aprovacao IS NOT NULL 
      AND dt_aprovacao != '0000-00-00 00:00:00'
    ORDER BY idnoticia DESC
    LIMIT l
    OFFSET o;
END;