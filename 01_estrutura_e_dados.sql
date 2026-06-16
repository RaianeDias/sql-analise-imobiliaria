
-- PROJETO: Gestão de Imóveis e Locatários (Imobiliária)
-- Autora: Raiane Dias Tito Souza
-- Versão: SQL Server (T-SQL) - SSMS 21

USE Imobiliaria;
GO

CREATE TABLE imoveis (
    id            INT PRIMARY KEY,
    endereco      VARCHAR(100) NOT NULL,
    tipo          VARCHAR(30)  NOT NULL,
    valor_aluguel DECIMAL(10,2) NOT NULL,
    status        VARCHAR(20)  NOT NULL
);

INSERT INTO imoveis (id, endereco, tipo, valor_aluguel, status) VALUES
(1, 'Rua das Flores, 120 - Apto 32',  'Apartamento',    1800.00, 'Alugado'),
(2, 'Av. Paulista, 900 - Sala 12',    'Sala Comercial', 3200.00, 'Disponível'),
(3, 'Rua Augusta, 455 - Casa',        'Casa',           2500.00, 'Alugado'),
(4, 'Rua das Flores, 120 - Apto 11',  'Apartamento',    1500.00, 'Em manutenção'),
(5, 'Av. Brasil, 78 - Apto 5',        'Apartamento',    1700.00, 'Alugado'),
(6, 'Rua das Palmeiras, 33 - Casa',   'Casa',           2200.00, 'Disponível');
GO

CREATE TABLE corretores (
    id   INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE locatarios (
    id            INT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    imovel_id     INT NOT NULL,
    data_contrato DATE NOT NULL,
    FOREIGN KEY (imovel_id) REFERENCES imoveis(id)
);

CREATE TABLE visitas (
    id          INT PRIMARY KEY,
    imovel_id   INT NOT NULL,
    corretor_id INT NOT NULL,
    data_visita DATE NOT NULL,
    FOREIGN KEY (imovel_id)   REFERENCES imoveis(id),
    FOREIGN KEY (corretor_id) REFERENCES corretores(id)
);

CREATE TABLE pagamentos (
    id               INT PRIMARY KEY,
    locatario_id     INT NOT NULL,
    mes_referencia   VARCHAR(7) NOT NULL,
    valor            DECIMAL(10,2) NOT NULL,
    status_pagamento VARCHAR(20) NOT NULL,
    data_pagamento   DATE NULL,
    FOREIGN KEY (locatario_id) REFERENCES locatarios(id)
);
GO

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
GO