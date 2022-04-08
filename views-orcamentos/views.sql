create table produtos (
	id int not null primary key auto_increment,
    nome varchar(60) not null,
    saldo double
);

create table orcamentos (
	id int not null primary key auto_increment,
    data date,
    status varchar(60)
);

create table orcamentos_itens (
	id_produtos int not null,
    id_orcamento int not null,
    valor_unit double not null,
    quantidade int not null,
    valor_total_item double not null,
    constraint fk_orcamentositens_produtos foreign key (id_produtos) references produtos(id), 
    constraint fk_orcamentositens_orcamentos foreign key (id_orcamento) references orcamentos(id) 
);

insert into produtos (nome, valor, saldo) 
values
	("Televisão", 1000, 5),
	("Computador", 670, 2),
	("Mini Computador", 352, 6),
	("Alface", 3.22, 12);

insert into orcamentos (data, status) 
values
	('2021-03-22', "processando"),
	('2018-08-17', "sucesso"),
	('2021-11-02', "falha"),
	('2019-12-21', "falha"),
	('2021-03-28', "sucesso");
    
insert into orcamentos_itens (id_produtos, id_orcamento, valor_unit, quantidade, valor_total_item)
values
	(1, 1, 1000, 2, 2000), 
	(2, 1, 1000, 2, 2000), 
	(3, 2, 352, 2, (352*2)), 
	(3, 3, 352, 2, (352*2)), 
	(3, 4, 3.22, 2, (3.22*2)), 
	(4, 5, 3.22, 5, (3.22*5)); 

create view orcamentos_view
as
select orcamentos_itens.id_orcamento, orcamentos_itens.id_produtos, data, status, nome, saldo, valor_unit, quantidade, valor_total_item
from orcamentos
	inner join orcamentos_itens on orcamentos_itens.id_orcamento = orcamentos.id
	inner join produtos on produtos.id = orcamentos_itens.id_produtos;

select 	sum(valor_total_item) as total
from orcamentos_view
where data between '2022-03-01' and '2022-03-31';

select id_orcamento, data, status
from orcamentos_view
where nome like 'computador%';

select id_produtos, nome, count(id_produtos) as quantas_vezes
from orcamentos_view
where data between '2014-09-01' and '2014-09-30' and 
	saldo>0 and valor > 500
group by id_produtos, nome
order by quantas_vezes desc
limit 10;

select (valor_unit * 1.2), saldo
from orcamentos_view
where saldo <= 5;

/* GROUP BY deve ser utilizado quando deseja-se agrupar dados baseado em um parametro*/
select nome, id_produtos 
from orcamentos_view
group by nome;

/*HAVING é uma alternativa ao WHERE que permite utilizar funçoes como o count() para comparar*/
select nome, saldo, count(id_produtos)
from orcamentos_view
group by saldo
having count(id_produtos) > 1;

/* UNION é usado para combinar dois SELECTS feitos em tabelas diferentes (que possuem o mesmo numero de colunas, tipos de dado e na mesma ordem)*/
/*muito similar a um JOIN*/

select coluna from tabela1
union
select coluna from tabela2;

/*LEFT JOIN irá retornar todos os dados da tabela da esquerda (from tabela1) e os dados da tabela da direita
que satisfaçam a condiçao do join, retornando 0 se nao houver nenhum dado */

select produtos.nome
from produtos
	left join orcamentos_itens on produtos.id = orcamentos_itens.id_produtos;