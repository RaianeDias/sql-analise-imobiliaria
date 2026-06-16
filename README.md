## Análise de Dados de uma Imobiliária com SQL

Projeto criado para praticar **SQL Server (T-SQL)**, simulando o dia a dia
de uma imobiliária: controle de imóveis, locatários, corretores, visitas
agendadas e pagamentos de aluguel.

A ideia surgiu da minha experiência como recepcionista em uma imobiliária,
onde eu lidava diariamente com cadastro de imóveis, controle de documentos,
agendamento de visitas e organização de boletos e pagamentos.



## Estrutura do banco de dados

| Tabela | Descrição |
|---|---|
| `imoveis` | Endereço, tipo, valor do aluguel e status |
| `corretores` | Corretores responsáveis pelas visitas |
| `locatarios` | Locatários e o imóvel que ocupam |
| `visitas` | Visitas agendadas (imóvel + corretor) |
| `pagamentos` | Pagamentos de aluguel por mês (Pago, Pendente, Atrasado) |

---

## Arquivos

- `01_estrutura_e_dados.sql` — criação das tabelas e inserção dos dados
- `02_consultas.sql` — consultas de análise com comentários explicativos

---

## Consultas de análise

1. **Locatários com pagamentos atrasados ou pendentes** — usa `JOIN` para cruzar 3 tabelas
2. **Total de aluguel recebido por mês** — usa `SUM` + `GROUP BY`
3. **Quantidade de visitas por corretor** — usa `COUNT` + `GROUP BY`
4. **Valor médio de aluguel por tipo de imóvel** — usa `AVG` + `ROUND`



## Como executar

1. Abra o **SQL Server Management Studio (SSMS)**
2. Execute `01_estrutura_e_dados.sql` para criar o banco e inserir os dados
3. Execute `02_consultas.sql` para rodar as análises



## Conceitos praticados

`CREATE DATABASE` · `CREATE TABLE` · `PRIMARY KEY` · `FOREIGN KEY` ·
`INSERT INTO` · `SELECT` · `WHERE` · `ORDER BY` · `JOIN` · `GROUP BY` ·
`SUM` · `COUNT` · `AVG` · `ROUND` · `NULL`



Projeto desenvolvido por **Raiane Dias Tito Souza**  
Estudante de Análise e Desenvolvimento de Sistemas — UNIP  
