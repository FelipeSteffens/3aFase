CREATE DATABASE IF NOT EXISTS almoxerifado_db;

USE almoxerifado_db;


CREATE TABLE produtos (
id INT PRIMARY KEY AUTO_INCREMENT,
nome_produto VARCHAR(50) NOT NULL,
categoria VARCHAR(150) NOT NULL,
valor_unitario DECIMAL(10,2) NOT NULL,
estoque_min INT NOT NULL DEFAULT 0,
estoque_max INT NOT NULL DEFAULT 0,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movimentacoes(
id INT AUTO_INCREMENT PRIMARY KEY,
produto_id INT NOT NULL,
tipo ENUM('ENTRADA', 'SAIDA') NOT NULL,
quantidade INT NOT NULL,
data_movimentacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_movimentacoes_produtos
FOREIGN KEY (produto_id) REFERENCES produtos(id)
ON UPDATE CASCADE
ON DELETE RESTRICT
);

INSERT INTO produtos (nome_produto, categoria, valor_unitario, estoque_min, estoque_max) VALUES
('Pano de chão', 'Limpeza', 07.00, 5, 20),
('Vassoura', 'Limpeza', 21.00, 3, 10),
('Borracha', 'Escritório', 04.00, 7, 15);

INSERT INTO movimentacoes (produto_id, tipo, quantidade, data_movimentacao) VALUES
(1, 'ENTRADA', 20, '2026-02-12 19:30:00'),
(2, 'ENTRADA', 6, '2026-02-12 08:00:00'),
(1, 'SAIDA', 8, '2026-02-17 12:30:00'),
(2, 'SAIDA', 2, '2026-02-12 16:00:00'),
(3, 'ENTRADA', 12, '2026-02-11 08:00:00'),
(3, 'SAIDA', 3, '2026-02-13 08:30:00');


CREATE VIEW vw_estoque AS
SELECT p.id AS produto_id,
p.nome_produto,
p.categoria,
p.valor_unitario,
SUM(
CASE 
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    WHEN m.tipo = 'SAIDA' THEN -m.quantidade
    ELSE 0
END) AS Saldo_estoque,
SUM(
CASE
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    WHEN m.tipo = 'SAIDA' THEN -m.quantidade
    ELSE 0
END) * p.valor_unitario AS valor_total_produto
FROM produtos p
LEFT JOIN movimentacoes m ON m.produto_id = p.id
GROUP BY p.id,
p.nome_produto,
p.categoria,
p.valor_unitario;    

SELECT * FROM vw_estoque;

CREATE VIEW vw_saida AS
SELECT p.id AS produto_id, 
p.nome_produto AS produto, 
p.valor_unitario, 
m.quantidade_total_saida 
FROM produtos p 
LEFT JOIN 
(SELECT produto_id, SUM(quantidade) AS quantidade_total_saida 
FROM movimentacoes 
WHERE tipo = 'SAIDA' 
AND data_movimentacao 
BETWEEN '2026-01-1 01:00:00' AND '2027-02-10 10:00:00'
GROUP BY produto_id ) m ON m.produto_id = p.id 
ORDER BY m.quantidade_total_saida DESC;

SELECT * FROM produtos;

CREATE VIEW vw_relatorio AS
SELECT p.id AS produto_id, 
p.nome_produto AS produto, 
p.valor_unitario, 
m.entrada_total,
m.saida_total,
m.saldo_periodo,
m.valor_total_entrada * p.valor_unitario as valor_total_entrada,
m.valor_total_saida * p.valor_unitario as valor_total_saida
FROM produtos p 
LEFT JOIN 
( SELECT produto_id,
SUM(
CASE
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    ELSE 0
END) AS entrada_total,
SUM(
CASE
	WHEN m.tipo = 'SAIDA' THEN m.quantidade
    ELSE 0
END) AS saida_total,
SUM(
CASE 
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    WHEN m.tipo = 'SAIDA' THEN -m.quantidade
    ELSE 0
END) AS saldo_periodo,
SUM(
CASE
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    ELSE 0
END)  AS valor_total_entrada,
SUM(
CASE
    WHEN m.tipo = 'SAIDA' THEN m.quantidade
    ELSE 0
END) AS valor_total_saida
FROM movimentacoes m
WHERE tipo 
AND data_movimentacao 
BETWEEN '2026-01-1 01:00:00' AND '2027-02-10 10:00:00'
GROUP BY produto_id ) m ON m.produto_id = p.id;

CREATE VIEW vw_maior_saida AS
SELECT p.id AS produto_id, 
p.nome_produto AS produto, 
p.valor_unitario * quantidade_total_saida AS valor_total_saida, 
m.quantidade_total_saida 
FROM produtos p 
LEFT JOIN 
(SELECT produto_id, SUM(quantidade) AS quantidade_total_saida 
FROM movimentacoes 
WHERE tipo = 'SAIDA' 
AND data_movimentacao 
BETWEEN '2026-01-1 01:00:00' AND '2027-02-10 10:00:00'
GROUP BY produto_id ) m ON m.produto_id = p.id
ORDER BY m.quantidade_total_saida DESC;
		
SELECT * FROM vw_maior_saida;

CREATE VIEW vw_limite_estoque AS
SELECT p.id AS poduto_id,
p.nome_produto AS produto,
p.categoria,
SUM(
CASE 
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    WHEN m.tipo = 'SAIDA' THEN -m.quantidade
    ELSE 0
END) AS saldo_estoque,
CASE
	WHEN SUM(
CASE 
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    WHEN m.tipo = 'SAIDA' THEN -m.quantidade
    ELSE 'Estoque Normal'
END) <= p.estoque_min THEN 'Estoque Minimo Atingido'
    WHEN SUM(
CASE 
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    WHEN m.tipo = 'SAIDA' THEN -m.quantidade
    ELSE 0
END) >= p.estoque_max THEN 'Estoque Máximo Atingido'
    ELSE 'Estoque Normal'
END AS observacao
FROM produtos p
LEFT JOIN movimentacoes m ON m.produto_id = p.id
GROUP BY p.id,
p.nome_produto,
p.categoria;




