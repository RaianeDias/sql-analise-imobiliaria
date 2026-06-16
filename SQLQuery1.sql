USE Imobiliaria;
GO

CREATE TABLE imoveis (
    id INT PRIMARY KEY,
    endereco VARCHAR(100) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    valor_aluguel DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL
);

INSERT INTO imoveis (id, endereco, tipo, valor_aluguel, status) VALUES
(1, 'Rua das Flores, 120 - Apto 32',  'Apartamento',   1800.00, 'Alugado'),
(2, 'Av. Paulista, 900 - Sala 12',    'Sala Comercial', 3200.00, 'Disponível'),
(3, 'Rua Augusta, 455 - Casa',        'Casa',          2500.00, 'Alugado'),
(4, 'Rua das Flores, 120 - Apto 11',  'Apartamento',   1500.00, 'Em manutenção'),
(5, 'Av. Brasil, 78 - Apto 5',        'Apartamento',   1700.00, 'Alugado'),
(6, 'Rua das Palmeiras, 33 - Casa',   'Casa',          2200.00, 'Disponível');


CREATE TABLE corretores (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE locatarios (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    imovel_id INT NOT NULL,
    data_contrato DATE NOT NULL,
    FOREIGN KEY (imovel_id) REFERENCES imoveis(id)
);

CREATE TABLE visitas (
    id INT PRIMARY KEY,
    imovel_id INT NOT NULL,
    corretor_id INT NOT NULL,
    data_visita DATE NOT NULL,
    FOREIGN KEY (imovel_id) REFERENCES imoveis(id),
    FOREIGN KEY (corretor_id) REFERENCES corretores(id)
);

CREATE TABLE pagamentos (
    id INT PRIMARY KEY,
    locatario_id INT NOT NULL,
    mes_referencia VARCHAR(7) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status_pagamento VARCHAR(20) NOT NULL,
    data_pagamento DATE NULL,
    FOREIGN KEY (locatario_id) REFERENCES locatarios(id)
);

INSERT INTO corretores (id, nome) VALUES
(1, 'João Pereira'),
(2, 'Marcela Souza'),
(3, 'Felipe Aguiar');

INSERT INTO locatarios (id, nome, imovel_id, data_contrato) VALUES
(1, 'Ana Costa',    1, '2024-02-01'),
(2, 'Bruno Lima',   3, '2023-11-15'),
(3, 'Carla Mendes', 5, '2024-05-10');

INSERT INTO visitas (id, imovel_id, corretor_id, data_visita) VALUES
(1, 2, 1, '2026-06-16'),
(2, 6, 2, '2026-06-17'),
(3, 2, 3, '2026-06-18'),
(4, 6, 1, '2026-06-20'),
(5, 2, 2, '2026-06-22');

INSERT INTO pagamentos (id, locatario_id, mes_referencia, valor, status_pagamento, data_pagamento) VALUES
(1, 1, '2026-04', 1800.00, 'Pago',     '2026-04-05'),
(2, 1, '2026-05', 1800.00, 'Pago',     '2026-05-04'),
(3, 1, '2026-06', 1800.00, 'Pendente', NULL),
(4, 2, '2026-04', 2500.00, 'Pago',     '2026-04-10'),
(5, 2, '2026-05', 2500.00, 'Atrasado', NULL),
(6, 2, '2026-06', 2500.00, 'Pendente', NULL),
(7, 3, '2026-04', 1700.00, 'Pago',     '2026-04-03'),
(8, 3, '2026-05', 1700.00, 'Pago',     '2026-05-02'),
(9, 3, '2026-06', 1700.00, 'Pago',     '2026-06-01');

SELECT * FROM locatarios;
SELECT * FROM pagamentos;
SELECT * FROM imoveis;

-- CONSULTA 1: Locatários com pagamentos atrasados ou pendentes
-- Junta 3 tabelas: pagamentos + locatarios + imoveis
-- para mostrar o nome do locatário e o endereço do imóvel
SELECT l.nome AS locatario, i.endereco, p.mes_referencia, p.valor, p.status_pagamento
FROM pagamentos p
JOIN locatarios l ON l.id = p.locatario_id
JOIN imoveis i ON i.id = l.imovel_id
WHERE p.status_pagamento IN ('Atrasado', 'Pendente')
ORDER BY p.status_pagamento, p.mes_referencia;
GO

-- CONSULTA 2: Total de aluguel recebido por mês
-- SUM soma os valores, GROUP BY agrupa por mês
-- Considera apenas pagamentos com status 'Pago'
SELECT mes_referencia, SUM(valor) AS total_recebido
FROM pagamentos
WHERE status_pagamento = 'Pago'
GROUP BY mes_referencia
ORDER BY mes_referencia;
GO

-- CONSULTA 3: Quantidade de visitas por corretor
-- COUNT conta quantas visitas cada corretor tem
-- DESC ordena do maior para o menor
SELECT c.nome AS corretor, COUNT(v.id) AS total_visitas
FROM visitas v
JOIN corretores c ON c.id = v.corretor_id
GROUP BY c.nome
ORDER BY total_visitas DESC;
GO

-- CONSULTA 4: Valor médio de aluguel por tipo de imóvel
-- AVG calcula a média, ROUND arredonda para 2 casas decimais
SELECT tipo, ROUND(AVG(valor_aluguel), 2) AS valor_medio
FROM imoveis
GROUP BY tipo
ORDER BY valor_medio DESC;