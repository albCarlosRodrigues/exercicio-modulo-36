-- Exercício 3: média salarial dos funcionários de cada cargo.
USE Empresa;

SELECT f.cargo, ROUND(AVG(s.salario), 2) AS salario_medio
FROM Funcionarios AS f
INNER JOIN Salarios AS s ON s.funcionario_id = f.id
GROUP BY f.cargo
ORDER BY f.cargo;
