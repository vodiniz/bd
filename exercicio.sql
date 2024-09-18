-- 1
SELECT NomeFunc, DataNasc
FROM Funcionario
WHERE NomeFunc == 'Joao Silva';


-- 2
SELECT E.NomeFunc, Endereco
FROM Funcionario as F, Departamento as D
WHERE (ID_Depto = D.ID_Depto) AND (D.NomeDepto = 'Pesquisa');



-- 3
SELECT ID_Proj, ID_Depto, NomeDepto, NomeFunc, Endereco, DataNasc
FROM Projeto as P Join Departamento as D ON P.ID_Depto=D.ID_Depto JOIN Funcionario as F on D.ID_Gerente = F.ID_Func
WHERE Localizacao='Luxemburgo'


-- 4
Select F.NomeFunc S.NomeFunc
From Funcionario as F join Funcionario as S on F.ID_Superv = S.ID_Func
 

-- 5
Select *
From Funcionario as F
WHERE ID_Depto = 1

-- 6
SELECT DISTINCT Salario
FROM Funcionario

-- 7
7