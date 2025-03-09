create database if not exists oficina_mecanica;
use oficina_mecanica;

create table pessoa (
	id_pessoa int primary key auto_increment,
    primeiro_nome varchar(15) not null,
    ultimo_nome varchar(15) not null,
    cpf char(11) not null unique
);

create table cliente (
	id_pessoa int primary key,
    constraint fk_cliente_pessoa foreign key(id_pessoa) references pessoa (id_pessoa)
);

create table mecanico(
	id_pessoa int primary key,
    especializacao varchar(45) not null default 'Geral',
	constraint fk_mecanico_pessoa foreign key(id_pessoa) references pessoa (id_pessoa)
);

create table veiculo(
	id_veiculo int primary key auto_increment,
    nome_veiculo varchar(50) not null,
    id_cliente int not null,
    constraint fk_veiculo_cliente foreign key(id_cliente) references cliente(id_pessoa)
);

create table mecanico_analisa_veiculo (
	id_mecanico int not null,
    id_veiculo int not null,
    primary key (id_mecanico, id_veiculo),
    constraint fk_mecanico_analisa_veiculo foreign key(id_mecanico) references mecanico(id_pessoa),
    constraint fk_veiculo_analisado foreign key(id_veiculo) references veiculo(id_veiculo)
);

create table servico(
	id_servico int primary key auto_increment,
    data_geracao_servico datetime not null
);

create table mecanico_gera_servico(
	id_mecanico int not null,
    id_veiculo int not null,
    id_servico int not null,
    primary key(id_mecanico, id_veiculo, id_servico),
    constraint fk_gerar_servico_veiculo foreign key(id_mecanico, id_veiculo) references mecanico_analisa_veiculo(id_mecanico, id_veiculo),
    constraint fk_mecanico_gerando_servico foreign key(id_mecanico) references mecanico(id_pessoa),
    constraint fk_gerar_servico foreign key(id_veiculo) references veiculo(id_veiculo)
);

create table tipo_servico(
	id_tipo_servico int primary key auto_increment,
    nome_servico varchar(45) not null unique,
    valor float not null,
    constraint chk_valor_tipo_servico check(valor >= 0)
);

create table servico_tem_tipo_servico(
	id_tipo_servico int not null,
    id_servico int not null,
    primary key (id_tipo_servico, id_servico),
    constraint fk_tipo_servico foreign key(id_tipo_servico) references tipo_servico(id_tipo_servico),
    constraint fk_servico foreign key(id_servico) references servico(id_servico)
);

create table mao_de_obra(
	id_mao_de_obra int primary key auto_increment,
    valor int not null default '100.0',
    constraint chk_valor_mao_de_obra check(valor >= 100.0)
);

create table ordem_servico(
	id_ordem_servico int primary key auto_increment,
    data_emissao datetime not null,
    valor float not null,
    data_conclusao_servico date,
    detalhes_adicionais varchar(45),
    id_servico int not null,
    id_mao_de_obra int not null,
    constraint fk_servico_ordem_servico foreign key(id_servico) references servico(id_servico),
    constraint fk_mao_de_obra_ordem_servico foreign key(id_mao_de_obra) references mao_de_obra(id_mao_de_obra)
);

create table peca(
	id_peca int primary key auto_increment,
    nome_peca varchar(50) not null,
    preco float not null,
    constraint chk_preco_peca check(preco >= 0)
);

create table peca_ordem_servico(
	id_peca int not null,
    id_ordem_servico int not null,
    constraint fk_peca_utilizada_ordem_servico foreign key(id_peca) references peca(id_peca),
    constraint fk_peca_ordem_servico foreign key(id_ordem_servico) references ordem_servico(id_ordem_servico)
);

create table autorizacao_ordem_servico (
	id_autorizacao_ordem_servico int primary key auto_increment,
    status varchar(45) not null,
    detalhes_adicionais varchar(45),
    id_cliente int not null,
    id_ordem_servico int not null,
    constraint fk_autorizacao_ordem_servico_cliente foreign key(id_cliente) references cliente(id_pessoa),
    constraint fk_autorizacao_ordem_servico foreign key(id_ordem_servico) references ordem_servico(id_ordem_servico)
);

create table execucao_servico(
	id_execucao_servico int not null,
    id_autorizacao_ordem_servico int not null,
    primary key (id_execucao_servico, id_autorizacao_ordem_servico),
    constraint fk_autorizacao_execucao_servico foreign key(id_autorizacao_ordem_servico) references autorizacao_ordem_servico(id_autorizacao_ordem_servico)
);

show tables;