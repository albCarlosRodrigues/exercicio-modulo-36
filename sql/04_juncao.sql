-- Exercício 4: nomes, salários e cargos com junção das tabelas.
USE Empresa;

SELECT f.nome, s.salario, f.cargo
FROM Funcionarios AS f
INNER JOIN Salarios AS s ON s.funcionario_id = f.id
ORDER BY f.nome;
