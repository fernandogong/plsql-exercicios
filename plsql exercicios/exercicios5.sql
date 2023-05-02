set serveroutput on
set verify off

-- EXERCICIO 1
DROP TABLE aluno CASCADE CONSTRAINTS;

CREATE TABLE aluno(
rm      NUMBER(1) PRIMARY KEY,
nome    VARCHAR2(20)
);

insert into aluno values (1,'Marcel');
insert into aluno values (2,'Adriana');
insert into aluno values (3,'Samuel');

BEGIN
    INSERT INTO aluno VALUES (&rm, '&nome');
    EXCEPTION
        WHEN dup_val_on_index then
        dbms_output.put_line('RM já cadastrado');
END;

DECLARE
    v_rm aluno.rm%TYPE := &rm;
    v_nome aluno.nome%TYPE;
BEGIN
    SELECT nome
    INTO v_nome FROM aluno
    WHERE rm = v_rm;
    dbms_output.put_line(v_rm || ' - ' || v_nome);
    
    EXCEPTION
        WHEN no_data_found then
            dbms_output.put_line('Não há aluno com este RM');
        WHEN too_many_rows then
            dbms_output.put_line('Há mais de um aluno com este RM');
        WHEN others then
            dbms_output.put_line('Erro desconhecido');
END;

-- EXERCICIO 2
select * from aluno;

DECLARE
	v_conta NUMBER(2);
	turma_cheia EXCEPTION;
BEGIN
	SELECT COUNT(rm) INTO v_conta FROM aluno;
	IF v_conta = 5 THEN 
		RAISE turma_cheia;
	ELSE 
		INSERT INTO aluno VALUES (4,'Rafaela');
	END IF;
	EXCEPTION
	WHEN turma_cheia THEN
		DBMS_OUTPUT.PUT_LINE('Não foi possível incluir: turma cheia');
END;

-- EXERCICIO 3
drop table produto cascade constraints;

create table produto(
codigo number(2) primary key,
nome varchar2(20)
);

declare 
    v_cod    produto.codigo%type;
    err_code number(4);
    err_msg  varchar2(100);
    v_data   date := sysdate;
begin
    insert into produto values (&codigo, '&nome');
    dbms_output.put_line('Processo concluido com sucesso');
   
EXCEPTION
   WHEN OTHERS THEN
      err_code := SQLCODE;
      err_msg := substr(SQLERRM, 1, 100);
      dbms_output.put_line('Processo nao concluido com sucesso');
      dbms_output.put_line('Problema apresentado');
      dbms_output.put_line(v_data||' - '||err_code||' - '||err_msg);
      insert into auditoria values (v_data, err_code, err_msg);
END;

create table auditoria (dt_erro date,
                        cd_erro varchar(20),
                        msg_erro varchar(110));
                        

select * from auditoria;
