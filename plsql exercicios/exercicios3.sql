set serveroutput on
set verify off

-- EXERCICIO 1
drop table funcionario cascade constraints;

CREATE TABLE FUNCIONARIO(
cd_fun  NUMBER(2) PRIMARY KEY,
nm_fun  VARCHAR2(20),
salario NUMBER(10,2),
dt_adm  date
);

select sysdate from dual;

INSERT ALL
    into FUNCIONARIO values (1, 'Marcel', 10000, '17-ABR-2000')
    into FUNCIONARIO values (2, 'Claudia', 16000, '02-OUT-1998')
    into FUNCIONARIO values (3, 'Joaquim', 5500, '10-JUL-2010')
    into FUNCIONARIO values (4, 'Valéria', 7300, '08-JUN-2015')
select * from dual;

-- EXERCICIO 2
DECLARE
    CURSOR c_exibe IS
        SELECT nm_fun, salario FROM FUNCIONARIO;
    v_exibe c_exibe%rowtype;
BEGIN
    OPEN c_exibe;
    LOOP
        FETCH c_exibe into v_exibe;
    EXIT WHEN c_exibe%notfound;
    dbms_output.put_line('Nome:' || v_exibe.nm_fun || ' - Salario:' || v_exibe.salario);
    END LOOP;
    CLOSE c_exibe;
END;

-- EXERCICIO 3
ALTER TABLE FUNCIONARIO ADD TEMPO NUMBER(5);
SELECT * FROM FUNCIONARIO;

DECLARE
    CURSOR c_exibe IS
        SELECT * FROM FUNCIONARIO;
BEGIN
    FOR v_exibe IN c_exibe LOOP
        UPDATE FUNCIONARIO SET TEMPO = sysdate - v_exibe.dt_adm
        WHERE cd_fun = v_exibe.cd_fun;
    END LOOP;
END;

SELECT nm_fun, trunc((sysdate-dt_adm)/30),
trunc(MONTHS_BETWEEN(sysdate, dt_adm),0) from FUNCIONARIO;

-- EXERCICIO 4
DECLARE
    CURSOR c_exibe IS
        SELECT cd_fun, salario, tempo FROM FUNCIONARIO;
BEGIN
    FOR v_exibe in c_exibe LOOP
        IF (v_exibe.tempo/30) >= 150 then
            UPDATE FUNCIONARIO SET salario = salario *1.1
            WHERE cd_fun = v_exibe.cd_fun;
        ELSE
            UPDATE FUNCIONARIO SET salario = salario * 1.05
            WHERE cd_fun = v_exibe.cd_fun;
        END IF;
    END LOOP;
END;


