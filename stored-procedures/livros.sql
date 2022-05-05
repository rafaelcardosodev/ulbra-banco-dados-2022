-- FUSP que inclua e atualize livros;

DROP PROCEDURE IF EXISTS crud_livros_proc;
DELIMITER $$
	CREATE PROCEDURE 
    crud_livros_proc(
		p_action CHAR(1),
		p_id INT, 
		p_titulo VARCHAR(45),
		p_lancamento DATE,
		p_id_editora INT,
		p_id_assunto CHAR(1),
		p_preco DECIMAL(18,2)
)
	BEGIN
		DECLARE message VARCHAR(50);
        DECLARE failed BOOLEAN DEFAULT false;
		IF (p_action = 'I') THEN
			INSERT INTO livros(titulo, lancamento, id_editora, id_assunto, preco)
			VALUES (p_titulo, p_lancamento, p_id_editora, p_id_assunto, p_preco);
			SET message = 'Livro inserido';
		ELSEIF (p_action = 'U') THEN
			UPDATE livros SET 
				titulo = p_titulo,
                lancamento = p_lancamento,
                id_editora = p_id_editora,
                id_assunto = p_id_assunto,
                preco = p_preco
			WHERE id = p_id;
            SET message = 'Livro atualizado';
		ELSEIF (p_action = 'D') THEN
			DELETE FROM livros WHERE id = p_id;
            SET message = 'Livro deletado';
		ELSE
			SET failed = true;
            SET message = 'Informe I para inserir, U para atualizar ou D para deletar';
		END IF;
        IF (failed) THEN
			SELECT message;
		ELSE
			SELECT concat(message, 'com sucesso') as message;
		END IF;
    END $$
$$
CALL crud_livros_proc('I', 0, 'Programando em SQL', '2022-10-02', 1, 'B', 199);


select * from livros;
