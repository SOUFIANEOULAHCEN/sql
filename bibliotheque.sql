#------------------Bibliotheque 
create database Bibliotheque ;
#------------------create tables
create table Specialite(
   NoSpecialite int primary key not null ,
   DescriptionS varchar(40)
);

create table Section (
   NoSection int primary key not null ,
   Emplacement varchar(30),
   DescriptionS varchar(40)
);

create table Livre (
   CodeISBN int primary key not null ,
   Titre varchar(30) ,
   
   NoSpecialite int ,
   CONSTRAINT NoSpecialite FOREIGN KEY (NoSpecialite ) 
   REFERENCES  Specialite (NoSpecialite ) ,
   
   NoSection int ,
   CONSTRAINT NoSection FOREIGN KEY (NoSection ) 
   REFERENCES  Section (NoSection ) 
);

create table Fournisseur (
   NoFournisseur int primary key not null ,
   Nom varchar(30)
);

create table Exemplaire (
   NoExemplaire int primary key not null ,
   
   CodeISBN int ,
   CONSTRAINT CodeISBN FOREIGN KEY (CodeISBN ) 
   REFERENCES  Livre (CodeISBN ) ,
   
   NoFournisseur int ,
   CONSTRAINT NoFournisseur FOREIGN KEY (NoFournisseur ) 
   REFERENCES  Fournisseur (NoFournisseur )
);

create table Abonne (
   NoAbonne int primary key not null ,
   Nom varchar(20),
   Prenom varchar(20)
);

create table Carte (
   NoCarte int primary key not null ,
   DateDebut date ,
   DateFin date ,

   NoAbonne int ,
   CONSTRAINT NoAbonne FOREIGN KEY (NoAbonne ) 
   REFERENCES  Abonne (NoAbonne )
);

create table Emprunt (
  NoExemplaire int primary key not null ,
  NoCarte int ,
  DateLocation date ,
  DateRetour date 
);


#--------------------les requttees
#-------------q1
select l.* from livre l
where l.NoSection in (1,4);

#------------q2
alter table Abonne
add column Adresse varchar(30); 

#--------------q3
insert into Fournisseur (NoFournisseur,Nom) 
value (1,'Livres du Québec inc.');
#---------------q4
select a.Nom , a.Prenom 
from Abonne a 
join Carte c 
on a.NoAbonne = c.NoAbonne 
where year(c.DateFin)='2012' or  year(c.DateDebut)='2012';
#---------------q5
SELECT l.CodeISBN, l.Titre
FROM livre l
JOIN emprunt e ON e.NoExemplaire = l.CodeISBN
WHERE e.DateLocation = '2012-04-28'
ORDER BY l.Titre ASC;

#-------------------q6
select a.Nom , a.Prenom 
from Abonne a
join carte c on c.NoAbonne = a.NoAbonne
join emprunt e on e.NoCarte = c.NoCarte
join Exemplaire ex on ex.NoExemplaire = e.NoExemplaire
join livre l on l.CodeISBN = ex.CodeISBN
where titre ='Nos amis les francais';

#---------------------------q7
UPDATE carte
SET DateFin = '2012-05-25'
WHERE DateFin = '2012-04-25';


