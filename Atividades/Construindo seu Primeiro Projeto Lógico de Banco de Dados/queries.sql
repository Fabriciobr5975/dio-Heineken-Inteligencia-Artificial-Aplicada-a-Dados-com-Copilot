use ecommerce;

show tables;

/* Quantide de Clientes */
select count(*) as 'Quantidade de Clientes' from clients;

/* Quantide de Produtos */
select count(*) as 'Quantidade de Produtos' from product;

/* Quantide de Pedidos */
select count(*) as 'Quantidade de Pedidos' from orders;

select * from clients;
select * from orders;
select * from payments;

/* Buscando o id do pedido, associado ao usuário, o status do pedido, 
a descrição do pedido e a forma de pagamento do pedido */
select idOrder as 'Id_Pedido', concat(Fname, ' ', Lname) as 'Nome_Completo',
	orderStatus as 'Status_Pedido', orderDescription as 'Descrição', 
    type_payment as 'Tipo_Pagamento'
from orders o
	inner join clients c on idClient = idOrderClient
    inner join payments on id_client = idClient
order by Nome_Completo;
    
/* Buscando todos os pedidos que foram cancelados */
select idOrder as 'Id_Pedido', concat(Fname, ' ', Lname) as 'Nome_Completo',
	orderStatus as 'Status_Pedido', orderDescription as 'Descrição', 
    type_payment as 'Tipo_Pagamento'
from orders o
	inner join clients c on idClient = idOrderClient
    inner join payments on id_client = idClient
where orderStatus = 'Cancelado';

/* Buscando todos os pedidos que foram cancelados */
select type_payment as "Tipo_Pagamento", count(type_payment) as 'Quantidade_Pagamentos_Feitas'
from orders o
	inner join clients c on idClient = idOrderClient
    inner join payments on id_client = idClient
group by idClient
having  Quantidade_Pagamentos_Feitas >= 1
order by Tipo_Pagamento;

show tables;

select * from seller;
select * from supplier;
select * from clients;
select * from product;
select * from orders;

