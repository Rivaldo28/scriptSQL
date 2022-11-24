CREATE TABLE usuario(
	id_usuario SERIAL primary key,
	nome VARCHAR(100) NOT NULL,
	idade int NOT NULL,
	sexo CHAR(1) NOT NULL,
	   CHECK(sexo IN('M', 'F')),
	cpf VARCHAR(11) UNIQUE NOT NULL,
	email VARCHAR(200) UNIQUE NOT NULL,
	senha INTEGER NOT NULL,
	data_nasc DATE
); 
CREATE TABLE conta(
	id_conta integer PRIMARY KEY,
	banco VARCHAR(100) NOT NULL,
	agencia INTEGER,
	numero_conta INTEGER,
	valor_total INT NOT NULL DEFAULT 0,
	abertura_conta DATE,
	FOREIGN KEY (numero_conta) REFERENCES usuario(id_usuario)
);
ALTER TABLE conta ALTER COLUMN id_conta TYPE integer USING id_conta::integer;
CREATE TABLE deposito(
	id_deposito INTEGER,
	cod_deposito INTEGER,
	valor_deposito INTEGER,
	data_alteracao TIMESTAMP NOT NULL,
	FOREIGN KEY (cod_deposito) REFERENCES conta(id_conta) ON DELETE CASCADE
); 
CREATE TABLE saque(
	id_saque integer,
	cod_saque INTEGER,
	valor_saque INTEGER,
    data_alteracao TIMESTAMP NOT NULL,
	FOREIGN KEY (cod_saque) REFERENCES conta(id_conta) ON DELETE CASCADE
);

 --INSERINDO DADOS
 INSERT INTO usuario(nome, idade, sexo, cpf, email, senha, data_nasc)
VALUES('Rivaldo Lima', '34', 'M', '23454398790', 'correio@email.com', '12344', '2000/05/28');

INSERT INTO conta(id_conta, banco, agencia, numero_conta, valor_total, abertura_conta)
VALUES('1','Itaú', '1415', '1', '1500', '2020/04/24');
 
INSERT INTO deposito(id_deposito, cod_deposito, valor_deposito, data_alteracao) VALUES('1','1', '7600',CURRENT_TIMESTAMP);
INSERT INTO saque(id_saque, cod_saque, valor_saque, data_alteracao) VALUES('1', '1', '7700', CURRENT_TIMESTAMP);

SELECT * FROM usuario;
SELECT * FROM saque;SELECT * FROM 
SELECT * FROM usuario LEFT JOIN conta ON id_usuario = numero_conta;
--Delete  from conta;
 
 --criando TRIGGER e PROCEDURE
CREATE TRIGGER t_atualiza_deposito
BEFORE INSERT ON deposito 
FOR EACH ROW 
EXECUTE PROCEDURE atualiza_deposito();

CREATE OR REPLACE FUNCTION atualiza_deposito() RETURNS TRIGGER
AS
$$
DECLARE 
  total integer;
BEGIN

   SELECT valor_total FROM conta WHERE id_conta = NEW.cod_deposito INTO total;
   IF total > NEW.valor_deposito THEN
   RAISE EXCEPTION 'Valor depositado com sucesso!';
   ELSE
   UPDATE conta SET valor_total = valor_total + NEW.valor_deposito
   WHERE id_conta = NEW.cod_deposito;
   END IF;
   RETURN NEW;
   
END
$$  LANGUAGE plpgsql

CREATE TRIGGER t_atualiza_saque
BEFORE INSERT ON saque 
FOR EACH ROW
EXECUTE PROCEDURE atualiza_saque();

CREATE OR REPLACE FUNCTION atualiza_saque() RETURNS TRIGGER
AS
$$
DECLARE
   total integer;
BEGIN

   SELECT valor_total FROM conta WHERE id_conta = NEW.cod_saque INTO total;
   IF total < NEW.valor_saque THEN
   RAISE EXCEPTION 'Quantidade Indisponível em conta!';
   ELSE
   UPDATE conta SET valor_total = valor_total - NEW.valor_saque 
   WHERE id_conta = NEW.cod_saque;
   END IF;
   RETURN NEW; 
   
END
$$ LANGUAGE plpgsql