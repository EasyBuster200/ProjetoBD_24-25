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

DELETE FROM contem;
DELETE FROM segue;
DELETE FROM de;
DELETE FROM participa;
DELETE FROM disponiboliza;
DELETE FROM Episodios;
DELETE FROM Temporadas;
DELETE FROM Filmes;
DELETE FROM Series;
DELETE FROM Listas;
DELETE FROM Conteudos;
DELETE FROM Plataformas;
DELETE FROM Generos;
DELETE FROM Usuarios;
DELETE FROM Atores;
DELETE FROM Diretores;
DELETE FROM Pessoas;

insert all
  --Usuarios
  into Pessoas values (10000000001, 'Seth Piddick')
  into Pessoas values (10000000002, 'Nana Moorey')
  into Pessoas values (10000000003, 'Sibby Inett')
  into Pessoas values (10000000004, 'Biron Pretswell')
  into Pessoas values (10000000005, 'Rhodia Ponceford')
  into Pessoas values (10000000006, 'Margaretta Bedward')
  into Pessoas values (10000000007, 'Polly Pedican')
  into Pessoas values (10000000008, 'Maiga Bothwell')
  into Pessoas values (10000000009, 'Kellen Dickenson')
  into Pessoas values (10000000010, 'Karlens Legon')
  into Pessoas values (10000000011, 'Christal Burnet')
  into Pessoas values (10000000012, 'Clarance Touret')
  into Pessoas values (10000000013, 'Alyce Corbridge')
  into Pessoas values (10000000014, 'Stefa Gratrix')
  into Pessoas values (10000000015, 'Fulvia Grishankov')
  into Pessoas values (10000000016, 'Elle Headey')
  into Pessoas values (10000000017, 'Jeanine Grove')
  into Pessoas values (10000000018, 'Tierney Capelle')
  into Pessoas values (10000000019, 'Desmond Spellessy')
  into Pessoas values (10000000020, 'Trixie Keepence')
  into Pessoas values (10000000021, 'Magdalena Rotchell')
  into Pessoas values (10000000022, 'Kiri Millom')
  into Pessoas values (10000000023, 'Terrell Whal')
  into Pessoas values (10000000024, 'Annalee Baughan')
  into Pessoas values (10000000025, 'Tabb Harriagn')
  --Atores
  into Pessoas values (10000000026, 'Leonardo DiCaprio')
  into Pessoas values (10000000027, 'Scarlett Johansson')
  into Pessoas values (10000000028, 'Tom Hanks')
  into Pessoas values (10000000029, 'Natalie Portman')
  into Pessoas values (10000000030, 'Brad Pitt')
  into Pessoas values (10000000031, 'Emma Stone')
  into Pessoas values (10000000032, 'Denzel Washington')
  into Pessoas values (10000000033, 'Jennifer Lawrence')
  into Pessoas values (10000000034, 'Morgan Freeman')
  into Pessoas values (10000000035, 'Anne Hathaway')
  into Pessoas values (10000000036, 'Joaquin Phoenix')
  into Pessoas values (10000000037, 'Meryl Streep')
  into Pessoas values (10000000038, 'Christian Bale')
  into Pessoas values (10000000039, 'Zendaya')
  --Diretores
  into Pessoas values (10000000040, 'Christopher Nolan')
  into Pessoas values (10000000041, 'Steven Spielberg')
  into Pessoas values (10000000042, 'Quentin Tarantino')
  into Pessoas values (10000000043, 'Sofia Coppola')
  into Pessoas values (10000000044, 'Greta Gerwig')
  into Pessoas values (10000000045, 'Martin Scorsese')
  into Pessoas values (10000000046, 'Patty Jenkins')
  into Pessoas values (10000000047, 'Denis Villeneuve')
  into Pessoas values (10000000048, 'Guillermo del Toro')
  into Pessoas values (10000000049, 'Chloé Zhao')
  into Pessoas values (10000000050, 'James Cameron')
SELECT * FROM dual;

insert all
  into Usuarios values (10000000001, to_date('2002-07-19', 'YYYY.MM.DD'), 'esidgwick0@parallels.com')
  into Usuarios values (10000000002, to_date('2005-04-03', 'YYYY.MM.DD'), 'atrenholme1@java.com')
  into Usuarios values (10000000003, to_date('2007-07-13', 'YYYY.MM.DD'), 'ksterling2@google.ca')
  into Usuarios values (10000000004, to_date('2000-06-09', 'YYYY.MM.DD'), 'jteece3@ucoz.com')
  into Usuarios values (10000000005, to_date('2001-09-16', 'YYYY.MM.DD'), 'nbagg4@lycos.com')
  into Usuarios values (10000000006, to_date('2003-12-02', 'YYYY.MM.DD'), 'ascullion5@webeden.co.uk')
  into Usuarios values (10000000007, to_date('2011-12-04', 'YYYY.MM.DD'), 'lcorkish6@github.io')
  into Usuarios values (10000000008, to_date('2006-09-03', 'YYYY.MM.DD'), 'pkarlicek7@tuttocitta.it')
  into Usuarios values (10000000009, to_date('1997-05-18', 'YYYY.MM.DD'), 'vlashmore8@blogspot.com')
  into Usuarios values (10000000010, to_date('2013-11-23', 'YYYY.MM.DD'), 'ntillard9@nyu.edu')
  into Usuarios values (10000000011, to_date('2014-09-29', 'YYYY.MM.DD'), 'sdambrogioa@google.es')
  into Usuarios values (10000000012, to_date('1998-07-19', 'YYYY.MM.DD'), 'ucollinsonb@vinaora.com')
  into Usuarios values (10000000013, to_date('1999-10-31', 'YYYY.MM.DD'), 'rcolatonc@delicious.com')
  into Usuarios values (10000000014, to_date('2001-04-15', 'YYYY.MM.DD'), 'pgudahyd@cbslocal.com')
  into Usuarios values (10000000015, to_date('1998-02-19', 'YYYY.MM.DD'), 'mgadsone@gmpg.org')
  into Usuarios values (10000000016, to_date('2011-03-20', 'YYYY.MM.DD'), 'lpetrellif@washingtonpost.com')
  into Usuarios values (10000000017, to_date('2013-10-08', 'YYYY.MM.DD'), 'hdallyng@github.io')
  into Usuarios values (10000000018, to_date('2011-01-29', 'YYYY.MM.DD'), 'gcowdreyh@si.edu')
  into Usuarios values (10000000019, to_date('2005-04-18', 'YYYY.MM.DD'), 'kbrighami@wunderground.com')
  into Usuarios values (10000000020, to_date('2005-09-22', 'YYYY.MM.DD'), 'mmcniffj@freewebs.com')
  into Usuarios values (10000000021, to_date('2010-01-10', 'YYYY.MM.DD'), 'etrazzik@amazon.com')
  into Usuarios values (10000000022, to_date('1998-08-15', 'YYYY.MM.DD'), 'hgaukrogerl@yale.edu')
  into Usuarios values (10000000023, to_date('2003-11-06', 'YYYY.MM.DD'), 'boleahym@webs.com')
  into Usuarios values (10000000024, to_date('2001-07-06', 'YYYY.MM.DD'), 'ghaldenen@ucsd.edu')
  into Usuarios values (10000000025, to_date('2015-02-12', 'YYYY.MM.DD'), 'fmcclarenceo@t.co')
select * from dual;

insert all
  into Atores values (10000000026)
  into Atores values (10000000027)
  into Atores values (10000000028)
  into Atores values (10000000029)
  into Atores values (10000000030)
  into Atores values (10000000031)
  into Atores values (10000000032)
  into Atores values (10000000033)
  into Atores values (10000000034)
  into Atores values (10000000035)
  into Atores values (10000000036)
  into Atores values (10000000037)
  into Atores values (10000000038)
  into Atores values (10000000039)
select * from dual;

insert all
  into Diretores values (10000000040)
  into Diretores values (10000000041)
  into Diretores values (10000000042)
  into Diretores values (10000000043)
  into Diretores values (10000000044)
  into Diretores values (10000000045)
  into Diretores values (10000000046)
  into Diretores values (10000000047)
  into Diretores values (10000000048)
  into Diretores values (10000000049)
  into Diretores values (10000000050)
select * from dual;

insert all
  into Listas values ('Critically Acclaimed', 10000000001)
  into Listas values ('Stream Dreams', 10000000002)
  into Listas values ('Weekend Binges', 10000000003)
  into Listas values ('Award Winners', 10000000004)
  into Listas values ('To Watch', 10000000005)
  into Listas values ('Watchlist', 10000000006)
  into Listas values ('Weekend Binges', 10000000007)
  into Listas values ('TV Time', 10000000008)
  into Listas values ('Binge Bucket', 10000000009)
  into Listas values ('Stream Dreams', 10000000010)
  into Listas values ('Thriller Zone', 10000000011)
  into Listas values ('Feel-Good Flicks', 10000000012)
  into Listas values ('Weekend Binges', 10000000013)
  into Listas values ('Watch Again', 10000000014)
  into Listas values ('Watchlist', 10000000015)
  into Listas values ('TV Time', 10000000016)
  into Listas values ('My Cinefile', 10000000017)
  into Listas values ('Weekend Binges', 10000000018)
  into Listas values ('Family Night List', 10000000019)
  into Listas values ('Feel-Good Flicks', 10000000020)
  into Listas values ('The Vault', 10000000021)
  into Listas values ('Short Series Picks', 10000000022)
  into Listas values ('Reel Deals', 10000000023)
  into Listas values ('My Cinefile', 10000000024)
  into Listas values ('Movie Mood Board', 10000000025)
select * from dual;


insert all
  --Filmes
  into Conteudos values (10000000001, 'FILME', 176,'A Cinderella Story: Once Upon a Song', 8.2, 'English', 10000000040)
  into Conteudos values (10000000002, 'FILME', 180,'Why Dont You Play In Hell?', 9.7, 'Japanese', 10000000041)
  into Conteudos values (10000000003, 'FILME', 136,'Thampu', 3.0, 'Malayalam', 10000000042)
  into Conteudos values (10000000004, 'FILME', 185,'Exists', 8.6, 'English', 10000000043)
  into Conteudos values (10000000005, 'FILME', 144,'Adventures of Elmo in Grouchland, The', 6.5, 'English', 10000000044)
  into Conteudos values (10000000006, 'FILME', 194,'Ranma : Big Trouble in Nekonron, China', 3.5, 'Japanese', 10000000045)
  into Conteudos values (10000000007, 'FILME', 139,'King Kelly', 5.7, 'English', 10000000046)
  into Conteudos values (10000000008, 'FILME', 137,'Go Get Some Rosemary (Daddy Longlegs)', 3.8, 'English', 10000000047)
  into Conteudos values (10000000009, 'FILME', 109,'Look Whos Talking Now', 8.7, 'English', 10000000048)
  into Conteudos values (10000000010, 'FILME', 193,'Dawn Patrol', 9.4, 'English', 10000000049)
  into Conteudos values (10000000011, 'FILME', 174,'Kill Theory', 1.6, 'English', 10000000050)
  into Conteudos values (10000000012, 'FILME', 171,'Kickboxer 3: The Art of War', 5.5, 'English', 10000000040)
  into Conteudos values (10000000013, 'FILME', 152,'Black Sheep', 5.7, 'English', 10000000041)
  into Conteudos values (10000000014, 'FILME', 142,'Nine Dead', 7.7, 'English', 10000000042)
  into Conteudos values (10000000015, 'FILME', 132,'Aquamarine', 2.3, 'English', 10000000043)
  --Series
  into Conteudos values (10000000016, 'SERIE', 657,'Breaking Bad', 9.5, 'English', 10000000040)
  into Conteudos values (10000000017, 'SERIE', 695,'Money Heist', 8.2, 'Spanish', 10000000041)
  into Conteudos values (10000000018, 'SERIE', 269,'Dark', 8.8, 'German', 10000000042)
  into Conteudos values (10000000019, 'SERIE', 252,'Squid Game', 8.0, 'Korean', 10000000043)
select * from dual; 

INSERT all
  into Series (idCont) values (10000000016)
  into Series (idCont) values (10000000017)
  into Series (idCont) values (10000000018)
  into Series (idCont) values (10000000019)
SELECT * FROM dual;

INSERT ALL
  INTO Filmes VALUES (10000000001)
  INTO Filmes VALUES (10000000002) 
  INTO Filmes VALUES (10000000003)
  INTO Filmes VALUES (10000000004)
  INTO Filmes VALUES (10000000005)
  INTO Filmes VALUES (10000000006)
  INTO Filmes VALUES (10000000007)
  INTO Filmes VALUES (10000000008)
  INTO Filmes VALUES (10000000009)
  INTO Filmes VALUES (10000000010)
  INTO Filmes VALUES (10000000011)
  INTO Filmes VALUES (10000000012)
  INTO Filmes VALUES (10000000013)
  INTO Filmes VALUES (10000000014)
  INTO Filmes VALUES (10000000015)
SELECT * FROM dual;

insert all
  into Generos (genero) values ('Action')
  into Generos (genero) values ('Adventure')
  into Generos (genero) values ('Comedy')
  into Generos (genero) values ('Drama')
  into Generos (genero) values ('Fantasy')
  into Generos (genero) values ('Horror')
  into Generos (genero) values ('Mystery')
  into Generos (genero) values ('Romance')
  into Generos (genero) values ('Science Fiction')
  into Generos (genero) values ('Thriller')
select * from dual;

insert all
  -- Breaking Bad (5 seasons)
  into Temporadas values (1, 10000000016)
  into Temporadas values (2, 10000000016)
  into Temporadas values (3, 10000000016)
  into Temporadas values (4, 10000000016)
  into Temporadas values (5, 10000000016)
  -- Money Heist (5 seasons)
  into Temporadas values (1, 10000000017)
  into Temporadas values (2, 10000000017)
  into Temporadas values (3, 10000000017)
  into Temporadas values (4, 10000000017)
  into Temporadas values (5, 10000000017)
  -- Dark (3 seasons)
  into Temporadas values (1, 10000000018)
  into Temporadas values (2, 10000000018)
  into Temporadas values (3, 10000000018)
  -- Squid Game (2 seasons, 2nd season confirmed and upcoming)
  into Temporadas values (1, 10000000019)
  into Temporadas values (2, 10000000019)
select * from dual;

insert all 
  into segue values (10000000020, 10000000016)
  into segue values (10000000023, 10000000032)
  into segue values (10000000016, 10000000004)
  into segue values (10000000022, 10000000048)
  into segue values (10000000003, 10000000010)
  into segue values (10000000025, 10000000039)
  into segue values (10000000023, 10000000017)
  into segue values (10000000005, 10000000032)
  into segue values (10000000023, 10000000003)
  into segue values (10000000011, 10000000050)
  into segue values (10000000024, 10000000015)
  into segue values (10000000020, 10000000041)
  into segue values (10000000002, 10000000010)
  into segue values (10000000013, 10000000002)
  into segue values (10000000001, 10000000045)
  into segue values (10000000025, 10000000038)
  into segue values (10000000003, 10000000020)
  into segue values (10000000016, 10000000041)
  into segue values (10000000015, 10000000009)
  into segue values (10000000009, 10000000015)
  into segue values (10000000010, 10000000005)
  into segue values (10000000020, 10000000042)
  into segue values (10000000016, 10000000026)
  into segue values (10000000003, 10000000036)
  into segue values (10000000022, 10000000044)
select * from dual;

INSERT ALL  
  into contem values (10000000003, 'Weekend Binges', 10000000006)
  into contem values (10000000005, 'To Watch', 10000000006)
  into contem values (10000000008, 'TV Time', 10000000014)
  into contem values (10000000010, 'Stream Dreams', 10000000007)
  into contem values (10000000011, 'Thriller Zone', 10000000018)
  into contem values (10000000014, 'Watch Again', 10000000018)
  into contem values (10000000015, 'Watchlist', 10000000012)
  into contem values (10000000016, 'TV Time', 10000000009)
  into contem values (10000000021, 'The Vault', 10000000009)
  into contem values (10000000022, 'Short Series Picks', 10000000019)
  into contem values (10000000023, 'Reel Deals', 10000000018)
  into contem values (10000000003, 'Weekend Binges', 10000000019)
  into contem values (10000000011, 'Thriller Zone', 10000000019)
SELECT * FROM dual;

insert all 
  into Plataformas values (10001, 'Netflix')
  into Plataformas values (10002, 'Amazon Prime Video')
  into Plataformas values (10003, 'Disney+')
  into Plataformas values (10004, 'HBO Max')
  into Plataformas values (10005, 'Hulu')
  into Plataformas values (10006, 'Apple TV+')
select * from dual;

INSERT ALL
  into participa values (10000000018, 10000000026)
  into participa values (10000000002, 10000000027)
  into participa values (10000000013, 10000000028)
  into participa values (10000000012, 10000000029)
  into participa values (10000000014, 10000000030)
  into participa values (10000000014, 10000000031)
  into participa values (10000000013, 10000000032)
  into participa values (10000000011, 10000000033)
  into participa values (10000000018, 10000000034)
  into participa values (10000000013, 10000000035)
  into participa values (10000000016, 10000000036)
  into participa values (10000000011, 10000000037)
  into participa values (10000000010, 10000000038) 
  into participa values (10000000017, 10000000039)
  into participa values (10000000001, 10000000038)
  into participa values (10000000002, 10000000039)
  into participa values (10000000003, 10000000037)
  into participa values (10000000004, 10000000029)
  into participa values (10000000005, 10000000027)
  into participa values (10000000006, 10000000031)
  into participa values (10000000007, 10000000039)
  into participa values (10000000008, 10000000039)
  into participa values (10000000009, 10000000028)
  into participa values (10000000010, 10000000036)
  into participa values (10000000011, 10000000032)
  into participa values (10000000012, 10000000036)
  into participa values (10000000013, 10000000031)
  into participa values (10000000014, 10000000039)
  into participa values (10000000015, 10000000039)
  into participa values (10000000016, 10000000038)
  into participa values (10000000017, 10000000035)
  into participa values (10000000018, 10000000033)
  into participa values (10000000019, 10000000029)
  into participa values (10000000010, 10000000031)
  into participa values (10000000011, 10000000039)
  into participa values (10000000012, 10000000038)
  into participa values (10000000013, 10000000029)
  into participa values (10000000015, 10000000034)
  into participa values (10000000016, 10000000031)
  into participa values (10000000017, 10000000037)
  into participa values (10000000018, 10000000037)
  into participa values (10000000019, 10000000035)
  into participa values (10000000014, 10000000036)
  into participa values (10000000015, 10000000026)
  into participa values (10000000017, 10000000028)
  into participa values (10000000018, 10000000027)
  into participa values (10000000019, 10000000032)
  into participa values (10000000010, 10000000027)
  into participa values (10000000012, 10000000026)
  into participa values (10000000014, 10000000034)
  into participa values (10000000017, 10000000030)
  into participa values (10000000019, 10000000030)
  into participa values (10000000010, 10000000033)
  into participa values (10000000015, 10000000037)
  into participa values (10000000017, 10000000034)
  into participa values (10000000017, 10000000036)
  into participa values (10000000013, 10000000038)
SELECT * FROM dual;

INSERT ALL
  INTO disponiboliza VALUES (10001, 10000000010)
  INTO disponiboliza VALUES (10002, 10000000007)
  INTO disponiboliza VALUES (10003, 10000000018) 
  INTO disponiboliza VALUES (10004, 10000000015)
  INTO disponiboliza VALUES (10005, 10000000012)
  INTO disponiboliza VALUES (10006, 10000000016)
  INTO disponiboliza VALUES (10003, 10000000001)
  INTO disponiboliza VALUES (10004, 10000000002)
  INTO disponiboliza VALUES (10001, 10000000003)
  INTO disponiboliza VALUES (10004, 10000000004)
  INTO disponiboliza VALUES (10006, 10000000005)
  INTO disponiboliza VALUES (10005, 10000000006)
  INTO disponiboliza VALUES (10006, 10000000007)
  INTO disponiboliza VALUES (10001, 10000000008)
  INTO disponiboliza VALUES (10005, 10000000009)
  INTO disponiboliza VALUES (10002, 10000000010)
  INTO disponiboliza VALUES (10004, 10000000011)
  INTO disponiboliza VALUES (10003, 10000000012)
  INTO disponiboliza VALUES (10004, 10000000013)
  INTO disponiboliza VALUES (10001, 10000000014)
  INTO disponiboliza VALUES (10001, 10000000017)
  INTO disponiboliza VALUES (10001, 10000000018)
  INTO disponiboliza VALUES (10006, 10000000019)
  INTO disponiboliza VALUES (10005, 10000000010)
  INTO disponiboliza VALUES (10005, 10000000011)
  INTO disponiboliza VALUES (10002, 10000000012)
  INTO disponiboliza VALUES (10005, 10000000013)
  INTO disponiboliza VALUES (10005, 10000000014)
  INTO disponiboliza VALUES (10002, 10000000015)
  INTO disponiboliza VALUES (10002, 10000000016)
  INTO disponiboliza VALUES (10002, 10000000018)
  INTO disponiboliza VALUES (10006, 10000000011)
  INTO disponiboliza VALUES (10001, 10000000012)
  INTO disponiboliza VALUES (10002, 10000000013)
  INTO disponiboliza VALUES (10004, 10000000017)
  INTO disponiboliza VALUES (10004, 10000000018)
  INTO disponiboliza VALUES (10002, 10000000019)
  INTO disponiboliza VALUES (10006, 10000000010)
  INTO disponiboliza VALUES (10003, 10000000013)
  INTO disponiboliza VALUES (10001, 10000000015)
  INTO disponiboliza VALUES (10002, 10000000017)
  INTO disponiboliza VALUES (10006, 10000000013)
  INTO disponiboliza VALUES (10003, 10000000016)
  INTO disponiboliza VALUES (10006, 10000000003)
  INTO disponiboliza VALUES (10003, 10000000004)
  INTO disponiboliza VALUES (10004, 10000000007)
  INTO disponiboliza VALUES (10002, 10000000008)
  INTO disponiboliza VALUES (10001, 10000000009)
  INTO disponiboliza VALUES (10003, 10000000014)
  INTO disponiboliza VALUES (10005, 10000000019)
  INTO disponiboliza VALUES (10003, 10000000010)
  INTO disponiboliza VALUES (10001, 10000000011)
  INTO disponiboliza VALUES (10005, 10000000015)
  INTO disponiboliza VALUES (10004, 10000000012)
  INTO disponiboliza VALUES (10006, 10000000014)
  INTO disponiboliza VALUES (10003, 10000000019)
  INTO disponiboliza VALUES (10006, 10000000012)
  INTO disponiboliza VALUES (10005, 10000000016)
SELECT * FROM dual;

insert all
  into de values (10000000001, 'Thriller')
  into de values (10000000002, 'Adventure')
  into de values (10000000003, 'Horror')
  into de values (10000000004, 'Romance')
  into de values (10000000004, 'Mystery')
  into de values (10000000005, 'Thriller')
  into de values (10000000006, 'Fantasy')
  into de values (10000000007, 'Drama')
  into de values (10000000008, 'Adventure')
  into de values (10000000008, 'Mystery')
  into de values (10000000008, 'Comedy')
  into de values (10000000009, 'Thriller')
  into de values (10000000009, 'Science Fiction')
  into de values (10000000010, 'Fantasy')
  into de values (10000000011, 'Thriller')
  into de values (10000000012, 'Drama')
  into de values (10000000012, 'Thriller')
  into de values (10000000013, 'Comedy')
  into de values (10000000014, 'Adventure')
  into de values (10000000015, 'Comedy')
  into de values (10000000016, 'Comedy')
  into de values (10000000016, 'Drama')
  into de values (10000000017, 'Science Fiction')
  into de values (10000000018, 'Romance')
  into de values (10000000018, 'Science Fiction')
  into de values (10000000019, 'Comedy')
select * from dual;

INSERT ALL
  --Breaking Bad Season 1
  INTO Episodios VALUES (1, 10000000016, 1, 'Ep1_S1', 58)
  INTO Episodios VALUES (2, 10000000016, 1, 'Ep2_S1', 57)
  INTO Episodios VALUES (3, 10000000016, 1, 'Ep3_S1', 57)
  -- Season 2
  INTO Episodios VALUES (1, 10000000016, 2, 'Ep1_S2', 48)
  INTO Episodios VALUES (2, 10000000016, 2, 'Ep2_S2', 60)
  -- Season 3
  INTO Episodios VALUES (1, 10000000016, 3, 'Ep1_S3', 48)
  INTO Episodios VALUES (2, 10000000016, 3, 'Ep2_S3', 42)
  INTO Episodios VALUES (3, 10000000016, 3, 'Ep3_S3', 40)
  -- Season 4
  INTO Episodios VALUES (1, 10000000016, 4, 'Ep1_S4', 42)
  INTO Episodios VALUES (2, 10000000016, 4, 'Ep2_S4', 44)
  INTO Episodios VALUES (3, 10000000016, 4, 'Ep3_S4', 49)
  --Season 5
  INTO Episodios VALUES (1, 10000000016, 5, 'Ep1_S5', 57)
  INTO Episodios VALUES (2, 10000000016, 5, 'Ep2_S5', 37)
  -- Money heist Season 1
  INTO Episodios VALUES (1, 10000000017, 1, 'Ep1_S1', 49)
  INTO Episodios VALUES (2, 10000000017, 1, 'Ep2_S1', 43)
  INTO Episodios VALUES (3, 10000000017, 1, 'Ep3_S1', 55)
  -- Season 2
  INTO Episodios VALUES (1, 10000000017, 2, 'Ep1_S2', 45)
  INTO Episodios VALUES (2, 10000000017, 2, 'Ep2_S2', 51)
  INTO Episodios VALUES (3, 10000000017, 2, 'Ep3_S2', 43)
  -- Season 3
  INTO Episodios VALUES (1, 10000000017, 3, 'Ep1_S3', 41)
  INTO Episodios VALUES (2, 10000000017, 3, 'Ep2_S3', 56)
  INTO Episodios VALUES (3, 10000000017, 3, 'Ep3_S3', 58)
  -- Season 4
  INTO Episodios VALUES (1, 10000000017, 4, 'Ep1_S4', 36)
  INTO Episodios VALUES (2, 10000000017, 4, 'Ep2_S4', 37)
  INTO Episodios VALUES (3, 10000000017, 4, 'Ep3_S4', 47)
  -- Season 5
  INTO Episodios VALUES (1, 10000000017, 5, 'Ep1_S5', 54)
  INTO Episodios VALUES (2, 10000000017, 5, 'Ep2_S5', 40)
  INTO Episodios VALUES (3, 10000000017, 5, 'Ep3_S5', 40)
  --Dark Season 1
  INTO Episodios VALUES (1, 10000000018, 1, 'Ep1_S1', 47)
  INTO Episodios VALUES (2, 10000000018, 1, 'Ep2_S1', 47)
  -- Season 2
  INTO Episodios VALUES (1, 10000000018, 2, 'Ep1_S2', 36)
  INTO Episodios VALUES (2, 10000000018, 2, 'Ep2_S2', 40)
  -- Season 3
  INTO Episodios VALUES (1, 10000000018, 3, 'Ep1_S3', 51)
  INTO Episodios VALUES (2, 10000000018, 3, 'Ep2_S3', 55)
  -- Squid Game Season 1
  INTO Episodios VALUES (1, 10000000019, 1, 'Ep1_S1', 42)
  INTO Episodios VALUES (2, 10000000019, 1, 'Ep2_S1', 58)
  INTO Episodios VALUES (3, 10000000019, 1, 'Ep3_S1', 39)
  -- Season 2
  INTO Episodios VALUES (1, 10000000019, 2, 'Ep1_S2', 59)
  INTO Episodios VALUES (2, 10000000019, 2, 'Ep2_S2', 54)
SELECT * FROM dual;

commit;

--Sequencia para os IDs de Pessoas
drop sequence seq_id_Pessoa;
create sequence seq_id_Pessoa
START WITH 10000000026
INCREMENT by 1;

--Sequencia para os IDs de Conteudos
drop sequence seq_id_cont;
CREATE SEQUENCE seq_id_cont
start with 10000000020
increment by 1;

--Seuquencia para os IDs de Plataformas
drop sequence seq_id_Plat;
CREATE sequence seq_id_Plat
start with 10007
increment by 1;

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

