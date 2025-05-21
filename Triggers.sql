--TODO: Change the error messages to PT
--? Perguntar como podemos garantir que ao inserir um tuplo na entidade Pai de um ISA ele automaticamente tem um filho, para os ISAs que são totais e disjuntos
--? Como garatir que na inserção relações que são obrigatorias são tambem inseridas
--? Vale a pena criar triggers que ao remover um diretor remove tambem todos os conteudos que este dirigiu
--? Podemos usar on delete cascade para foreign keys 
--? Vale a pena garatir que Action e action não podem ambos estar registrados.

-- Simples trigger que antes de inserir um par de ids de Pessoas na tabela segue 
-- verifica que os ids são diferentes, ou seja não permite que alguem se siga a si próprio  
CREATE OR REPLACE TRIGGER prevent_self_follow
BEFORE INSERT ON segue
FOR EACH ROW
BEGIN
  IF :NEW.idU = :NEW.idP THEN
    RAISE_APPLICATION_ERROR(-20100, 'Users cannot follow themselves.');
  END IF;
END;
/

--Trigger que garante que um tuplo da entidade Pessoas pertence a apenas uma das entidades (filho) do ISA
--TODO: Same para atores e diretores
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
CREATE OR REPLACE TRIGGER trg_valida_classificacao
BEFORE INSERT OR UPDATE ON Conteudos
FOR EACH ROW
BEGIN
  IF :NEW.classificacao < 0.0 OR :NEW.classificacao > 10.0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Classificacao must be between 0.0 and 10.0.');
  END IF;
END;
/