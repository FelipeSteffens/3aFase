CREATE DATABASE IF NOT EXISTS biblioteca_db;

USE biblioteca_db;
DROP TABLE IF EXISTS livros;
DROP TABLE IF EXISTS movimentacoes;
CREATE TABLE livros (
	id INT primary key auto_increment,
    titulo Varchar(150) Not NULL,
    categoria varchar(80) not null,
    valor_unitario decimal(10,2) not null,
    estoque_minimo int not null default 0,
    estoque_maximo int not null default 0,
    created_at timestamp default current_timestamp
); 
CREATE TABLE movimentacoes(
	id INT primary key auto_increment,
	livro_id int not null,
    tipo ENUM('ENTRADA', 'SAIDA') NOT NULL,
    quantidade int not null, 
    data_movimentacao datetime not null default current_timestamp,
    created_at timestamp default current_timestamp,
    CONSTRAINT fk_movimentacoes_livros
		FOREIGN KEY (livro_id) REFERENCES livros(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


INSERT INTO livros (titulo, categoria, valor_unitario, estoque_minimo, estoque_maximo) 
VALUES('Dom Casmurro', 'Romance', 45.00, 2, 20),
('Capitaes da Areia', 'Literatura Brasileira', 39.90, 2, 15),
('Clean Code', 'Tecnologia', 120.00, 1, 10);
INSERT INTO movimentacoes (livro_id, tipo, quantidade, data_movimentacao) VALUES
(1, 'ENTRADA', 10, '2026-01-03 09:00:00'),
(1, 'SAIDA', 3, '2026-01-10 15:10:00'),
(1, 'SAIDA', 2, '2026-01-15 11:30:00'),
(2, 'ENTRADA', 8, '2026-01-04 10:00:00'),
(2, 'SAIDA', 4, '2026-01-17 16:00:00'),
(3, 'ENTRADA', 6, '2026-01-05 08:30:00'),
(3, 'SAIDA', 1, '2026-01-20 13:15:00');

create VIEW vw_livros as
SELECT l.id as livro_id,
l.titulo,
l.categoria,
l.valor_unitario,
SUM(
CASE 
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    WHEN m.tipo = 'SAIDA' THEN -m.quantidade
    ELSE 0
END) as saldo_estoque,
SUM(
CASE 
	WHEN m.tipo = 'ENTRADA' THEN m.quantidade
    WHEN m.tipo = 'SAIDA' THEN -m.quantidade
    ELSE 0
END) * l.valor_unitario as valor_total_item
from livros l
left join movimentacoes m on m.livro_id = l.id
group by l.id,
l.titulo,
l.categoria,
l.valor_unitario