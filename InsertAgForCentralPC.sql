INSERT INTO cadastro.cidade (id, nome) values (1002, 'ANGICAL-PI')
INSERT INTO cadastro.cidade (id, nome) values (85774, 'VARZEA GRANDE-PI')
INSERT INTO cadastro.cidade (id, nome) values (99999, 'TIMON-PI')


-- Empresa
INSERT INTO cadastro.empresa (id, nome, apelido, logomarca, inss, im) 
	select id, nome, apelido, logotipo, case inss when 0 then false else true end, im from importaag.empresa where id=1;
	SELECT setval('cadastro.empresa_id_seq', (select max(x.id) from cadastro.empresa x), true);
-- Pais
INSERT INTO cadastro.pais (id, nome, sigla)
	select id, nome, sigla from importaag.pais;
	
-- GrupoCliente
INSERT INTO cadastro.grupocliente (id, empresa_id, nome)
	select id, empresa_id, nome from importaag.grupocliente where empresa_id=1;
	SELECT setval('cadastro.grupocliente_id_seq', (select max(x.id) from cadastro.grupocliente x), true);

-- GrupoContaFinanceira
INSERT INTO ag.grupocontafinanceira (id, empresa_id, nome)
	select id, empresa_id, nome from importaag.grupocontafinanceira where empresa_id=1;
	SELECT setval('ag.grupocontafinanceira_id_seq', (select max(x.id) from ag.grupocontafinanceira x), true);
	
-- GrupoFornecedores
INSERT INTO cadastro.grupofornecedor (id, empresa_id, nome)
	select id, empresa_id, nome from importaag.grupofornecedor where empresa_id=1;
	SELECT setval('cadastro.grupofornecedor_id_seq', (select max(x.id) from cadastro.grupofornecedor x), true);

-- GrupoReceitaDespesa
INSERT INTO ag.gruporeceitadespesa (id, empresa_id, nome, totalizarresult, quebrapagina)
	select id, empresa_id, nome, case totalizaresultado when 0 then false else true end, 
	case quebrapagina when 0 then false else true end from importaag.gruporeceitadespesa where empresa_id=1;
	SELECT setval('ag.gruporeceitadespesa_id_seq', (select max(x.id) from ag.gruporeceitadespesa x), true);

-- CentroResultado
INSERT INTO ag.centroresultados (id, empresa_id, nome, centroresultadomae_id, inativo)
	select id, empresa_id, nome, centroresultadomae_id, case inativo when 0 then false else true end 
	from importaag.centroresultados where empresa_id=1;
	SELECT setval('ag.centroresultados_id_seq', (select max(x.id) from ag.centroresultados x), true);
	
-- Banco
INSERT INTO cadastro.banco (id, empresa_id, nome, numero, dv)
	select id, empresa_id, nome, numero, dv from importaag.banco where empresa_id=1;
	SELECT setval('cadastro.banco_id_seq', (select max(x.id) from cadastro.banco x), true);

-- InstrucaoCobranca
INSERT INTO ag.instrucaocobranca (id, empresa_id, nome, banco_id)
	select id, empresa_id, nome, banco_id from importaag.instrucaocobranca where empresa_id=1;
	SELECT setval('ag.instrucaocobranca_id_seq', (select max(x.id) from ag.instrucaocobranca x), true);

-- ContaFinanceira
INSERT INTO ag.contafinanceira (id, empresa_id, banco_id, grupo_id, agencia, cc, contacontabil, idimpressaocheque, nome, obs)
	select id, empresa_id, banco_id, grupo_id, agencia, cc, contacontabil, idimpressaocheque, nome, obs 
	from importaag.contafinanceira where empresa_id=1;
	SELECT setval('ag.contafinanceira_id_seq', (select max(x.id) from ag.contafinanceira x), true);

-- Estabelecimento
INSERT INTO cadastro.estabelecimento (id, empresa_id, municipio_id, nome, cnpjcpf, bairro, cep, complemento, fax, fone, ie, im, incentivofiscal, 
iss, logradouro, mnemonico, numero, optantesimples, regimeconfins, regimeespecial, regimeespecialicmssubst, retemirrf, tipo)
	select id, empresa_id, municipio_id, nome, cnpjcpf, bairro, cep, complemento, fax, fone, ie, im, 
	case incentivofiscal when 0 then false else true end, iss, logradouro, mnemonico, numero, 
	case optantesimples when 0 then false else true end, case regimecofins when 'C' then 0 else 1 end, 
	case regimeespecial when 0 then false else true end, 
	case regimeespecialicmssubst when 0 then false else true end, case retemirrf when 0 then false else true end, 
	case when LENGTH(cnpjcpf)=11 then 0 else 1 end from importaag.estabelecimento where empresa_id=1;
	SELECT setval('cadastro.estabelecimento_id_seq', (select max(x.id) from cadastro.estabelecimento x), true);

-- HistoricoPadrao -----> UPDATE importaag.historicopadrao SET historico = 'historico' WHERE historico is null
INSERT INTO cadastro.historicopadrao (id, empresa_id, descricao, historico, tipo)
	select id, empresa_id, descricao, historico, case tipo when 'L' then 0  when 'T' then 1 when 'R' then 2 when 'P' then 3 
	when 'N' then 4 when 'A' then 5 when 'C' then 6 when 'V' then 7 end from importaag.historicopadrao where empresa_id=1;
	SELECT setval('cadastro.historicopadrao_id_seq', (select max(x.id) from cadastro.historicopadrao x), true);

-- tipoDocumento
INSERT INTO cadastro.tipodocumento (id, nome, empresa_id)
	select id, nome, empresa_id from importaag.tipodocumento where empresa_id=1;
	SELECT setval('cadastro.tipodocumento_id_seq', (select max(x.id) from cadastro.tipodocumento x), true);

-- TabelaDeComissao
INSERT INTO ag.tabeladecomissao (id, nome, percentualfixeo, empresa_id)
	select id, nome, percentualfixeo, empresa_id from importaag.tabeladecomissao where empresa_id=1;
	SELECT setval('ag.tabeladecomissao_id_seq', (select max(x.id) from ag.tabeladecomissao x), true);

-- ReceitaDespesa
INSERT INTO ag.receitadespesa (id, empresa_id, nome, contacontabil, grupo_id, investimento, retemiss, reteminss, retemirrf, retempisconfinscsll,
contafinanceira_id, inativo, gerarspr, retemicms, obs, tipo, natureza, receitadespesamae_id)
	select id, empresa_id, nome, contacontabil, grupo_id, case investimento when 0 then false else true end, case retemiss when 0 then false else true end, 
	case reteminss when 0 then false else true end, case retemirrf when 0 then false else true end, case retempiscofinscsl when 0 then false else true end,
	contafinanceira_id, case inativo when 0 then false else true end, 
	case geraspr when 0 then false else true end, case retemicms when 0 then false else true end, obs, case tipo when 'A' then 0 when 'S' then 1 end, 
	case natureza when 'E' then 0 when 'S' then 1 end, receitadespesamae_id 
	from importaag.receitadespesa where empresa_id=1 Order By id;
	SELECT setval('ag.receitadespesa_id_seq', (select max(x.id) from ag.receitadespesa x), true);

-- Agente Cobrador
INSERT INTO ag.agentecobrador (id, empresa_id,nome, banco_id, prefag, dvprefag, idbloquete, bloqueteinico, bloquetefim, sequencialremessa, contafinanceira_id, codigoresponsab, codigoresponsabdv,
bordero, diasprotesto, instrucao1_id, instrucao2_id, convenente, contratocalcao, conta, dvconta, convenio, diasmulta)
	select id, empresa_id, nome, banco_id, prefag, dvprefag, idbloquete, bloqueteinico, bloquetefim, sequencialremessa, contafinanceira_id, codigoresponsab, codigoresponsabdv,
	bordero, diasprotesto, instrucao1_id, instrucao2_id, convenente, contratocalcao, conta, dvconta, convenio, diasmulta
	from importaag.agentecobrador where empresa_id=1;
	SELECT setval('ag.agentecobrador_id_seq', (select max(x.id) from ag.agentecobrador x), true);

-- Fornecedor UPDATE importaag.fornecedor SET nome = 'nome' WHERE nome is null ---> alterar o tipo dealiqinss de bigint para numeric
INSERT INTO cadastro.fornecedor (empresa_id, id, nome, cnpjcpf, grupofornecedor_id, cep, logradouro, numero, complemento, bairro, municipio_id, site, contato, receitadespesa_id, 
obs, contacontabil, rg, ie, banco_id, agencia, contacorrente, im, referencia, descprevisto, enviaremail, exterior, icms, servicopublico, finalidadeted, 
finalidadedoc, leiaute, dvagencia, email, calcinssemp, nomefantasia, dvcontacorrente, tipodeconta, fax, fone, celular, tipo)
	select f.empresa_id, f.id, f.nome, f.cnpjcpf, f.grupofornecedor_id, f.cep, f.logradouro, f.numero, f.complemento, f.bairro, 
	c.id, f.site, 
	f.contato, receitadespesa_id, f.obs, f.contacontabil, f.rg, f.ie, f.banco_id, f.agencia, f.contacorrente, f.im, f.referencia, f.descprevisto, 
	case f.enviaemail when 0 then false else true end, case f.exterior when 0 then false else true end, case f.icms when 0 then false else true end, 
	case f.servicopublico when 0 then false else true end, f.finalidadeted, f.finalidadedoc, f.leiaute, f.dvagencia, f.email, case f.calcinssemp when 0 then false else true end, 
	f.nomefantasia, f.dvcontacorrente, case f.tipodeconta when 'CC' then 0 when 'CP' then 1 end, f.fax, f.fone, f.celular, 
	case when LENGTH(f.cnpjcpf)=11 then 0 else 1 end 
	from importaag.fornecedor f left join importaag.cidade m on (f.municipio_id=m.id)
	left join cadastro.cidade c on (c.id=m.id)
	where empresa_id=1;
	SELECT setval('cadastro.fornecedor_id_seq', (select max(x.id) from cadastro.fornecedor x), true);

-- Transportadora
INSERT INTO ag.transportadora (empresa_id, nome, cnpjcpf, endereco, municipio_id, ie, contato, fone, email, fornecedor_id, rntc, placa, ufplaca)
	select t.empresa_id, t.nome, t.cnpjcpf, t.endereco, c.id, t.ie, t.contato, t.fone, t.email, t.fornecedor_id, t.rntc, t.placa, t.ufplaca 
	from importaag.transportadora t left join importaag.cidade m on (t.municipio_id=m.id)
	left join cadastro.cidade c on (c.id=m.id) where empresa_id=1;
	SELECT setval('ag.transportadora_id_seq', (select max(x.id) from ag.transportadora x), true);
-- Representante

INSERT INTO cadastro.representante (empresa_id, id, nome, cnpjcpf, tabeladecomissao_id, cep, logradouro, numero, complemento, bairro, municipio_id, fone, celular,
fax, contato, obs, email, fornecedor_id, vencimento, retemirrf, referencia)
select r.empresa_id, r.id, r.nome, r.cnpjcpf, r.tabeladecomissao_id, r.cep, r.logradouro, r.numero, r.complemento, r.bairro, c.id, r.fone, r.celular,
r.fax, r.contato, r.obs, r.email, r.fornecedor_id, case r.vencimento when 0 then false else true end, case r.retemirrf when 0 then false else true end, r.referencia 
from importaag.representante r left join importaag.cidade m on (r.municipio_id=m.id)
	left join cadastro.cidade c on (c.id=m.id) where empresa_id=1;
	SELECT setval('cadastro.representante_id_seq', (select max(x.id) from cadastro.representante x), true);

-- Cliente
INSERT INTO cadastro.cliente (empresa_id, id, nome, nomefantasia, cnpjcpf, cep, logradouro, numero, complemento, bairro, municipio_id, celular, contato, 
obs, grupocliente_id, agentecobrador_id, receitadespesa_id, vencimento, email, boleto, recibo, etique, gerarnfauto, debautomatico,
banco_id, agencia, cc, contacontabil, pagador_id, exterior, datanascimento, sexo, irrf, rg, ie, im, referencia, aliqiss, 
fone, transportadora_id, reteminss, identificador, pisdiferenciado, isentoie, vencenesimodiautil, centroresultados_id, irrfmindiferenciado, 
valorminirrf, pais_id, cobrancaimpresa, fax, indicadoriedest, confins, csll, tipo, retemiss,utilizarrg)
select c.empresa_id, c.id, case when c.nome is null then 'nome' else c.nome end, c.nomefantasia, case when c.cnpjcpf is null then '00000000000000' else c.cnpjcpf end, 
c.cep, c.logradouro, c.numero, c.complemento, c.bairro, c.cidade_id, c.celular, c.contato, 
c.obs, c.grupocliente_id, c.agentecobrador_id, c.receitadespesa_id, c.vencimento, c.email, case c.boleto when 0 then false else true end, 
case c.recibo when 0 then false else true end, case c.etiqueta when 0 then false else true end, case c.geranfauto when 0 then false else true end, 
case c.debautomatico when 0 then false else true end, c.banco_id, c.agencia, c.cc, c.contacontabil, c.pagador_id, 
case c.exterior when 0 then false else true end, c.datanascimento, c.sexo, c.irrf, c.rg, c.ie, c.im, c.referencia, c.aliqiss, 
c.fone, c.transportadora_id, case c.reteminss when 0 then false else true end, c.identificador, case c.pisdiferenciado when 0 then false else true end, case c.isentoie when 0 then false else true end, 
case c.vencenesimodiautil when 0 then false else true end, c.centroresultados_id, case c.irrfmindiferenciado when 0 then false else true end, 
c.vlrminirrf, c.pais_id, case c.cobrancaimpressa when 0 then false else true end, c.fax, c.indicadoriedestinatario, c.cofins, c.csll,
case when LENGTH(c.cnpjcpf)=11 then 0 else 1 end, false,false
from importaag.cliente c where empresa_id=1;
SELECT setval('cadastro.cliente_id_seq', (select max(x.id) from cadastro.cliente x), true);

--Contas a Pagar retirar tamanho 255 de obs e documento da tabela no banco
INSERT INTO ag.contasapagar (empresa_id, id, estabelecimento_id, fornecedor_id, centroresultado_id, tipodedocumento_id, valor, emissao, entrada, documento, insscpf, insscnpj,
inssemp, inssbase, issvalor, issbase, irrfbase, irrfcpf, irrfcnpj, pisbase, pisvalor, obs, exportaac, historicopadrao_id, valorbruto, icmsbase, icmsvalor)
	select empresa_id, id, estabelecimento_id, fornecedor_id, centroresultado_id, tipodedocumento_id, valor, emissao, entrada, documento, insscpf, insscnpj,
	inssemp, inssbase, issvalor, issbase, irrfbase, irrfcpf, irrfcnpj, pisbase, pisvalor, obs, case exportaac when 0 then false else true end, 
	historicopadrao_id, valorbruto, icmsbase, icmsvalor 
	from importaag.contasapagar where empresa_id=1;
	SELECT setval('ag.contasapagar_id_seq', (select max(x.id) from ag.contasapagar x), true);

-- contas a pagar - Vencimentos
INSERT INTO ag.contasapagarvencimentos (empresa_id, contasapagar_id, data, sequencial, numtitulo, quitado, valor, datacancelamento, motivocancelamento, autorizado, codigobarras, 
banco_id, valorbruto, enviado, desconto, agencia, cc, dvagencia, fornecedor_id, dvconta, amortizacao,
encargos) 
	select empresa_id, contasapagar_id, data, sequencial, numtitulo, quitado, valor, datacancelamento, motivocancelamento, 
	case autorizado when 0 then false else true end, codigobarras, 
	banco_id, valorbruto, case enviado when 0 then false else true end, desconto, agencia, cc, dvagencia, fornecedor_id, dvconta, amortizacao,
	encargos from importaag.contasapagarvencimentos where empresa_id=1;
	SELECT setval('ag.contasapagarvencimentos_id_seq', (select max(x.id) from ag.contasapagarvencimentos x), true);
	
-- Lancamentos
INSERT INTO ag.lancamentos (empresa_id, id, estabelecimento_id, contafinanceira_id, data, sequencial, centroresultado_id, receitadespesa_id, valor,
natureza, origem, historicopadrao_id, jaexportado, exportarac)
	select empresa_id, id, estabelecimento_id, contafinanceira_id, data, sequencial, centroresultados_id, receitadespesa_id, valor,
	case natureza when 'S' then 1 when 'E' then 0 end, case origem when 'M' then 0 when 'P' then 1 when 'D' then 2 when 'S' then 3 
	when 'O' then 4 when 'A' then 5 when 'G' then 6 when 'U' then 7 when 'H' then 8 when 'B' then 9 end, historicopadrao_id, 
	case jaexportado when 0 then false when 1 then true else false end,
	case exportaac when 0 then false else true end
	from importaag.lancamentos where empresa_id=1;
	SELECT setval('ag.lancamentos_id_seq', (select max(x.id) from ag.lancamentos x), true);

select * from importaag.cidade where id=1002
select * from cadastro.cidade order by id
select * from importaag.cidade cag left join cadastro.cidade c on (c.id=cag.id)
select * from importaag.cidade as cag, cadastro.cidade c where c.id <> cag.id

select * from cadastro.uf
select * from importaag.uf uag left join cadastro.uf uf on (uf.sigla=uag.sigla)
