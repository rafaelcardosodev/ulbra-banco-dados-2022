/* VIEW AUTORES */
DROP VIEW IF EXISTS vw_autores;
CREATE VIEW vw_autores
AS
SELECT * FROM autores;

SELECT * FROM vw_autores;
/*------------------------*/

/* VIEW CLIENTES */
DROP VIEW IF EXISTS vw_clientes;
CREATE VIEW vw_clientes
AS
SELECT * FROM clientes;

SELECT * FROM vw_clientes;
/*------------------------*/

/* VIEW EDITORAS */
DROP VIEW IF EXISTS vw_editoras;
CREATE VIEW vw_editoras
AS
SELECT * FROM editoras;

SELECT * FROM vw_editoras;
/*------------------------*/

/* VIEW GENEROS */
DROP VIEW IF EXISTS vw_generos;
CREATE VIEW vw_generos
AS
SELECT * FROM generos;

SELECT * FROM vw_generos;
/*------------------------*/

/* VW LIVROS */
DROP VIEW IF EXISTS vw_livros;
CREATE VIEW vw_livros
AS
SELECT * FROM livros;

SELECT * FROM vw_livros;
/*------------------------*/

/* VIEW LOCACOES */
DROP VIEW IF EXISTS vw_locacoes;
CREATE VIEW vw_locacoes
AS
SELECT * FROM locacoes;

SELECT * FROM vw_locacoes;
/*------------------------*/

/* VIEW CLIENTES LOCACOES_CLIENTES */
DROP VIEW IF EXISTS vw_clientes_locacoes_clientes;
CREATE VIEW vw_clientes_locacoes_clientes
AS
SELECT c.*, l.data_locacao, l.id as 'id_locacao', l.data_devolucao, l.livros_id FROM clientes c
	INNER JOIN locacoes_clientes lc ON c.id = lc.cliente_id
    INNER JOIN locacoes l ON l.id = lc.locacao_id;

SELECT * FROM vw_clientes_locacoes_clientes;
/*------------------------*/

/* VIEW LOCACOES LOCACOES_CLIENTES */
DROP VIEW IF EXISTS vw_locacoes_locacoes_clientes;
CREATE VIEW vw_locacoes_locacoes_clientes
AS
SELECT l.*, c.nome, c.id as 'id_cliente' FROM locacoes l
	INNER JOIN locacoes_clientes lc ON l.id = lc.locacao_id
    INNER JOIN clientes c ON c.id = lc.cliente_id;

SELECT * FROM vw_clientes_locacoes_clientes;
/*------------------------*/
