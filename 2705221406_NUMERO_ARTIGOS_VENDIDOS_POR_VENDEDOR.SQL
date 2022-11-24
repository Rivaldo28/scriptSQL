--Criar um procedimento que retorne a quantidade de numero de artigos vendidos de um vendedor
--o procedimento deve receber o codigo do vendedor
CREATE OR REPLACE FUNCTION public.numero_artigos_vendidos_por_vendedor(codigo_vendedor_p numeric)
RETURNS integer
LANGUAGE plpgsql
AS $function$
DECLARE 
--numero_artigos integer;

BEGIN 
  
	return (SELECT sum(nro_artig_vendidos) FROM public.vendas v WHERE v.cod_vendedor = codigo_vendedor_p);
--   SELECT sum(nro_artig_vendidos) INTO numero_artigos FROM public.vendas v WHERE v.cod_vendedor = codigo_vendedor_p;
--   return numero_artigos;
 
END;

$function$
;



select public.numero_artigos_vendidos_por_vendedor(34  ) as total;
select *from public.vendas v where cod_vendedor = 11;