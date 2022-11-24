--Criar um procedimento que crie o forncecedor, este recebe o codigo, nome, telefone e cidade
CREATE OR REPLACE FUNCTION public.criar_fornecedor(codigo_p numeric, nome_p varchar, telefone_p varchar, cidade_p varchar)
RETURNS text
LANGUAGE plpgsql
AS $function$
DECLARE 
valida_codigo integer;
valida_nome integer;
BEGIN 
  
  SELECT count(*) INTO valida_codigo FROM fornecedor f WHERE f.codigo = codigo_p;
  IF valida_codigo = 1 THEN
    return 'O codigo do fornecedor já existe, por tanto não se cria.';
  END IF;
  SELECT count(*) INTO valida_nome FROM fornecedor f WHERE f.nome = nome_p;
  IF valida_nome  = 1 then
    return 'O nome já existe, por tanto o fornecedor não se cria.';
  END IF;
  INSERT INTO fornecedor(codigo, nome, telefone, cidade) values(codigo_p, nome_p, telefone_p, cidade_p) ;
  return 'O fornecedor foi criado corretamente!';
 
END;
$function$
;


SELECT count(*) FROM fornecedor f WHERE f.codigo = 31234;
SELECT public.criar_fornecedor(31234,'Textil', '41875412', 'Carapicuíba');