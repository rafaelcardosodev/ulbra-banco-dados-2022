
/* INSERT AUTORES */
DROP PROCEDURE IF EXISTS insert_autores_pcd;
DELIMITER $$
CREATE PROCEDURE insert_autores_pcd(
							p_id int,
                            p_nome varchar(60)
						)
BEGIN 
	INSERT INTO autores (nome)
    VALUES
		(p_nome);
END $$
DELIMITER ;

CALL insert_autores_pcd(0, "Guilherme");

SELECT * FROM vw_autores;
/*--------------------------------------*/

/*INSERT CLIENTES*/
DROP PROCEDURE IF EXISTS insert_clientes_pcd;
DELIMITER $$
CREATE PROCEDURE insert_clientes_pcd(
							p_id int,
                            p_nome varchar(60),
                            p_fone varchar(20),
                            p_endereco varchar(100)
						)
BEGIN 
	INSERT INTO clientes (nome, fone, endereco)
    VALUES (p_nome, p_fone, p_endereco);
END $$
DELIMITER ;

CALL insert_clientes_pcd(0, "marcio", "22222", "rua cabo braga");

SELECT * FROM vw_clientes;	
/*--------------------------------------*/

/*INSERT GENEROS*/
DROP PROCEDURE IF EXISTS insert_generos_pcd;
DELIMITER $$
CREATE PROCEDURE insert_generos_pcd(
					p_id int, 
                    p_descricao varchar(45)
				)
BEGIN
	INSERT INTO generos(descricao)
    VALUES (p_descricao);
END $$
DELIMITER ;

CALL insert_generos_pcd(0, "Drama");

SELECT * FROM vw_generos;
/*--------------------------------------*/

/*INSERT LIVROS*/
DROP PROCEDURE IF EXISTS insert_livros_pcd;
DELIMITER $$
CREATE PROCEDURE insert_livros_pcd(
					p_id int,
                    p_nome varchar(45),
                    p_genero_id int,
                    p_autores_id int
				)
BEGIN
	INSERT INTO livros(nome, genero_id, autores_id)
    VALUES (p_nome, p_genero_id, p_autores_id);
END $$
DELIMITER ;

CALL insert_livros_pcd(0, "GOT", 1, 1);

SELECT * FROM vw_livros;
/*--------------------------------------*/

DROP PROCEDURE IF EXISTS insert_locacoes_pcd;
DELIMITER $$
CREATE PROCEDURE insert_locacoes_pcd(
					p_id int,
                    p_data_locacao date,
                    p_data_devolucao date,
                    p_livros_id int
				)
BEGIN
	INSERT INTO locacoes (data_locacao, data_devolucao, livros_id)
    VALUES (p_data_locacao, p_data_devolucao, p_livros_id);
END $$
DELIMITER ;

CALL insert_locacoes_pcd(0, '2003-03-22', '2003-04-22', );

DROP PROCEDURE IF EXISTS insert_clientes_locacoes_clientes_pcd;
DELIMITER $$
CREATE PROCEDURE insert_locacoes_clientes_pcd(
                    p_cliente_id int,
                    p_locacao_id int
				)
BEGIN
	INSERT INTO locacoes_clientes(cliente_id, locacao_id)
    VALUES (p_cliente_id, p_locacao_id);
END $$
DELIMITER ;

                        