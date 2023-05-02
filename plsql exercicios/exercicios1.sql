set serveroutput on
set verify off

-- EXERCICIO 1
DECLARE
    v_salario NUMBER := 650.8;
BEGIN
    v_salario := v_salario*1.25;
    dbms_output.put_line(v_salario);
END;

-- EXERCICIO 2
DECLARE
    v_dolar NUMBER := 45;
    v_cambio NUMBER := 2.98;
    v_real NUMBER;
BEGIN
    v_real := v_dolar*v_cambio;
    dbms_output.put_line(v_real);
END;

-- EXERCICIO 3
DECLARE
    v_salario NUMBER := &valor;
    v_sal_novo NUMBER;
BEGIN
    v_sal_novo := v_salario*1.25;
    dbms_output.put_line('salario antigo:' || v_salario);
    dbms_output.put_line('novo salario:' || v_sal_novo);
END;

-- EXERCICIO 4
DECLARE
    v_dolar NUMBER := &v1;
    v_real NUMBER;
    v_cambio NUMBER := 2.98;
BEGIN
    v_real := v_dolar*v_cambio;
    dbms_output.put_line(v_real);
END;
-- EXERCICIO 5
DECLARE
    v_compra NUMBER := &v1;
    v_juros NUMBER := 1.03;
BEGIN
    dbms_output.put_line('valor de cada parcela é: ' || v_compra*v_juros/10);
END;


-- EXERCÍCIO 6
DECLARE
    v_compra NUMBER := &v1;
    v_restante NUMBER := v_compra*0.8;
BEGIN
    dbms_output.put_line('Entrada: ' || v_compra*0.2);
    dbms_output.put_line('Pagamento em 6 parcelas: ' || TRUNC(v_restante*1.1/6, 2));
    dbms_output.put_line('Pagamento em 12 parcelas: ' || TRUNC(v_restante*1.15/12, 2));
    dbms_output.put_line('Pagamento em 18 parcelas: ' || ROUND(v_restante*1.2/18, 2));
END;