create database vendas;

--Borrado de las Tablas

drop table if exists PREMIOS;
drop table if exists ATENCOES;
drop table if exists PAGOS;
drop table if exists COMPRAS;
drop table if exists DIVERSOS;
drop table if exists VENDAS;
drop table if exists CAIXA_FUNCIONARIO;
drop table if exists CAIXA;
drop table if exists ARTIGO;
drop table if exists CREDITO;
drop table if exists PEDIDOS;
drop table if exists CARTAO_PREMIOS;
drop table if exists VENDEDOR;
drop table if exists DEPARTAMENTO;
drop table if exists AREA_VENDA;
drop table if exists FORNECEDOR;
drop table if exists CLIENTE;
drop table if exists COMERCIANTE;
drop table if exists FILIAL;

--Cria??o das Tabelas codigo legado Rivaldo Souza

create table FILIAL(
codigo_filial numeric(15) constraint pk_filial primary key,--C?digo de la Sucursal
localizacao varchar(20) constraint nn_filial not null,--Ubicacion de la Sucursal
cidade varchar(20) constraint nn2_filial not null--Ciudad de la Sucursal
);

create table COMERCIANTE(
cod_comerc numeric(8) constraint pk_comerciante primary key,--C?digo de Comerciante
nom_comerc varchar(30) constraint nn_comerciante not null,--Nome do Comerciante
fecha_nasc_comerc date,--Fecha de Nascimento do Comerciante
telefone varchar(20),--telefone do Comerciante
gen_Mercaderista varchar(15)--G?nero do Comerciante
);

create table CLIENTE(
cod_cli numeric(8) constraint pk_cliente primary key,--C?digo del Cliente
nome_cli varchar(30) constraint nn_cliente not null,--Nombre del Cliente
telefone varchar(20),--Tel?fono de Cliente
fecha_ac_cli date --Fecha Nacimiento de Cliente
);

create table FORNECEDOR(
codigo  numeric(8) constraint pk_fornecedor primary key,--C?digo do Fornecedor
nome varchar(30) constraint nn_fornecedor not null constraint um_forncedor unique,-- Nome do Fornecedor
telefone varchar(15),--Telefone do Fornecedor
cidade varchar(15) --Cidade do Fornecedor
);

create table AREA_VENDA(
cod_area numeric(8) constraint pk_area  primary key,--C?digo da ?rea de Venda
nome_area varchar(30) constraint nn_area not null,--Nombre del ?rea de Venta
localizacao_area varchar(20)--Localiza??o da ?rea de Venda
);

create table DEPARTAMENTO(
codigo numeric(8) constraint pk_secao  primary key,--C?digo do Departamento
nome varchar(30),--Nome do Departamento
cod_area numeric(8),--C?digo da ?rea de venda
constraint fk_secao foreign key(cod_area) references area_venda(cod_area) on delete cascade
);

create table VENDEDOR(
cod_vend numeric(8) constraint pk_vendedor primary key, --C?digo do Vendedor
nom_vend varchar(30) constraint nn_vendedor not null,--Nome do Vendedor
fecha_nasc_vend date,--Fecha Nasimiento do Vendedor
salario numeric(6),--Salario do Vendedor
cod_filial numeric(8),--C?digo de Filial
constraint fk_vendedor foreign key(cod_filial) references filial(codigo_filial) on delete cascade
);

create table CARTAO_PREMIOS(
cod_cartao numeric(8) constraint pk_cartao_premios primary key,--C?digo do Cart?o de Premios
nome varchar(30) constraint nn_cartao_premios not null--Nome do Cart?o de Premios
);

create table PEDIDOS(
num_pedido numeric(8) constraint pk_pedidos primary key,--N?mero do Pedido
tipo varchar(20) constraint nn_pedidos not null,--Tipo de Pedido
fecha_entrega_pedido date,--Fecha de Entrega do Pedido
valor_domicilio numeric(8),--Valor do domicilio do Pedido
cod_cli numeric(8),--C?digo do Cliente
constraint fk_pedidos foreign key(cod_cli) references cliente(cod_cli) on delete cascade
);

create table CREDITO(
codigo numeric(8) constraint pk_credito primary key,--C?digo do Cliente
fecha_realiza_credito date,--Fecha o Cr?dito
fecha_pago_credito date,--Fecha que Pagou
valor numeric(10),--Valor do Cr?dito
cod_cli numeric(8),--C?digo do Cliente
constraint fk_credito foreign key(cod_cli) references cliente(cod_cli) on delete cascade
);

create table ARTIGO(
codigo numeric(8) constraint pk_artigo primary key,--C?digo do Artigo
nome varchar(30) constraint nn_artigo not null,--Nome do Artigo
stock_artigo numeric(6), --Stock do ?rtigo
preco_unitario_art numeric(6),--Preco do Artigo
cod_comerc numeric(8),--C?digo do comerciante
constraint fk1_artigo foreign key(cod_comerc) references comerciante(cod_comerc) on delete cascade,
cod_dpto numeric(8),--C?digo del Departamento
constraint fk2_artigo foreign key(cod_dpto) references departamento(codigo) on delete cascade
);

create table CAIXA(
cod_caixa numeric(8) constraint pk_caixa primary key, --C?digo da Caixa
localizacao varchar(20) constraint nn_caixa not null --Localiza??o da Caixa
);

create table CAIXA_FUNCIONARIO(
cod_caixa_funcionario numeric(8) constraint pk_caixa_funcionario primary key,--C?digo da Caixa automatico
nom_caixa_funcionario varchar(30) constraint nn_caixa_funcionario not null,--Nome da Caixa automatico
genero_caixa varchar(15),--G?nero do caixa automatico
fecha_nasc_caixa date--Fecha do Nascimiento do Caixa automatico
);

create table VENDAS(
codigo numeric(8) constraint pk_venda primary key,--C?digo de venda
cod_vendedor numeric(8),--C?digo do Vendedor
constraint fk_vende foreign key(cod_vendedor) references vendedor(cod_vend) on delete cascade,
cod_artigo numeric(8),--C?digo do Art?go
constraint fk2_vende foreign key(cod_artigo) references artigo(codigo) on delete cascade,
nro_artig_vendidos numeric(6),--N?mero de Art?go Vendidos
fecha_venda date--Fecha a Venda
);

create table DIVERSOS(
num_diverso numeric(8) constraint pk_diveros primary key,--N?mero de diversos
cod_prov numeric(8),--C?digo do fornecedor
constraint fk_diversos foreign key(cod_prov) references fornecedor(codigo) on delete cascade,
cod_artigo numeric(8),--C?digo do Artigo
constraint fk2_diversos foreign key(cod_artigo) references artigo(codigo) on delete cascade,
fecha_diverso date,--Fecha diversos
nro_artig_div numeric(6)--N?mero de Artigos diversos
);

create table COMPRAS(
numero numeric(8) constraint pk_compras primary key,--N?mero da Compra
cod_cli numeric(8),--C?digo do Cliente
constraint fk_compras foreign key(cod_cli) references cliente(cod_cli) on delete cascade,
cod_artigo numeric(8),--C?digo do Artigo
constraint fk2_compras foreign key(cod_artigo) references artigo(codigo) on delete cascade,
nro_artig_comprados numeric(6),--N?mero de Artigos Comprados
fecha_compra date--Fecha a Compra
);

create table PAGOS(
num_pago numeric(8) constraint pk_pago primary key,--N?mero del Pago
cod_cliente numeric(8),--C?digo del Cliente
constraint fk_pago foreign key(cod_cliente) references cliente(cod_cli) on delete cascade,
cod_caixa numeric(8),--C?digo de la Caja
constraint fk2_pago foreign key(cod_caixa) references caixa(cod_caixa) on delete cascade,
fecha_pago date,--Fecha Pago
hora_pago date--Hora Pago
);

create table ATENCOES(
num_atencao numeric(8) constraint pk_atenciones primary key,--N?mero da Atencao
cod_caixa_funcionario numeric(8),--C?digo da Caixa funcionario
constraint fk_atenciones foreign key(cod_caixa_funcionario) references caixa_funcionario(cod_caixa_funcionario) on delete cascade,
cod_caixa numeric(8),--C?digo da caixa
constraint fk2_atencao foreign key(cod_caixa) references caixa(cod_caixa) on delete cascade,
fecha_atencao date--Fecha Atencao
);

create table PREMIOS(
numero numeric(8) constraint pk_premios primary key,--N?mero do Premio
cod_cli numeric(8),--C?digo do Cliente
constraint fk_premios foreign key(cod_cli) references cliente(cod_cli) on delete cascade,
cod_cartao numeric(8),--C?digo de premio
constraint fk2_premios foreign key(cod_cartao) references cartao_premios(cod_cartao) on delete cascade,
fecha_premio date,--Fecha en que se Ganhou o Premio
descripcao_premio varchar(30)--Descricao Premio
);

select * from public.FILIAL;
select * from public.COMERCIANTE;
select * from public.CLIENTE;
select * from public.FORNECEDOR;
select * from public.AREA_VENDA;
select * from public.DEPARTAMENTO;
select * from public.VENDEDOR;
select * from public.CARTAO_PREMIOS;
select * from public.CREDITO;
select * from public.ARTIGO;
select * from public.CAIXA;
select * from public.CAIXA_FUNCIONARIO;
select * from public.DIVERSOS;
select * from public.COMPRAS;
select * from public.PAGOS;
select * from public.ATENCOES;
select * from public.PREMIOS;
