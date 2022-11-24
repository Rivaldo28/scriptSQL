--Criar um procedimento que atualize o nome do fornecedor
--e este procedimento recebe o dogio e nove nome
CREATE OR REPLACE FUNCTION public.atualizar_nome_fornecedor(codigo_p numeric, nome_p varchar)
RETURNS boolean
LANGUAGE plpgsql
AS $function$
DECLARE 
valida_nome integer;

BEGIN 
  
	SELECT count(*) INTO valida_nome FROM fornecedor f WHERE f.nome = nome_p;

    IF valida_nome = 1 THEN
      return false;
    END IF;
   
	UPDATE  public.fornecedor SET nome = nome_p WHERE codigo = codigo_p;
    return true;
 
END;

$function$
;



SELECT public.atualizar_nome_fornecedor(828,'Livro2');

select * from public.fornecedor f where codigo = 777;