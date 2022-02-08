--baza de date Compania_it
--tema bazei de date:Evidenta angajatilor la compania Moldtelecom
DROP DATABASE Compania_it
CREATE DATABASE Compania_it
--accesam baza de date
DROP TABLE Functii
USE Compania_it
CREATE TABLE Angajati
     (
	  idangajati int primary key identity(1,1)      --PK
	  ,nume varchar(20)
	  ,prenume varchar(20)
	  ,iddept int       --foreign key
	  ,birou smallint
	  ,stagiu smallint NULL   --stagiu de munca
	  ,idFunctie int
     )
CREATE TABLE Departamente
      (
	   iddept int primary key identity(1,1)      --PK
	   ,dept char(20)
	   ,adresa char(20)
	   ,oras char(20)
	  )
CREATE TABLE Functii
     (
	 idFunctie int primary key identity(1,1)
	 ,DenFunctie char(50)
	 ,salariu smallint
	 )
--Stabilim relatiile
ALTER TABLE Angajati
  ADD CONSTRAINT FK_Angajati_iddept
     FOREIGN KEY (iddept) REFERENCES Departamente (iddept)
ALTER TABLE Angajati
  ADD CONSTRAINT FK_Angajati_idFunctie
     FOREIGN KEY (idFunctie) REFERENCES Functii (idFunctie) 
--Inseram valorile in tabele
Insert into Departamente (dept,adresa,oras)
Values('Administratie','Independentei','Iasi')
      ,('Productie','Primaverii','Bucuresti')
      ,('Distributie','Central','Focsani')
      ,('Planificare','Nicolina','Iasi')
      ,('Cercetare','Trandafirului','Cluj')

Insert into Angajati(nume,prenume,birou,stagiu,iddept,idFunctie)
Values('Ionescu','Maria',10,5,1,1)
      ,('Popescu','Ion',20,10,2,2)
	  ,('Popa','Stefan',20,0,1,3)
	  ,('Dumitrescu','Vasile',16,45,3,4)
	  ,('Danilov','Ion',14,8,4,5)
	  ,('Manole','Radu',7,7,4,6)
	  ,('Luca','Doru',75,4,1,7)
	  ,('Vasile','Alina',2,46,2,8)

INSERT INTO Functii(DenFunctie,salariu)
Values('Manager',78)
     ,('asistent manager',23)
	 ,('Contabil',23)
	 ,('contabil sef',23)
	 ,('operator',23)
	 ,('administrator BD',23)
	 ,('technician de site-uri WEB',23)
	 ,('programator',23)
	 ,('tehnician retelistica',23)
	 ,('technician securitate',23)
	 ,('tester',23)
--Afisati acei angajați care activează în departamentul cu identificatorul 2
select count (*)
from Angajati
where iddept = 2 
--Afișați departamentele în care nu activează nici un angajat cu numele “Ignat”
select iddept
from Departamente
except
select iddept
from Angajati
where Nume = 'Ignat'
select nume ,prenume 
from Angajati
where iddept = 2 
--Afisati numele angajatilor, departamentul si salariul acestora
select nume,prenume, dept, salariu
from Angajati as a 
inner join Departamente as d on a.iddept=d.iddept
inner join Functii as f on a.iddept=f.idFunctie
--Selectati numele angajaților si orașul în care aceștea activează
select nume,oras from Angajati
inner join Departamente
on Angajati.iddept=Departamente.iddept
--Cautati persoana cu numele “Danilov” si afisati datele acesteia
select nume, prenume,birou,stagiu
from Angajati
where nume='Danilov'
--
select nume, prenume, birou, stagiu,DenFunctie,salariu,dept, adresa, oras
from Angajati as a 
	inner join departamente as d on a.idDept=d.idDept
    inner join Functii as f on a.idFunctie=f.idFunctie
	where nume='Danilov'
SELECT nume, prenume, dept from Angajati
inner join Departamente
on Angajati.iddept=Departamente.iddept
where nume like '%e%'
--between
SELECT nume, prenume, salariu from Angajati 
inner join Departamente
on Angajati.iddept=Departamente.iddept
where salariu between 45 and 80

SELECT nume, prenume, adresa from Angajati
inner join Departamente
on Angajati.iddept=Departamente.iddept

SELECT * FROM Departamente
SELECT * FROM Angajati
SELECT * FROM Functii
--interogarea bazei de date(10 sarcini conform resursei oferite de profesor)
-- Să se găsească toate informaţiile referitoare la angajatul cu numele Ionescu. 
select *
from Angajati
where Nume = 'Ionescu' --Găsiţi salariul lunar al angajaţilor cu numele Popescu. select salariu/12 as salariuLunar
from Angajati
where nume = 'Popescu'
-- Să se găsească numărul valorilor distincte pentru atributul. Salariu pentru toţi angajaţii din tabela ANGAJAŢI. 
select count (distinct salariu)
from Angajati 
--Să se găsească numărul de linii din tabelul ANGAJATI care au valori diferite de NULL pentru atributul Salariu. 
select count (all salariu)
from Angajati 
--Să se găsească salariul maxim, mediu şi minim pentru toţi angajaţii din tabela ANGAJAŢI.
select max(salariu), avg(salariu), min(salariu)
from Angajati 
-- Să se găsească suma salariilor angajaţilor din acelaşi departament. 
--Utilizarea Alias
 select iddept, sum(salariu) 'SUMa SALARIU'
from Angajati
group by iddept
--Să se găsească salariul maxim pentru angajaţii care lucrează într-un departament din Iasi.
--Utilizarea Alias
select max(salariu) as MaxSalariu
from Angajati a, Departamente d
where a.iddept = d.iddept and oras = 'Iasi'
--Să se găsească departamentele în care salariul mediu al angajaţilor din biroul 20 este mai mare ca 25. 
select iddept
from Angajati
where birou = '20'
group by iddept
having avg(stagiu) > 25
--
--Să se găsească angajaţii ce lucrează într-un departament din Iaşi. 
select nume, prenume
from Angajati
where iddept = any (select iddept from Departamente where oras = 'Iasi')
--Să se găsească numele angajaţilor şi oraşele în care aceştia lucrează.
select Angajati.nume, Angajati.prenume, Departamente.oras
from Angajati, Departamente
where Angajati.iddept = Departamente.iddept 
--ALIAS
select max(salariu) SalariuMax, avg(salariu) as SalariuMediu, min(salariu)'SalariuMin'
from Angajati 
--inner join
SELECT nume, prenume, salariu,dept from Angajati as AG
inner join Departamente as DP
on AG.iddept=DP.iddept
where salariu='45'
--left join
SELECT dept,nume, prenume, birou from Angajati as AG
left join Departamente as DP
on AG.iddept=DP.iddept
where salariu='45'
--right join
SELECT dept,nume, prenume, birou from Angajati as AG
right join Departamente as DP
on AG.iddept=DP.iddept
--full join
SELECT dept,nume, prenume, birou from Angajati as AG
full join Departamente as DP
on AG.iddept=DP.iddept
where birou=20
--toate sarcinile din resursa
--de realizat exemplele din resursa de pe moodle 