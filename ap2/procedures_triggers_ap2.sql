
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

CALL insert_generos_pcd(0, "Romance");

SELECT * FROM vw_generos;
/*--------------------------------------*/

/*INSERT LIVROS*/
DROP PROCEDURE IF EXISTS insert_livros_pcd;
DELIMITER $$
CREATE PROCEDURE insert_livros_pcd(
					p_id int,
                    p_nome varchar(45),
                    p_genero_id int,
                    p_autores_id int,
                    p_copias_vendidas int
				)
BEGIN
	INSERT INTO livros(nome, genero_id, autores_id, copias_vendidas)
    VALUES (p_nome, p_genero_id, p_autores_id, p_copias_vendidas);
END $$
DELIMITER ;

CALL insert_livros_pcd(0, "GOT", 1, 1);

SELECT * FROM vw_livros;
/*--------------------------------------*/

/* INSERT LOCACOES */
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

CALL insert_locacoes_pcd(0, '2003-03-22', '2003-04-22', 1);

SELECT * FROM vw_locacoes;
/*--------------------------------------*/

/* INSERT CLIENTES LOCACOES */
DROP PROCEDURE IF EXISTS insert_locacoes_clientes_pcd;
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

CALL insert_locacoes_clientes_pcd(1, 1);

SELECT * FROM vw_clientes_locacoes_clientes;
/*--------------------------------------*/

/* UPDATE CLIENTE */
DROP PROCEDURE IF EXISTS update_clientes_pcd;
DELIMITER $$
CREATE PROCEDURE update_clientes_pcd(
					p_id int,
                    p_nome varchar(45),
                    p_fone varchar(45),
                    p_endereco varchar(100)
				)
BEGIN
	UPDATE clientes 
    SET
		nome = p_nome,
        fone = p_fone,
        endereco = p_endereco
	WHERE 
		id = p_id;
END $$
DELIMITER ;

CALL update_clientes_pcd(2, "Rafael", "22213123", "igra sul");

SELECT * FROM vw_clientes;
/*--------------------------------------*/

/* DELETE CLIENTE */
DROP PROCEDURE IF EXISTS delete_clientes_pcd;
DELIMITER $$
CREATE PROCEDURE delete_clientes_pcd(p_id int)
BEGIN
	DELETE FROM clientes
	WHERE id = p_id;
END $$
DELIMITER ;

CALL delete_clientes_pcd(1);

SELECT * FROM vw_clientes;
/*--------------------------------------*/

DROP TRIGGER IF EXISTS check_if_exists_genero_trg;
DELIMITER $$
CREATE TRIGGER check_if_exists_genero_trg BEFORE INSERT ON generos
	FOR EACH ROW
BEGIN
	IF EXISTS (SELECT * FROM generos WHERE descricao = NEW.descricao) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'This genero already exists';
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS update_counter_copias_after_insert_trg;
DELIMITER $$
CREATE TRIGGER update_counter_copias_after_insert_trg AFTER INSERT ON locacoes
	FOR EACH ROW
BEGIN
	UPDATE livros
    SET copias_vendidas = (SELECT COUNT(id) FROM locacoes WHERE livros_id = NEW.livros_id)
    WHERE id = NEW.livros_id;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS update_counter_copias_after_delete_trg;
DELIMITER $$
CREATE TRIGGER update_after_insert_counter_copias AFTER DELETE ON locacoes
	FOR EACH ROW
BEGIN
	UPDATE livros
    SET copias_vendidas = (SELECT COUNT(id) FROM locacoes WHERE livros_id = OLD.livros_id)
    WHERE id = OLD.livros_id;
END $$
DELIMITER ;
 
SELECT * FROM vw_livros;
SELECT * FROM vw_locacoes;
CALL insert_livros_pcd(0, "Harry Potter", 1, 1, 0);
CALL insert_locacoes_pcd(0, '2002-10-22', '2003-10-22', 2);
CALL insert_locacoes_pcd(0, '2002-10-22', '2003-10-22', 2);
CALL insert_locacoes_pcd(0, '2002-10-22', '2003-10-22', 2);
