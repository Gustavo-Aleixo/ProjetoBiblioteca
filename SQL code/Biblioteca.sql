CREATE SCHEMA IF NOT EXISTS `Biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `Biblioteca` ;


CREATE TABLE IF NOT EXISTS `Biblioteca`.`autor` (
  `id_autor` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_autor`));


CREATE TABLE IF NOT EXISTS `Biblioteca`.`livro` (
  `id_livro` INT NOT NULL,
  `id_autor` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `num_pag` INT NOT NULL,
  `ano` SMALLINT(4) NOT NULL,
  PRIMARY KEY (`id_livro`),
  INDEX `id_autor_idx` (`id_autor` ASC) VISIBLE,
  CONSTRAINT `id_autor`
    FOREIGN KEY (`id_autor`)
    REFERENCES `Biblioteca`.`autor` (`id_autor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Biblioteca`.`exemplar` (
  `id_exemplar` INT NOT NULL,
  `id_livro` INT NOT NULL,
  PRIMARY KEY (`id_exemplar`),
  INDEX `id_livro_idx` (`id_livro` ASC) VISIBLE,
  CONSTRAINT `id_livro`
    FOREIGN KEY (`id_livro`)
    REFERENCES `Biblioteca`.`livro` (`id_livro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Biblioteca`.`usuario` (
  `id_usuario` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` INT NOT NULL,
  `telefone` INT NOT NULL,
  PRIMARY KEY (`id_usuario`));


CREATE TABLE IF NOT EXISTS `Biblioteca`.`emprestimo` (
  `id_emprestimo` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_exemplar` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id_emprestimo`),
  INDEX `id_usuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `id_exemplar_idx` (`id_exemplar` ASC) VISIBLE,
  CONSTRAINT `id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Biblioteca`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_exemplar`
    FOREIGN KEY (`id_exemplar`)
    REFERENCES `Biblioteca`.`exemplar` (`id_exemplar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
  
  
INSERT INTO autor(id_autor, nome, pais)
VALUES  
	(101, 'Monteiro Lobato', 'Brasil'),
	(102, 'William Shakespeare', 'Reino Unido'),
	(103, 'Machado de Assis', 'Brasil'),
	(104, 'Stephen King', 'EUA'),
	(105, 'Fernando Pessoa', 'Portugual');


INSERT INTO livro(id_livro, id_autor, titulo, num_pag, ano)
VALUES  
	(1001, 101, 'O Sítio do Picapau Amarelo', 88, 2002),
    (1002, 102, 'Romeu e Julieta', 280, 1591),
    (1003, 102, 'Hamlet', 415, 1601),
    (1004, 103, 'Memórias Póstumas de Brás Cubas', 562, 1881),
    (1005, 104, 'It - A Coisa', 319, 1986),
    (1006, 104, 'À Espera de um Milagre', 537, 1996),
    (1007, 105, 'Poesia de Fernando Pessoa', 147, 1945);
    

INSERT INTO exemplar(id_exemplar, id_livro)
VALUES  
	(1, 1001),
	(2, 1002),
	(3, 1002),
	(4, 1003),
	(5, 1004),
    (6, 1005),
	(7, 1005),
	(8, 1006),
    (9, 1007);
    
    
INSERT INTO usuario(id_usuario, nome, cpf, telefone)
VALUES  
	(201, 'Jose da Silva', 10000001, 10000099),
	(202, 'Maria Oliveira', 20000002, 20000099),
	(203, 'Gabriel Campos', 30000003, 30000099),
	(204, 'Sergio Mattos Filho', 40000004, 40000099),
	(205, 'Julia Assis Morereira', 50000006, 50000099);
    
    
INSERT INTO emprestimo(id_emprestimo, id_usuario, id_exemplar, data)
VALUES  
	(3001, 201, 2, '2022-05-25'),
	(3002, 202, 3, '2022-05-28'),
	(3003, 203, 5, '2022-06-01'),
	(3004, 203, 7, '2022-06-05'),
	(3005, 205, 8, '2022-06-05');


CREATE INDEX idx_nome ON autor(nome);
CREATE INDEX idx_ano ON livro(ano);
CREATE INDEX idx_telefone ON usuario(telefone);
CREATE INDEX idx_data ON emprestimo(data);


CREATE ROLE visitante;
GRANT ALL ON biblioteca.* TO 'visitante';


CREATE USER 'um_usuario'@'localhost' IDENTIFIED BY 'um_usuario';
GRANT 'visitante' TO 'um_usuario'@'localhost';


CREATE VIEW brasileiros AS 
SELECT nome
FROM autor
WHERE pais = 'Brasil';


-- PARA VER O RESULTADO DA VIEW
SELECT * FROM brasileiros;
