use oficina_mecanica;

show tables;

/* Detalhando a Ordem de Serviço, colocando o tipo de serviço e o seu preço */
select os.id_ordem_servico as 'Identificação', os.data_emissao as 'Data_de_Emissão',
	os.valor as 'Valor_Ordem_Serviço', os.detalhes_adicionais, ts.nome_servico, ts.valor as 'Valor_Serviço'
from ordem_servico os
	inner join servico s using(id_servico)
    inner join servico_tem_tipo_servico sts on sts.id_servico = s.id_servico
    inner join tipo_servico ts using(id_tipo_servico)
order by Data_de_Emissão;

select os.id_ordem_servico as 'Identificação', os.data_emissao as 'Data_de_Emissão',
	os.valor as 'Valor_Ordem_Serviço', os.detalhes_adicionais, ts.nome_servico, ts.valor as 'Valor_Serviço'
from ordem_servico os
	inner join servico s using(id_servico)
    inner join servico_tem_tipo_servico sts on sts.id_servico = s.id_servico
    inner join tipo_servico ts using(id_tipo_servico)
order by Data_de_Emissão;

/* Pegando os dados do veículo, do mecânico, a situação do ordem de serviço
 as datas da geração do serviço e de sua emissão */
select aos.id_autorizacao_ordem_servico as 'Identificação', aos.status,
	nome_veiculo, concat(p.primeiro_nome, ' ', p.ultimo_nome) as "Nome_do_Mecânico",
    s.data_geracao_servico as 'Data_Geração_Serviço', os.data_emissao as 'Data_Emissão'
from autorizacao_ordem_servico aos
	inner join cliente c on c.id_pessoa = aos.id_cliente 
    inner join veiculo v on v.id_cliente = c.id_pessoa
	inner join mecanico_gera_servico mgs using(id_veiculo)
    inner join mecanico m on m.id_pessoa = mgs.id_mecanico
    inner join pessoa p on p.id_pessoa = m.id_pessoa
    inner join servico s using(id_servico)
    inner join ordem_servico os using(id_servico)
order by Data_Geração_Serviço;

/* Calculando o valor total das ordens de serviço */
select sum(valor) as 'ValorTotal' from ordem_servico;

