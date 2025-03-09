use oficina_mecanica;

/* Os dados foram gerados pelo Copilot */

INSERT INTO pessoa (primeiro_nome, ultimo_nome, cpf) VALUES
-- Clientes
('João', 'Silva', '12345678901'),
('Maria', 'Oliveira', '23456789012'),
('Carlos', 'Santos', '34567890123'),
('Ana', 'Souza', '45678901234'),
('Lucas', 'Ferreira', '56789012345'),
-- Mecânicos
('Pedro', 'Lima', '67890123456'),
('Paula', 'Mendes', '78901234567'),
('Rafael', 'Cruz', '89012345678'),
('Marina', 'Gomes', '90123456789'),
('Fernando', 'Barros', '01234567890');

INSERT INTO cliente (id_pessoa) VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO mecanico (id_pessoa, especializacao) VALUES
(6, 'Motor'),
(7, 'Suspensão'),
(8, 'Transmissão'),
(9, 'Freios'),
(10, 'Geral');

INSERT INTO veiculo (nome_veiculo, id_cliente) VALUES
('Carro A', 1),
('Carro B', 2),
('Carro C', 3),
('Carro D', 4),
('Carro E', 5);

INSERT INTO mecanico_analisa_veiculo (id_mecanico, id_veiculo) VALUES
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 5);

INSERT INTO servico (data_geracao_servico) VALUES
('2025-03-09 10:00:00'),
('2025-03-09 11:00:00'),
('2025-03-09 12:00:00'),
('2025-03-09 13:00:00'),
('2025-03-09 14:00:00');

INSERT INTO mecanico_gera_servico (id_mecanico, id_veiculo, id_servico) VALUES
(6, 1, 1),
(7, 2, 2),
(8, 3, 3),
(9, 4, 4),
(10, 5, 5);

INSERT INTO tipo_servico (nome_servico, valor) VALUES
('Troca de Óleo', 150.0),
('Alinhamento', 100.0),
('Balanceamento', 120.0),
('Revisão Geral', 300.0),
('Troca de Filtro', 80.0);

INSERT INTO servico_tem_tipo_servico(id_tipo_servico, id_servico) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO mao_de_obra (valor) VALUES
(150.0),
(200.0),
(250.0),
(300.0),
(350.0);

INSERT INTO ordem_servico (data_emissao, valor, data_conclusao_servico, detalhes_adicionais, id_servico, id_mao_de_obra) VALUES
('2025-03-09 10:00:00', 500.0, '2025-03-10', 'Troca de Óleo', 1, 1),
('2025-03-09 11:00:00', 600.0, '2025-03-11', 'Alinhamento', 2, 2),
('2025-03-09 12:00:00', 700.0, '2025-03-12', 'Balanceamento', 3, 3),
('2025-03-09 13:00:00', 800.0, '2025-03-13', 'Revisão Geral', 4, 4),
('2025-03-09 14:00:00', 900.0, '2025-03-14', 'Troca de Filtro', 5, 5);

INSERT INTO peca (nome_peca, preco) VALUES
('Filtro de Óleo', 50.0),
('Pneu', 400.0),
('Pastilha de Freio', 150.0),
('Amortecedor', 200.0),
('Correia Dentada', 100.0);

INSERT INTO peca_ordem_servico (id_peca, id_ordem_servico) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO autorizacao_ordem_servico (status, detalhes_adicionais, id_cliente, id_ordem_servico) VALUES
('Autorizado', 'Cliente João', 1, 1),
('Autorizado', 'Cliente Maria', 2, 2),
('Autorizado', 'Cliente Carlos', 3, 3),
('Autorizado', 'Cliente Ana', 4, 4),
('Autorizado', 'Cliente Lucas', 5, 5);

INSERT INTO execucao_servico (id_execucao_servico, id_autorizacao_ordem_servico) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
