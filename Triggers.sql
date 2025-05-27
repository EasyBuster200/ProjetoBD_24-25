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
    RAISE_APPLICATION_ERROR(-20100, 'A person cannot be both Usuario and Ator.');
  END IF;

  SELECT COUNT(*) INTO v_count FROM Diretores WHERE idD = :NEW.idU;
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20100, 'A person cannot be both Usuario and Diretor.');
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
    RAISE_APPLICATION_ERROR(-20100, 'Classificacao must be between 0.0 and 10.0.');
  END IF;
END;
/

--Trigger que permite gerar um id de Pessoa ao inserir
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

--Trigger que premite gerar um id de Conteudos ao inserir
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

--Trigger que permite gerar um id de Plataforma ao inserir
CREATE or replace trigger id_Plat
before insert on Plataformas
for each row
begin
  select seq_id_Plat.nextval
  into :new.idPlat
  from dual;
end;
/

-- Trigger que automaticamente regista um Conteudo como Filme ou Serie dependendo do valor do atributo tipo de Contuedos
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

-- Trigger que automaticamente atualiza o valor de duração para a série em que foi adicionado um episodio
CREATE OR REPLACE TRIGGER trg_update_duracao_on_update
AFTER UPDATE ON Episodios
FOR EACH ROW
BEGIN
  UPDATE Conteudos
  SET duracao = (
    SELECT SUM(duracaoEp)
    FROM Episodios
    WHERE idCont = :NEW.idCont
  )
  WHERE idCont = :NEW.idCont;
END;