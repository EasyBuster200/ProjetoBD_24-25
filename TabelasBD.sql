drop table Pessoas cascade constraints;
drop table Usuarios cascade constraints;
drop table Atores cascade constraints;
drop table Diretores cascade constraints;
drop table Listas cascade constraints;
drop table Conteudos cascade constraints;
drop table Series cascade constraints;
drop table Filmes cascade constraints;
drop table Temporadas cascade constraints;
drop table Episodios cascade constraints;
drop table Plataformas cascade constraints;
drop table Generos cascade constraints;
drop table segue cascade constraints;
drop table contem cascade constraints;
drop table participa cascade constraints;
drop table disponiboliza cascade constraints;
drop table de cascade constraints;

create table Pessoas (
  idP number (11,0),
  nome varchar2(30),
  primary key (idP)
);

create table Usuarios (
  idU number (11,0),
  dataNascimento DATE,
  emailUsr varchar2 (50),
  primary key (idU),
  foreign key (idU) references Pessoas(idP) on delete cascade
);

create table Atores(
  idA number (11,0),
  primary key (idA),
  foreign key (idA) references Pessoas(idP) on delete cascade
);

create table Diretores (
  idD number (11,0),
  primary key (idD),
  foreign key (idD) references Pessoas(idP) on delete cascade
);

create table Listas (
  nomeL varchar2 (30),
  idU number (11,0),
  primary key (nomeL, idU),
  foreign key (idU) references Usuarios(idU)
);

create table Conteudos(
  idCont number(11,0),
  tipo varchar2 (18), -- valores: "FILME" ou "SERIE"
  duracao number (3), -- Para Filmes é a duração do filme, para Series é a soma da duração de todos os episodios 
  nomeCont varchar2(50),
  classificacao number (2,1),
  linguagem varchar(30),
  idD number(11,0),
  primary key (idCont),
  foreign key (idD) references Diretores(idD)
);

create table Series (
  idCont number(11,0),
  primary key(idCont),
  foreign key (idCont) references Conteudos(idCont) on delete cascade
);

create table Filmes (
  idCont number(11,0),
  primary key (idCont),
  foreign key (idCont) references Conteudos(idCont) on delete cascade
);

create table Temporadas (
  numTemp number (2),
  idCont number (11,0),
  primary key (numTemp, idCont),
  foreign key (idCont) references Series(idCont) on delete cascade
);

create table Episodios (
  numEp number(3),
  idCont number(11,0),
  numTemp number(2),
  tituloEp varchar(30),
  duracaoEp number(2),
  primary key (idCont, numTemp, numEp),
  foreign key (idCont, numTemp) references Temporadas(idCont, numTemp) on delete cascade
);

create table Plataformas(
  idPlat number(5,0),
  nomePlat varchar2 (30),
  primary key (idPlat)
);

create table Generos (
  genero varchar(50),
  primary key (genero)
);

create table segue (
  idU number (11,0),
  idP number (11,0),
  primary key (idU, idP),
  foreign key (idU) references Usuarios(idU),
  foreign key (idP) references Pessoas(idP)
);

create table contem (
  idU number (11,0),
  nomeL varchar2 (30),
  idCont number (11,0),
  primary key (idU, nomeL, idCont),
  foreign key (idU, nomeL) references Listas(idU, NomeL) on delete cascade,
  foreign key (idCont) references Conteudos(idCont) on delete cascade
);

create table participa (
  idCont number(11,0), 
  idA number(11,0),
  primary key (idCont, idA),
  foreign key (idCont) references Conteudos(idCont) on delete cascade,
  foreign key (idA) references Atores(idA) on delete cascade
);

create table disponiboliza (
  idPlat number(5,0),
  idCont number (11,0),
  primary key (idPlat, idCont),
  foreign key (idPlat) references Plataformas(idPlat) on delete cascade,
  foreign key (idCont) references Conteudos(idCont) on delete cascade
);

create table de (
  idCont number(11,0),
  genero varchar2 (30),
  primary key (idCont, genero),
  foreign key (idCont) references Conteudos(idCont) on delete cascade,
  foreign key (genero) references Generos(genero)
);

--TODO: Maybe remove the view I made
--TODO: Check everything that is in the actual BD, views, tables, triggers, sequences and make sure to get all the code for each of them
--TODO: Para os dois reports interligados, podemos ao clicar em algo dos utilizadores ir para as suas listas, e dps ao clicar numa lista vamos para o conteudo dessa lista?