use funcionarios_db;

create table setores(
	id int not null auto_increment primary key,
    nome varchar(50) not null,
    total_salario decimal(12,2) default 0
);

create table funcionarios(
	id int not null auto_increment primary key,
    nome varchar(70) not null,
    salario decimal(12,2) default 0,
    id_setor int not null,
    constraint setor_has_funcionarios_fk foreign key (id_setor)
		references setores(id)
			on update cascade
			on delete restrict
);

insert into setores (nome)
values ('Desenvolvimento'), ('Suporte'), ('Administrativo'), ('Financeiro'), ('Estoque');

select * from setores;

DROP TRIGGER IF EXISTS trigger_salario_vetor;
DELIMITER $$
CREATE TRIGGER trigger_salario_vetor AFTER INSERT ON funcionarios
	FOR EACH ROW
BEGIN
	UPDATE setores SET total_salario = total_salario + NEW.salario
    WHERE id = NEW.id_setor;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_update_salario_after_delete;
DELIMITER $$
CREATE TRIGGER trigger_update_salario_after_delete AFTER DELETE ON funcionarios
	FOR EACH ROW
BEGIN
	UPDATE setores SET total_salario = total_salario - OLD.salario
    WHERE id = OLD.id_setor;
END $$

DROP TRIGGER IF EXISTS trigger_update_salario_after_update;
DELIMITER $$
CREATE TRIGGER trigger_update_salario_after_update AFTER UPDATE ON funcionarios
	FOR EACH ROW
BEGIN
	DECLARE tipo varchar(40);
	UPDATE setores SET total_salario = total_salario + (NEW.salario - OLD.salario)
    WHERE id = NEW.id_setor;
    IF (NEW.salario > OLD.salario) THEN
		SET tipo = 'aumentou ';
    ELSE 
		SET tipo = 'reduziu ';
    END IF;
    IF (NEW.salario <> OLD.salario) THEN
		INSERT INTO logs2 (message, data_log) 
		VALUES (concat('Salário do ', 
						NEW.nome, 
                        tipo,
						' para R$', 
						NEW.salario), current_timestamp);
	END IF;
END $$


insert into funcionarios (nome, salario,id_setor)
	values('Rafael', '12900',1);
insert into funcionarios (nome, salario,id_setor)
	values('Joao da silva', '2950',1);
insert into funcionarios (nome, salario,id_setor)
	values('alice nascimento', '7500',3);
    
delete from funcionarios;
    
update funcionarios set salario = 5400 where id = 17;
select * from funcionarios;
select * from setores;
select * from logs2;

-- log para guardar as atualizaçoes de salarios
create table logs2(
	id int not null auto_increment primary key,
    message varchar(2000) not null,
    data_log timestamp
);

    
