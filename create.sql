CREATE TABLE usuarios(
	id_usuario SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	apelido1 VARCHAR(100) NOT NULL,
	apelido2 VARCHAR(100) NOT NULL,
	contrasenha VARCHAR(100) NOT NULL,
	email VARCHAR(200) NOT NULL,
	fechar_criacao TIMESTAMP NOT NULL
);
CREATE TABLE ocupacoes(
	id_ocupacao SERIAL PRIMARY KEY,
	tipo_ocupacao VARCHAR(100) NOT NULL,
	descricao VARCHAR(300) NOT NULL
);
CREATE TABLE usuarios_ocupacoes(
	id_usuario REFERENCES usuarios(id_usuario),
	id_ocupacao REFERENCES ocupacoes(id_ocupacao)
);
INSERT INTO usuarios(nome, apelido1, apelido2, contrasenha, email, fechar_criacao )
VALUES('Rivaldo', 'Lima', 'Souza', '123', 'rivaldo@email.com', CURRENT_TIMESTAMP);

SELECT * FROM usuarios;
UPDATE usuarios SET contrasenha = '456' WHERE nome = 'EMANUELLA';

INSERT INTO ocupacoes(tipo_ocupacao, descricao)
VALUES ('Programador', 'Realização de programas Informatizados');
SELECT * FROM ocupacao

