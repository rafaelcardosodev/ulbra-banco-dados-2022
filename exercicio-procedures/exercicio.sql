use store_procedures;

create table pessoa (
	id int not null auto_increment primary key,
    nome varchar(50),
	sexo char(1),
    data_nascimento date
);

DROP PROCEDURE IF EXISTS insert_pessoa_pcd;
DELIMITER $$
	CREATE PROCEDURE insert_pessoa_pcd(
		p_id int,
        p_nome varchar(50),
        p_sexo char(1),
        p_data_nascimento date
    )
	BEGIN
		INSERT INTO pessoa (nome, sexo, data_nascimento) VALUES (p_nome, p_sexo, p_data_nascimento);
        SELECT * FROM pessoa;
	END $$
$$

CALL insert_pessoa_pcd(0, 'Jessica', 'F', '2000-10-22');
CALL insert_pessoa_pcd(0, 'Rafael', 'M', '2003-03-22');

CREATE VIEW view_sexo_masculino AS
	SELECT * FROM pessoa WHERE sexo = 'M' OR sexo = 'm';

CREATE VIEW view_sexo_feminino AS
	SELECT * FROM pessoa WHERE sexo = 'F' OR sexo = 'f';
    
select * from view_sexo_masculino;
select * from view_sexo_feminino;

select current_date() - date('2000-10-11');

DROP PROCEDURE IF EXISTS count_sexo_pcd;
DELIMITER $$
CREATE PROCEDURE count_sexo_pcd()
	BEGIN
		SELECT * FROM
			(SELECT count(id) as 'qtd homens' FROM view_sexo_masculino) qtd_homens
        JOIN
			(SELECT count(id) as 'qtd mulheres' FROM view_sexo_feminino) qtd_mulheres;
	END 
$$

CALL count_sexo_pcd();

DROP PROCEDURE IF EXISTS check_maioridade_pcd;
DELIMITER $$
CREATE PROCEDURE check_maioridade_pcd()
	BEGIN
		SELECT * FROM
			(SELECT nome as "homens maiores de idade" FROM view_sexo_masculino WHERE YEAR(current_date()) - YEAR(data_nascimento) >= 18) as homem_maior_idade
		JOIN
			(SELECT nome as "homens menores de idade" FROM view_sexo_masculino WHERE YEAR(current_date()) - YEAR(data_nascimento) < 18) as homem_menor_idade
		JOIN
			(SELECT nome as "mulheres maiores de idade" FROM view_sexo_feminino WHERE YEAR(current_date()) - YEAR(data_nascimento) >= 18) as mulher_maior_idade
		JOIN
			(SELECT nome as "mulheres menores de idade" FROM view_sexo_feminino WHERE YEAR(current_date()) - YEAR(data_nascimento) < 18) as mulher_menor_idade;
    END 
$$

CALL check_maioridade_pcd();

DROP PROCEDURE IF EXISTS math_operations_pcd;
DELIMITER $$
	CREATE PROCEDURE math_operations_pcd(
		p_num1 int,
        p_num2 int
	)
    BEGIN
		SELECT (p_num1 + p_num2) as 'soma', (p_num1 - p_num2) as 'subtração', (p_num1 * p_num2) as 'multiplicaçao', (p_num1 / p_num2) as 'divisão';
    END
$$

CALL math_operations_pcd(1, 2);