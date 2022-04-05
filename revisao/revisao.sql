create database exercicio_revisao;

use exercicio_revisao;

create table cidades (
	id int not null primary key auto_increment,
    nome varchar(60) not null,
    uf char(2) not null
);

insert into cidades (nome, uf) values ("Santa Catarina", "SC");
insert into cidades (nome, uf) values ("Sao Paulo", "SP");
insert into cidades (nome, uf) values ("Rio de Janeiro", "RJ");
insert into cidades (nome, uf) values ("Rio Grande do Sul", "RS");

select * from cidades;

create table produtos (
	id int not null primary key auto_increment,
    descricao varchar(100),
    preco double not null,
    nome_categoria varchar(50),
    descricao_categoria varchar(100)
);

insert into produtos (descricao, preco, nome_categoria, descricao_categoria) values ("TV", 200.00, "Eletronicos", "Aparelhos"); 
insert into produtos (descricao, preco, nome_categoria, descricao_categoria) values ("Sabao", 10.00, "Saude", "Higiene"); 
insert into produtos (descricao, preco, nome_categoria, descricao_categoria) values ("PS4", 2200.00, "Eletronicos", "Aparelhos"); 
insert into produtos (descricao, preco, nome_categoria, descricao_categoria) values ("Café", 23.00, "Comida", "Pó"); 

select * from produtos;

create table filiais (
	id int not null primary key auto_increment,
    nome varchar(60) not null,
    endereco varchar(100) not null,
    id_cidades int not null,
    constraint fk_filiais_cidades 
		foreign key (id_cidades) references cidades(id)
);

insert into filiais (nome, endereco, id_cidades) values ("f3", "teste", 7);
insert into filiais (nome, endereco, id_cidades) values ("f2", "teste", 8);

select * from filiais;

create table vendas (
	id int not null primary key auto_increment,
    id_produtos int not null,
    id_filiais int not null,
    constraint fk_vendas_produtos
		foreign key (id_produtos) references produtos(id),
    constraint fk_vendas_filiais
		foreign key (id_filiais) references filiais(id)
);

insert into vendas (id_produtos, id_filiais) values (3, 1);
insert into vendas (id_produtos, id_filiais) values (4, 1);
insert into vendas (id_produtos, id_filiais) values (5, 2);
insert into vendas (id_produtos, id_filiais) values (6, 2);

create table empregados (
	id int not null primary key auto_increment,
    nome varchar(60) not null,
    endereco varchar(100) not null,
    ct double not null,
    rg varchar(14) not null,
    cpf varchar(20) not null,
    id_cidade int not null,
    id_filial int not null,
    constraint fk_empregados_cidades
		foreign key (id_cidade) references cidades(id),
	constraint fk_empregados_filiais
		foreign key (id_filial) references filiais(id)
);

insert into empregados (nome, endereco, ct, rg, cpf, id_cidade, id_filial) values ("Mario", "Torres", 231, "1111", "032", 10, 1);
insert into empregados (nome, endereco, ct, rg, cpf, id_cidade, id_filial) values ("Joao", "Torres", 760.00, "2222", "033", 10, 1);
insert into empregados (nome, endereco, ct, rg, cpf, id_cidade, id_filial) values ("Silio", "Bahia", 1060.00, "3333", "031", 9, 2);

select * from empregados;

/* exercicio 3 - letra b */
select max(preco), descricao from produtos;

/* exercicio 3 - letra c */
select avg(preco) from produtos;

/* exercicio 3 - letra d */
select produtos.descricao 
from ((produtos
	inner join vendas on vendas.id_produtos = produtos.id)
    inner join filiais on filiais.id = vendas.id_filiais)
where filiais.nome = "f3";

/* exercicio 3 - letra e */
select * from empregados;
select empregados.nome, empregados.rg 
from empregados
	inner join cidades on cidades.id = empregados.id_cidade
where cidades.uf = "rs" and ct > 500;

/* ----------------------------------------------------------------- */

create database exercicio_revisao_2;

use exercicio_revisao_2;

create table categorias (
	id int not null primary key auto_increment,
    nome varchar(60) not null,
    descricao varchar(100) not null
);

insert into categorias (nome, descricao) values ("Sommervile", "Banco de Dados");
insert into categorias (nome, descricao) values ("Game of Thrones", "Fantasia");
insert into categorias (nome, descricao) values ("Engenharia de Software", "Banco de Dados");

select * from categorias;

create table cidades (
	id int not null primary key auto_increment,
    nome varchar(60) not null,
    uf char(2) not null
);

insert into cidades (nome, uf) values ("Santa Catarina", "SC");
insert into cidades (nome, uf) values ("Sao Paulo", "SP");
insert into cidades (nome, uf) values ("Rio de Janeiro", "RJ");
insert into cidades (nome, uf) values ("Rio Grande do Sul", "RS");

select * from cidades;

create table autores (
	id int not null primary key auto_increment,
    nome varchar(60) not null,
    id_cidades int not null,
    constraint fk_autores_cidades 
		foreign key (id_cidades)
			references cidades(id)
);

insert into autores (nome, id_cidades) values ("Marcos", 1);
insert into autores (nome, id_cidades) values ("Joao", 1);
insert into autores (nome, id_cidades) values ("Zé", 2);
insert into autores (nome, id_cidades) values ("Airton", 2);
insert into autores (nome, id_cidades) values ("Nelson", 3);
insert into autores (nome, id_cidades) values ("Marcelo", 3);
insert into autores (nome, id_cidades) values ("Vitor", 4);
insert into autores (nome, id_cidades) values ("Guanabara", 4);

select * from autores;

create table livros (
	id int not null primary key auto_increment,
	titulo varchar(60) not null,
    numFolhas int not null,
    editora varchar(60) not null,
    valor double not null,
    id_autores int not null,
    id_categorias int not null,
    constraint fk_livros_autores
		foreign key (id_autores)
			references autores(id),
	constraint fk_livros_categorias
		foreign key (id_categorias)
			references categorias(id)
				on delete cascade
);

insert into livros (titulo, numFolhas, editora, valor, id_autores, id_categorias) values ("Game of Thrones", 1200, "SP", 300, 1, 2);
insert into livros (titulo, numFolhas, editora, valor, id_autores, id_categorias) values ("Introduçao ao BD", 200, "RS", 300, 2, 1);
insert into livros (titulo, numFolhas, editora, valor, id_autores, id_categorias) values ("Introduçao a ES", 1500, "Ppapapa", 6300, 3, 3);
insert into livros (titulo, numFolhas, editora, valor, id_autores, id_categorias) values ("Clean Code", 1500, "Ppapapa", 2300, 3, 3);

select * from livros;

create table clientes (
	id int not null primary key auto_increment,
    nome varchar(60) not null,
    endereco varchar(100) not null,
    id_cidades int not null,
    constraint fk_clientes_cidades foreign key (id_cidades)
		references cidades(id)
);

insert into clientes (nome, endereco, id_cidades) values ("Joao", "ttt", 1);
insert into clientes (nome, endereco, id_cidades) values ("Marcio", "sss", 2);
insert into clientes (nome, endereco, id_cidades) values ("Nelson", "xxx", 3);
insert into clientes (nome, endereco, id_cidades) values ("Cassio", "fff", 3);

select * from clientes;

create table vendas (
	id int not null primary key auto_increment,
    quantidade int not null,
    dataVenda date not null,
    id_livros int not null,
    id_clientes int not null,
    constraint fk_vendas_produtos
		foreign key (id_produtos) references produtos(id),
    constraint fk_vendas_filiais
		foreign key (id_filiais) references filiais(id)
);

insert into vendas (quantidade, dataVenda, id_livros, id_clientes) values (23, localtime(), 1, 1);
insert into vendas (quantidade, dataVenda, id_livros, id_clientes) values (33, localtime(), 2, 2);
insert into vendas (quantidade, dataVenda, id_livros, id_clientes) values (12, localtime(), 3, 3);
insert into vendas (quantidade, dataVenda, id_livros, id_clientes) values (12, localtime(), 4, 3);
insert into vendas (quantidade, dataVenda, id_livros, id_clientes) values (55, localtime(), 1, 3);
insert into vendas (quantidade, dataVenda, id_livros, id_clientes) values (77, localtime(), 1, 3);


/* exercicio 5 - a */
select count(*) as "total de vendas" from vendas;

/* exercicio 5 - b */
select livros.titulo, livros.valor, categorias.nome as categoria 
from livros
	inner join categorias on livros.id_categorias = categorias.id
where categorias.nome = "Banco de Dados";

/* exercicio 5 - c */
select livros.titulo as "livro", clientes.nome as "cliente", cidades.nome as "cidade" , cidades.uf
from (((livros
	inner join vendas on vendas.id_livros = livros.id)
    inner join clientes on clientes.id = vendas.id_clientes)
    inner join cidades on clientes.id_cidades = cidades.id)
where livros.valor > 300;

/* exercicio 5 - d */
select clientes.nome, livros.titulo
from ((clientes
	inner join vendas on vendas.id_clientes = clientes.id)
    inner join livros on livros.id = vendas.id_livros);

/* exercicio 5 - e */
select livros.id, livros.titulo, autores.nome
from livros
	inner join autores on livros.id_autores = autores.id
    inner join vendas on vendas.id_livros = livros.id
where month(vendas.dataVenda) = 03 and year(vendas.dataVenda) = 2021;

/* exercicio 5 - f */
select livros.titulo, autores.nome 
from livros
	inner join autores on livros.id_autores = autores.id
    inner join vendas on vendas.id_livros = livros.id
order by vendas.quantidade
limit 5;

/* exercicio 5 - g */
select clientes.nome
from clientes
	inner join vendas on vendas.id_clientes = clientes.id
    inner join livros on vendas.id_livros = livros.id
where livros.titulo = "Banco de dados powerful";