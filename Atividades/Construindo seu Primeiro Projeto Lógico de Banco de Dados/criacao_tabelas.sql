/* Criação do BD para o E-commerce */
create database if not exists ecommerce;
use ecommerce;

/* Criação da Tabela do Cliente */
create table clients (
	idClient int primary key auto_increment,
    Fname varchar(10),
    Minit varchar(3),
    Lname varchar(10),
    CPF char(11) not null,
    Address varchar(30),
    constraint uk_cpf_client unique(CPF)
);

/* Criação da Tabela do Produto */
create table product (
	idProduct int primary key auto_increment,
    Pname varchar(10),
    Classification_kids boolean,
    Category ENUM('Eletrônico', 'Brinquedos', 'Vestimentas', 'Alimentos', 'Móveis'),
	Address varchar(30),
    Avaliacao float default 0,
    size varchar(10),
    constraint chk_avaliacao_product check(Avaliacao >= 0 AND Avaliacao <= 10)
);

/*	Criação da Tabela de pagamentos */
create table payments(
	id_payment int not null,
    id_client int not null, 
    type_payment ENUM('Boleto', 'Cartão de Crédito', 'Cartão de Débito', 'Dois cartões', 'PIX') not null, 
	limitAvailable float,
    primary key(id_payment, id_client)
);

/* Criação da Tabela do Pedido */
create table orders(
	idOrder int primary key auto_increment,
    idOrderClient int not null,
    id_payment int not null,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    payment_cash boolean default false,
    constraint fk_orders_client foreign key(idOrderClient) references clients(idClient),
    constraint fk_orders_payment foreign key(id_payment) references payments(id_payment)	
);

/* Criação da Tabela Estoque */
create table productStorage(
	idProdStorage int primary key auto_increment,
    storageLocation varchar(255),
    quantity int default 0
);

/* Criação da Tabela Fornecedor */
create table supplier(
	idSupplier int primary key auto_increment,
    Socialname varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) default 0,
    constraint uk_cnpj_supplier unique(CNPJ)
);

/* Criação da Tabela Vendedor */
create table seller(
	idSeller int primary key auto_increment,
    Socialname varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15) not null,
    CPF char(9) not null,
    location varchar(255),
    contact char(11) default 0,
    constraint uk_cnpj_seller unique(CNPJ),
    constraint uk_cpf_seller unique(CPF)
);

/* Criação da Tabela do Produto Vendedor */
create table productSeller(
	idPseller int,
    idProduct int,
    Quantity int default 1,
    primary key (idPseller, idProduct),
    constraint chk_quantity_product_seller check(Quantity >= 1),
    constraint fk_product_seller foreign key(idPseller) references seller(idSeller),
    constraint fk_product_product foreign key(idProduct) references product(idProduct)
);

/* Criação da Tabela do Pedido do Produto */
create table productOrder(
	idPOproduct int,
    idPOorder int,	
    poQuantity int default 1,
    posStatus ENUM('Disponível', 'Sem Estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint chk_quantity_product_order check(poQuantity >= 1),
    constraint fk_product_order_product foreign key(idPOproduct) references product(idProduct),
    constraint fk_product_orders foreign key(idPOorder) references orders(idOrder)
);

/* Criação da Tabela do Produto em Estoque */
create table storageLocation(
	idLProduct int,
    idLstorage int,	
    location int default 1,
    primary key (idLProduct, idLstorage),
    constraint fk_storage_location_product  foreign key(idLProduct) references product(idProduct),
    constraint fk_storage_location_orders foreign key(idLstorage) references orders(idOrder)
);

/* Criação da Tabela do Produto do Fornecedor */
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,	
    Quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint chk_product_supplier_quantity check(Quantity > 0), 
    constraint fk_product_supplier_supplier foreign key(idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key(idPsProduct) references product(idProduct)
);

use information_schema;
select * from referential_constraints where constraint_schema = 'ecommerce';

/* Insert into para os Clientes (Gerado pelo Copilot) */
INSERT INTO clients (Fname, Minit, Lname, CPF, Address) VALUES
('João', 'M', 'Silva', '12345678901', 'Rua A, 123'),
('Maria', 'A', 'Oliveira', '23456789012', 'Rua B, 456'),
('Carlos', 'B', 'Santos', '34567890123', 'Rua C, 789'),
('Ana', 'C', 'Souza', '45678901234', 'Rua D, 101'),
('Lucas', 'D', 'Ferreira', '56789012345', 'Rua E, 112');

/* Insert into para os Produtos (Gerado pelo Copilot) */
INSERT INTO product (Pname, Classification_kids, Category, Address, Avaliacao, size) VALUES
('Laptop', FALSE, 'Eletrônico', 'Rua X, 1000', 8.5, 'Médio'),
('Boneca', TRUE, 'Brinquedos', 'Rua Y, 2000', 9.0, 'Pequeno'),
('Camisa', FALSE, 'Vestimentas', 'Rua Z, 3000', 7.8, 'Grande'),
('Chocolate', TRUE, 'Alimentos', 'Rua W, 4000', 9.2, 'Pequeno'),
('Cadeira', FALSE, 'Móveis', 'Rua V, 5000', 8.0, 'Médio');

/* Insert into para os Pagamentos (Gerado pelo Copilot) */
INSERT INTO payments (id_payment, id_client, type_payment, limitAvailable) VALUES
(1, 1, 'Boleto', 1500.00),
(2, 2, 'Cartão de Crédito', 3000.00),
(3, 3, 'Cartão de Débito', 500.00),
(4, 4, 'PIX', 1000.00),
(5, 5, 'Dois cartões', 2000.00);

/* Insert into para os Pedidos (Gerado pelo Copilot) */
INSERT INTO orders (idOrderClient, id_payment, orderStatus, orderDescription, sendValue, payment_cash) VALUES
(1, 1, 'Confirmado', 'Compra de um Laptop', 20.00, FALSE),
(2, 2, 'Cancelado', 'Compra de uma Boneca', 15.00, TRUE),
(3, 3, 'Em processamento', 'Compra de uma Camisa', 10.00, FALSE),
(4, 4, 'Confirmado', 'Compra de Chocolate', 12.00, TRUE),
(5, 5, 'Em processamento', 'Compra de uma Cadeira', 25.00, FALSE);

/* Insert into para o Estoque (Gerado pelo Copilot) */
INSERT INTO productStorage (storageLocation, quantity) VALUES
('Depósito A', 50),
('Depósito B', 30),
('Depósito C', 20),
('Depósito D', 70),
('Depósito E', 100);

/* Insert into para os Fornecedores (Gerado pelo Copilot) */
INSERT INTO supplier (Socialname, CNPJ, contact) VALUES
('Fornecedor A', '11111111111111', '11999999999'),
('Fornecedor B', '22222222222222', '21888888888'),
('Fornecedor C', '33333333333333', '31977777777'),
('Fornecedor D', '44444444444444', '41966666666'),
('Fornecedor E', '55555555555555', '51955555555');

/* Insert into para os Vendedores (Gerado pelo Copilot) */
INSERT INTO seller (Socialname, AbstName, CNPJ, CPF, location, contact) VALUES
('Vendedor A', 'Alias A', '66666666666666', '123456789', 'Rua F, 123', '11999999998'),
('Vendedor B', 'Alias B', '77777777777777', '234567890', 'Rua G, 456', '21888888887'),
('Vendedor C', 'Alias C', '88888888888888', '345678901', 'Rua H, 789', '31977777776'),
('Vendedor D', 'Alias D', '99999999999999', '456789012', 'Rua I, 101', '41966666665'),
('Vendedor E', 'Alias E', '00000000000000', '567890123', 'Rua J, 112', '51955555554');

/* Insert into para os Pedidos dos Produtos (Gerado pelo Copilot) */
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, posStatus) VALUES
(1, 1, 1, 'Disponível'),
(2, 2, 1, 'Sem Estoque'),
(3, 3, 1, 'Disponível'),
(4, 4, 1, 'Disponível'),
(5, 5, 1, 'Sem Estoque');

/* Insert into para os Produto em Estoque (Gerado pelo Copilot) */
INSERT INTO storageLocation (idLProduct, idLstorage, location) VALUES
(1, 1, 101),
(2, 2, 102),
(3, 3, 103),
(4, 4, 104),
(5, 5, 105);

/* Insert into para os Produtos dos Fornecedores (Gerado pelo Copilot) */
INSERT INTO productSupplier (idPsSupplier, idPsProduct, Quantity) VALUES
(1, 1, 50),
(2, 2, 30),
(3, 3, 20),
(4, 4, 70),
(5, 5, 100);

