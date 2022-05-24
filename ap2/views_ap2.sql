/* VIEW AUTORES */
CREATE VIEW vw_autores
AS
SELECT * FROM autores;

SELECT * FROM vw_autores;
/*------------------------*/

/* VIEW CLIENTES */
CREATE VIEW vw_clientes
AS
SELECT * FROM clientes;

SELECT * FROM vw_clientes;
/*------------------------*/

/* VIEW EDITORAS */
CREATE VIEW vw_editoras
AS
SELECT * FROM editoras;

SELECT * FROM vw_editoras;
/*------------------------*/

/* VIEW GENEROS */
CREATE VIEW vw_generos
AS
SELECT * FROM generos;

SELECT * FROM vw_generos;
/*------------------------*/

/* VW LIVROS */
CREATE VIEW vw_livros
AS
SELECT * FROM livros;

SELECT * FROM vw_livros;
/*------------------------*/

/* VIEW LOCACOES */
CREATE VIEW vw_locacoes
AS
SELECT * FROM locacoes;

SELECT * FROM vw_locacoes;
/*------------------------*/

/* VIEW CLIENTES LOCACOES_CLIENTES */
CREATE VIEW vw_clientes_locacoes_clientes
AS
SELECT c.*, l.data_locacao, l.id as 'id_locacao', l.data_devolucao, l.livros_id FROM clientes c
	INNER JOIN locacoes_clientes lc ON c.id = lc.cliente_id
    INNER JOIN locacoes l ON l.id = lc.locacao_id;

SELECT * FROM vw_clientes_locacoes_clientes;
/*------------------------*/

/* VIEW LOCACOES LOCACOES_CLIENTES */
CREATE VIEW vw_locacoes_locacoes_clientes
AS
SELECT l.*, c.nome, c.id as 'id_cliente' FROM locacoes l
	INNER JOIN locacoes_clientes lc ON l.id = lc.locacao_id
    INNER JOIN clientes c ON c.id = lc.cliente_id;

SELECT * FROM vw_clientes_locacoes_clientes;
/*------------------------*/
