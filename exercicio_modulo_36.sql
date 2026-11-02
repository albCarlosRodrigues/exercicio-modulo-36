-- Exercício 1: banco, tabelas, chaves primárias e chave estrangeira.
-- Execute em uma instalação onde o banco Empresa ainda não exista.
CREATE DATABASE Empresa CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE Empresa;

CREATE TABLE Funcionarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(80) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE Salarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT UNSIGNED NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    data_pagamento DATE NOT NULL,
    CONSTRAINT fk_salarios_funcionarios
        FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(id),
    CONSTRAINT chk_salario_nao_negativo CHECK (salario >= 0)
) ENGINE = InnoDB;

SHOW TABLES;
SHOW CREATE TABLE Funcionarios;
SHOW CREATE TABLE Salarios;


-- Exercício 2: inclusão, leitura, atualização e exclusão.
USE Empresa;

START TRANSACTION;

INSERT INTO Funcionarios (id, nome, cargo) VALUES
    (1, 'Ana Silva', 'Desenvolvedor Java'),
    (2, 'Bruno Souza', 'Desenvolvedor Java'),
    (3, 'Carla Oliveira', 'Analista de Sistemas'),
    (4, 'Diego Santos', 'Analista de Sistemas'),
    (5, 'Elisa Costa', 'Gerente de Projetos'),
    (6, 'Felipe Lima', 'Assistente Administrativo');

INSERT INTO Salarios (funcionario_id, salario, data_pagamento) VALUES
    (1, 5000.00, '2026-11-02'),
    (2, 6000.00, '2026-11-02'),
    (3, 4500.00, '2026-11-02'),
    (4, 5500.00, '2026-11-02'),
    (5, 9000.00, '2026-11-02'),
    (6, 2800.00, '2026-11-02');

-- Estado inicial: seis funcionários e seus salários.
SELECT f.id, f.nome, f.cargo, s.salario, s.data_pagamento
FROM Funcionarios AS f
INNER JOIN Salarios AS s ON s.funcionario_id = f.id
ORDER BY f.id;

UPDATE Salarios
SET salario = 5500.00
WHERE funcionario_id = 1 AND data_pagamento = '2026-11-02';

-- Comprovação do reajuste de Ana: de 5000.00 para 5500.00.
SELECT f.nome, s.salario
FROM Funcionarios AS f
INNER JOIN Salarios AS s ON s.funcionario_id = f.id
WHERE f.id = 1;

-- Primeiro o registro dependente, depois o funcionário.
DELETE FROM Salarios WHERE funcionario_id = 6;
DELETE FROM Funcionarios WHERE id = 6;

COMMIT;

-- Estado final: cinco funcionários com salários e nenhum registro órfão.
SELECT f.id, f.nome, f.cargo, s.salario, s.data_pagamento
FROM Funcionarios AS f
INNER JOIN Salarios AS s ON s.funcionario_id = f.id
ORDER BY f.id;


-- Exercício 3: média salarial dos funcionários de cada cargo.
USE Empresa;

SELECT f.cargo, ROUND(AVG(s.salario), 2) AS salario_medio
FROM Funcionarios AS f
INNER JOIN Salarios AS s ON s.funcionario_id = f.id
GROUP BY f.cargo
ORDER BY f.cargo;


-- Exercício 4: nomes, salários e cargos com junção das tabelas.
USE Empresa;

SELECT f.nome, s.salario, f.cargo
FROM Funcionarios AS f
INNER JOIN Salarios AS s ON s.funcionario_id = f.id
ORDER BY f.nome;

