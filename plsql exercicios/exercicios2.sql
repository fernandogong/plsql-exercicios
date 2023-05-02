set serveroutput on
set verify off

-- EXERCICIO 1
DECLARE
    v_sexo CHAR(1) := UPPER('&sexo');
BEGIN
    IF v_sexo = 'M' then
        dbms_output.put_line('Masculino');
    ELSIF v_sexo = 'F' then
        dbms_output.put_line('Feminino');
    ELSE
        dbms_output.put_line('Outro');
    END IF;
    
END;

-- EXERCICIO 2
CREATE TABLE BOLETIM(
    rm          NUMBER(3)       NOT NULL,
    nome_comp   VARCHAR2(20)     NOT NULL,
    c_hora      NUMBER(3)       NOT NULL,
    nota1       NUMBER(4,2)     NOT NULL,
    nota2       NUMBER(4,2)     NOT NULL,
    nota3       NUMBER(4,2)     NOT NULL,
    media       NUMBER(4,2),
    faltas      NUMBER(3)       NOT NULL,
    situacao    VARCHAR2(40)
);
INSERT ALL
  INTO BOLETIM VALUES (135, 'DB Application', 200, 10, 10, 10, null, 0, null)
  INTO BOLETIM VALUES (135, 'IA', 180, 7.5, 7.5, 8.0, null, 170, null)
  INTO BOLETIM VALUES (135, 'ChatBot', 180, 1.0, 2.5, 1.5, null, 18, null)
  INTO BOLETIM VALUES (135, 'UX', 200, 2.5, 1.0, 1.5, null, 170, null)
  INTO BOLETIM VALUES (135, 'Mobile', 200, 4.0, 5.0, 4.5, null, 20, null)
SELECT * FROM dual;

-- SELECT * FROM BOLETIM;
-- DROP TABLE BOLETIM CASCADE CONSTRAINTS;

DECLARE
    v_rm            BOLETIM.rm%TYPE;
    v_nome_comp     BOLETIM.nome_comp%TYPE := UPPER('&componente');
    v_c_hora        BOLETIM.c_hora%TYPE;
    v_nota1         BOLETIM.nota1%TYPE;
    v_nota2         BOLETIM.nota2%TYPE;
    v_nota3         BOLETIM.nota3%TYPE;
    v_media         BOLETIM.media%TYPE;
    v_faltas        BOLETIM.faltas%TYPE;
    v_situacao      BOLETIM.situacao%TYPE;

BEGIN
    SELECT nome_comp, c_hora, nota1, nota2, nota3, faltas
    INTO v_nome_comp, v_c_hora, v_nota1, v_nota2, v_nota3, v_faltas
    FROM BOLETIM WHERE UPPER(nome_comp) = UPPER(v_nome_comp);
    
    v_media := (v_nota1+v_nota2+v_nota3)/3;
    
    IF v_media >= 6 and v_faltas < v_c_hora * 0.25 then
        dbms_output.put_line('Aluno APROVADO');
        UPDATE BOLETIM SET situacao = 'aprovado', media = v_media
        WHERE UPPER(nome_comp) = UPPER(v_nome_comp);
    ELSIF v_media <= 3 then
        dbms_output.put_line('Aluno REPROVADO por nota');
        UPDATE BOLETIM SET situacao = 'reprovado por nota', media = v_media
        WHERE UPPER(nome_comp) = UPPER(v_nome_comp);
    ELSIF v_media <= 3 and v_faltas >= v_c_hora * 0.25 then
        dbms_output.put_line('Aluno REPROVADO por nota e falta');
        UPDATE BOLETIM SET situacao = 'reprovado por nota e falta', media = v_media
        WHERE UPPER(nome_comp) = UPPER(v_nome_comp);
    ELSE
        dbms_output.put_line('Aluno em EXAME');
        UPDATE BOLETIM SET situacao = 'exame', media = v_media
        WHERE UPPER(nome_comp) = UPPER(v_nome_comp);
    END IF;
END;


SELECT * FROM BOLETIM;

-- EXERCICIO 3
DECLARE
    v_contador NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line(v_contador);
        v_contador := v_contador+1;
        EXIT WHEN v_contador = 20;
    END LOOP;
END;

-- EXERCICIO 4
DECLARE
    v_n1 NUMBER := &v1;
    v_n2 NUMBER := 1;
BEGIN
    LOOP
        dbms_output.put_line(v_n2 || ' x ' || v_n1 || ' = ' || v_n1*v_n2);
        v_n2 := v_n2+1;
        EXIT WHEN v_n2 > 10;
    END LOOP;
END;