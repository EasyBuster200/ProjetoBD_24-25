--TODO: Change the error messages to PT
--? Perguntar como podemos garantir que ao inserir um tuplo na entidade Pai de um ISA ele automaticamente tem um filho, para os ISAs que são totais e disjuntos
--? Como garatir que na inserção relações que são obrigatorias são tambem inseridas
--? Vale a pena criar triggers que ao remover um diretor remove tambem todos os conteudos que este dirigiu
--? Podemos usar on delete cascade para foreign keys 

-- Trigger que antes de inserir um tuplo na tabela segue verifica que os ids são diferentes, ou seja não permite que alguem se siga a si próprio.  
CREATE OR REPLACE TRIGGER prevent_self_follow
BEFORE INSERT ON segue
FOR EACH ROW
BEGIN
  IF :NEW.idU = :NEW.idP THEN
    RAISE_APPLICATION_ERROR(-20100, 'Users cannot follow themselves.');
  END IF;
END;
/

--Trigger que garante que antes de inserir um tuplo na tabela de USuarios o seu id não está jã registrado
CREATE OR REPLACE TRIGGER trg_check_disjoint_Pessoas
BEFORE INSERT ON Usuarios
FOR EACH ROW
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Atores WHERE idA = :NEW.idU;
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'A person cannot be both Usuario and Ator.');
  END IF;

  SELECT COUNT(*) INTO v_count FROM Diretores WHERE idD = :NEW.idU;
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'A person cannot be both Usuario and Diretor.');
  END IF;
END;
/

--Trigger que garante que antes de inserir um tuplo na tabela de Atores o seu id não está jã registrado
CREATE OR REPLACE TRIGGER trg_check_disjoint_Atores
BEFORE INSERT ON Atores
FOR EACH ROW 
DECLARE 
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Usuarios WHERE idU = :new.idA;
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20100, 'A person cannot be both Ator and Usuario');
  END IF;

  SELECT count(*) into v_count from Diretores where idD = :new.idA;
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR (-20100, 'A person cannot be both Ator and Diretor');
  END IF;
END;
/

--Trigger que garante que antes de inserir um tuplo na tabela de Diretores o seu id não está jã registrado
CREATE OR REPLACE TRIGGER trg_check_disjoint_Diretores
BEFORE INSERT ON Diretores
FOR EACH ROW 
DECLARE 
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Usuarios WHERE idU = :new.idD;
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20100, 'A person cannot be both Diretor and Usuario');
  END IF;

  SELECT count(*) into v_count from Atores where idA = :new.idD;
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR (-20100, 'A person cannot be both Diretor and Ator');
  END IF;
END;
/

-- trigger que antes de inserir um Filme verifica que o Id não está registrado na tabela Series
CREATE OR REPLACE TRIGGER trg_check_disjoint_Filmes
BEFORE INSERT ON Filmes
FOR EACH ROW
DECLARE
  v_exists NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_exists
  FROM Series
  WHERE idCont = :NEW.idCont;

  IF v_exists > 0 THEN
    RAISE_APPLICATION_ERROR(-20100, 'This content ID is already registered as a Series.');
  END IF;
END;
/

-- trigger que antes de inserir uma Serie verifica que o Id não está registrado na tabela Filmes
CREATE OR REPLACE TRIGGER trg_check_disjoint_series
BEFORE INSERT ON Series
FOR EACH ROW
DECLARE
  v_exists NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_exists
  FROM Filmes
  WHERE idCont = :NEW.idCont;

  IF v_exists > 0 THEN
    RAISE_APPLICATION_ERROR(-20100, 'This content ID is already registered as a Film.');
  END IF;
END;
/

--Trigger que verifiaca que a classificação de um conteudo não pode ser menos que 0.0 ou mais de 10.0
CREATE OR REPLACE TRIGGER trg_check_classificacao
BEFORE INSERT OR UPDATE ON Conteudos
FOR EACH ROW
BEGIN
  IF :NEW.classificacao < 0.0 OR :NEW.classificacao > 10.0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Classificacao must be between 0.0 and 10.0.');
  END IF;
END;
/

CREATE or replace trigger id_Pessoa
before insert on Pessoas
For each row
DECLARE 
  id_Pessoa Number;
Begin 
  select seq_id_Pessoa.nextval
    into id_Pessoa
    from dual;
  :new.idP := id_Pessoa;
end;
/

Create or replace trigger id_cont
before insert on Conteudos
for each row
declare 
  id_cont Number;
Begin
  select seq_id_cont.nextval
  into id_cont
  FROM dual;
  :new.idCont := id_cont;
end;
/

CREATE or replace trigger id_Plat
before insert on Plataformas
for each row
begin
  select seq_id_Plat.nextval
  into :new.idPlat
  from dual;
end;
/

CREATE OR REPLACE TRIGGER trg_after_insert_conteudos
AFTER INSERT ON Conteudos
FOR EACH ROW
BEGIN
  IF :NEW.tipo = 'SERIE' THEN
    INSERT INTO Series (idCont) VALUES (:NEW.idCont);
  ELSIF :NEW.tipo = 'FILME' THEN
    INSERT INTO Filmes (idCont) VALUES (:NEW.idCont);
  END IF;
END;
/

--TODO: need more triggers like this I think