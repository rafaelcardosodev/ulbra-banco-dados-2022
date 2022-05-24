

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
    VALUES
		(p_nome, p_fone, p_endereco);
END $$
DELIMITER ;

CALL insert_clientes_pcd(0, "marcio", "22222", "rua cabo braga");



                        