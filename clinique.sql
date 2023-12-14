create database activite_synthese;
use activite_synthese;

create table patient(
  NoPatient int not null primary key,
  NoAssSociale int ,
  Nom varchar(20),
  Prenom varchar(20),
  NoTelephone varchar(15),
  DateNaissance date
);
insert into patient value (111111,12345678,'Delisle','Pierre' , '22 33 44 33 22','1977-04-11'),
						  (111112,87654321,'Delisle','Sylvain' , '33 22 44 33 55' , '1975-08-21'),
                          (111113,23234433,'Tremblay','Sylvain' , '418-275-1232','1980-01-30');
				
DROP TABLE patient;                

#----------------------------------------------------------
create table medecin(
  NoMedecin int not null primary key,
  Nom varchar(20),
  Prenom varchar(20)
);
insert into medecin value (12345,'Lajoie','Rene'),
						  (67899,'Dion','Celine');
                       

#--------------------------------------------------------
create table diagnostic(
  NoDiagnostic int not null primary key,
  descriptiond varchar(40) 
);
insert into diagnostic values (1,'Migraine'),
                              (2,'Fracture au bras');
#-------------------------------------------------------
create table traitement(
  NoTraitement int not null primary key,
  descriptiont varchar(40) 
);               

insert into traitement values (1,'2 Cachets a toutes les 4 heurs'),
                              (2,'Placer le bras dans un platre');                             
#-------------------------------------------------------
create table entree_dossier(
  NoDossier int not null primary key,
  dateViste date,
  
  NoPatient int ,
  CONSTRAINT NoPatient FOREIGN KEY (NoPatient ) 
  REFERENCES  patient(NoPatient ),
  
  NoMedecin int ,
  CONSTRAINT NMedecin FOREIGN KEY (NoMedecin ) 
  REFERENCES  medecin(NoMedecin ),
  
  NoDiagnostic int,
  CONSTRAINT NDiagnostic FOREIGN KEY (NoDiagnostic ) 
  REFERENCES  diagnostic(NoDiagnostic ),
  
  NoTraitement int,
  CONSTRAINT NoTraitement FOREIGN KEY (NoTraitement ) 
  REFERENCES  traitement (NoTraitement )
);

insert into entree_dossier values (1, '2008-04-25' , 111111 ,12345 , 1 , 1 ),
                                (2, '2008-04-26' , 111111 ,67899 , 2 , 2 ),
                                (3, '2008-04-26' , 111111 ,12345 , 2 , 1 ),
                                (4, '2008-04-26' , 111112 ,67899 , 1 , 1 );

#-----les requette sql simple-------------
#------------------q1
select * 
from  patient ;  

#---------------q2
select Nom , Prenom
from patient ;

#-----------------q3
select Nom , Prenom
from patient 
where Nom = 'Delisle';

#------------------q4
select Nom,Prenom 
from patient 
where  year(DateNaissance) > '1977';

#-------------------q5
select distinct Prenom as prenomPatien 
from patient;

#-------------------q6
SELECT Nom, Prenom, DateNaissance
FROM patient
ORDER BY DateNaissance ASC;
#--------------------q7
select * from entree_dossier
where NoPatient =111111 and NoMedecin = 67899 ;

#-----------------------------
#-------------------- -----q1
select e.* , p.* from entree_dossier e 
inner join patient p 
on e.NoPatient = p.NoPatient ;
#--------------------------q2
select e.* from entree_dossier e 
inner join patient p
on  e.NoPatient = p.NoPatient 
where p.Nom = 'Delisle' and p.Prenom = 'Pierre';
#----------------------------q3
select t.descriptiont from traitement t
join entree_dossier e 
on t.NoTraitement = e.NoTraitement 
join patient p 
on p.NoPatient = e.NoPatient 
where p.Nom = 'Delisle' and p.Prenom = 'Pierre';
#------------------------------q4
select p.Nom , p.Prenom from patient p 
join entree_dossier e 
on p.NoPatient = e.NoPatient and e.dateViste = '2008-04-26'
join medecin m 
on e.NoMedecin = m.NoMedecin 
where m.Nom = 'Lajoie' and m.Prenom = 'Rene'






                             
                                
