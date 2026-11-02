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
