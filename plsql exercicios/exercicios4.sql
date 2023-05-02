set serveroutput on
set verify off

-- EXERCICIO 1
DROP TABLE t_prod1 CASCADE CONSTRAINTS;
DROP TABLE t_prod2 CASCADE CONSTRAINTS;

CREATE TABLE t_prod1(
cd_prod     NUMBER(1)       PRIMARY KEY,
nm_prod     VARCHAR2(2)     NOT NULL
);

CREATE TABLE t_prod3 AS SELECT * FROM t_prod1;

INSERT ALL
    INTO t_prod1 VALUES(1, 'A')
    INTO t_prod1 VALUES(2, 'B')
    INTO t_prod1 VALUES(3, 'C')
    INTO t_prod1 VALUES(4, 'E')
    INTO t_prod1 VALUES(5, 'F')
SELECT * FROM dual;

CREATE TABLE t_prod2 AS SELECT * FROM t_prod1;

INSERT ALL
    INTO t_prod2 VALUES(6, 'D')
    INTO t_prod2 VALUES(7, 'G')
    INTO t_prod2 VALUES(8, 'H')
    INTO t_prod2 VALUES(9, 'I')
SELECT * FROM dual;

DELETE t_prod2 WHERE nm_prod = 'E';

DECLARE
    CURSOR c_verifica IS
        SELECT * FROM t_prod1;
BEGIN
    FOR v_verifica in c_verifica LOOP
        insert into t_prod3 values(v_verifica.cd_prod, v_verifica.nm_prod);
    END LOOP;
    commit;
END;

-- EXERCICIO 2
SELECT * FROM produto_cp;

CREATE TABLE produto_cp(
codigo      NUMBER(4),
categoria   CHAR(1),
valor       NUMBER(4,2)
);

INSERT ALL
    INTO produto_cp values(1001, 'A', 7.55)
    INTO produto_cp values(1002, 'B', 5.95)
    INTO produto_cp values(1003, 'C', 3.45)
SELECT * FROM dual;

DECLARE
    CURSOR c_ajuste IS
        SELECT * FROM produto_cp;
BEGIN
    FOR v_ajuste in c_ajuste LOOP
        IF v_ajuste.categoria = 'A' then
            UPDATE produto_cp SET valor = v_ajuste.valor*1.05
            WHERE codigo = v_ajuste.codigo;
        ELSIF v_ajuste.categoria = 'B' then
            UPDATE produto_cp SET valor = v_ajuste.valor *1.1
            WHERE codigo = v_ajuste.codigo;
        ELSIF v_ajuste.categoria = 'C' then
            UPDATE produto_cp SET valor = v_ajuste.valor *1.15
            WHERE codigo = v_ajuste.codigo;
        END IF;
    END LOOP;
END;