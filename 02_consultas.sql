
-- CONSULTAS DE ANÁLISE
-- Autora: Raiane Dias Tito Souza
-- Execute após rodar 01_estrutura_e_dados.sql

USE Imobiliaria;
GO

-- CONSULTA 1: Locatários com pagamentos atrasados ou pendentes
-- Junta 3 tabelas: pagamentos + locatarios + imoveis
SELECT
    l.nome AS locatario,
    i.endereco,
    p.mes_referencia,
    p.valor,
    p.status_pagamento
FROM pagamentos p
JOIN locatarios l ON l.id = p.locatario_id
JOIN imoveis    i ON i.id = l.imovel_id
WHERE p.status_pagamento IN ('Atrasado', 'Pendente')
ORDER BY p.status_pagamento, p.mes_referencia;
GO

-- CONSULTA 2: Total de aluguel recebido por mês
-- SUM soma os valores, GROUP BY agrupa por mês
SELECT
    mes_referencia,
    SUM(valor) AS total_recebido
FROM pagamentos
WHERE status_pagamento = 'Pago'
GROUP BY mes_referencia
ORDER BY mes_referencia;
GO

-- CONSULTA 3: Quantidade de visitas por corretor
-- COUNT conta quantas visitas cada corretor tem
SELECT
    c.nome AS corretor,
    COUNT(v.id) AS total_visitas
FROM visitas v
JOIN corretores c ON c.id = v.corretor_id
GROUP BY c.nome
ORDER BY total_visitas DESC;
GO

-- CONSULTA 4: Valor médio de aluguel por tipo de imóvel
-- AVG calcula a média, ROUND arredonda para 2 casas decimais
SELECT
    tipo,
    ROUND(AVG(valor_aluguel), 2) AS valor_medio
FROM imoveis
GROUP BY tipo
ORDER BY valor_medio DESC;
GO