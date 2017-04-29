-- ouvrir la console sous MANP
-- lignes de commentaires 
-- les requetes ne sont pas sensibles a la casse mais une convemtuon indique qu 'il faut mettre les mots cles des requetes en majuscule



CREATE DATABASE entreprise;

SHOW DATABASES; --PERMET D'AFFICHER les BDD DISPONIBLES

-- NE PAS SAISIR dans la console
DROP DATABASE entreprise; -- Efface

DROP table employes;    -- Efface

  TRUNCATE employes;-- VIDER le contenu D'une table

--   On peu coller dans la console:

USE entreprise; -- Se connecter a la BDD entreprise


SHOW TABLES; --PERMET de lister les tables de la DBB encours d'utilisation'


 DESC employes; -- Observer la  structure de la table ainsi que les champs 


--***************
-- Requetes de selection
--***************

SELECT nom, prenom FROM employes; -- Afficher tous les noms et les prenoms de la table employes

SELECT service FROM employes; 

--DISTINCT
-- Quand afficher plusieurs fois ,pour eliminer les doublons
SELECT DISTINCT service FROM employes;

-- ALL ou *
-- on peut afficher toutes les informations d' une table aves une "*"
SELECT * FROM employes;

-- clause WHERE
SELECT prenom, nom FROM employes WHERE service = 'informatique'; -- notez que les noms de champs et de tables ne prennent pas de quotes comme les valeurs cependant s il s agit d un chiffre on ne lui met pas de quote.

-- BETWEEN
SELECT nom, prenom, date_embauche FROM employes WHERE date_embauche  BETWEEN '2001-01-01'
AND '2010-12-31';


-- LIKE
SELECT prenom FROM employes WHERE prenom LIKE 's%'; -- % remplace les autres caracteres

SELECT prenom FROM employes WHERE prenom LIKE '-%-'; -- affiche les prenoms qui contiennent un tiret; like est utiliser pour les formulaire  de recherche sur les sites

-- operateurs de comparaisons
SELECT prenom, nom, service FROM employes WHERE service != 'informatique';
--  = < > <= >=   
-- != <> pour different de


-- ORDER BY pour faire des tris
SELECT nom, prenom, service, salaire FROM employes ORDER BY salaire;


SELECT nom, prenom, service, salaire FROM employes ORDER BY salaire ASC prenom DESC;
-- d abord salaire ascendant puis les prenoms descendant si meme salaires

-- LIMIT
SELECT nom, prenom, salaire FROM employes ORDER BY salaire DESC LIMIT 0,1;
-- utiliser pour la pagination

-- L' alias avec AS
SELECT nom, prenom ,salaire * 12 AS salaire_annuel FROM employes
-- affiche le salaire sur 12 mois, salaire annuel est un alias qui "stocke la valeur de ce qui precede"

-- SUM
SELECT SUM(salaire * 12) FROM employes;
-- addionne des valeurs dans des champs differents

-- MIN et MAX
SELECT MIN(salaire) FROM employes;
SELECT MAX(salaire) FROM employes;
-- ne pas melanger avec d autres champs  SELECT prenom, MIN(salaire) FROM employes :il selectionne le premier prenom qu il troune puis lui affecte le salaire   minimum
SELECT  prenom, salaire FROM employes ORDER BY salaire ASC LIMIT 0,1;

-- AVG
SELECT AVG(salaire) FROM employes;

-- ROUND
SELECT ROUND(AVG(salaire),1) FROM employes;

-- COUNT
SELECT COUNT(id_employes) FROM employes WHERE sexe = 'f';

-- IN
SELECT prenom, service FROM employes WHERE service IN ('comptabilite', 'informatique');
-- comptabilite ou informatique

-- NOT IN
SELECT prenom, service FROM employes WHERE service NOT IN ('comptabilite', 'informatique');

-- AND et OR
SELECT prenom, salaire, service FROM employes WHERE service = 'commercial' AND salaire <= 2000;

SELECT prenom, service, salaire FROM employes WHERE (service = 'production' AND salaire = 1900) OR salaire = 2300;

-- GROUP BY
SELECT service, COUNT(id_employes) AS nombre FROM employes GROUP BY service;
-- affiche le nombre d employes par service; GROUP BY distribue les resultats du comptage par les services correspondants

-- GROUP BY .... HAVING
SELECT service, COUNT(id_employes) AS nombre FROM employes GROUP BY service HAVING nombre > 1;
-- on ne peut pas utiliser un WHERE dans GROUP BY
-- affiche les services ou l il y a plus d'un employe


--***************
-- Requetes d 'insertion
--***************

SELECT * FROM employes;

INSERT INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES (8059, 'alexis', 'richy', 'm', 'informatique', '2011-12-28', 1800);
-- Conserver le meme ordre et le meme nombre de champs que la table

-- Une requete sans precisez les champs concernes
INTO employes VALUES (8059, 'alexis', 'richy', 'm', 'informatique', '2011-12-28', 1800);


--***************
-- Requetes de modification
--***************

-- UPDATE
UPDATE employes SET salaire = 1870 WHERE nom = 'cottet';

UPDATE employes SET salaire = 1870 WHERE id_employes = 699;
-- Il est recommande de passer par l id car il est unique cela evite de  modifier des enregistrements en doublon

UPDATE employes SET salaire = 1872, service = "autre" WHERE id_employes = 699;
-- on modifie plusieurs champs 
-- Ne pas faire de UPDATE sans WHERE, ICI  tout les salaires se mette a 1872;

-- REPLACE
-- INSERT INTO si pas id ; UPDATE si l id existe
REPLACE INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES (2000, 'test', 'test','m','marketing','2010-07-05', 2600);

REPLACE INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES (2000, 'test2', 'test2','m','marketing','2010-07-05', 2600);

--***************
-- Requetes de suppression
--***************

-- DELETE
DELETE FROM employes WHERE id_employes = 900;

DELETE FROM employes WHERE service = 'informatique' AND id_employes != 802;
-- supprime tout les informaticiens sauf un; le 802

DELETE FROM employes WHERE id_employes = 388 OR id_employes = 802;
-- IL s'agit d'un OR et non d'un AND car un employe ne peut avoir 2 id_employes

--  A NE PAS FAIRE: un DELETE sans clause WHERE car irreversible


--***************
-- Exercices
--***************

-- 1 Afficher le service de l employe 547

SELECT service FROM employes WHERE id_employes = 547;

-- 2 Afficher la date d embauche d Amandine

SELECT date_embauche FROM employes WHERE prenom = 'Amandine';

-- 3 AFFICHER le nombre de commerciaux

SELECT COUNT(id_employes) FROM employes WHERE service = 'commercial';

-- 4 AFFICHER le cout des commeciaux  sur 1 an

SELECT SUM(salaire * 12) FROM employes WHERE service = 'commercial';

-- 5 affiche le salaire moyen par service

SELECT service, AVG(salaire) FROM employes GROUP BY service;

-- 6 AFFICHER le nombre  de recrutement sur l annee 2010

SELECT COUNT(id_employes) FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2010-12-31';

SELECT COUNT(id_employes) FROM employes WHERE date_embauche >= '2010-01-01' AND date_embauche <= '2010-12-311'

SELECT COUNT(date_embauche) FROM employes WHERE date_embauche LIKE '2010'; 

-- 7 Augmenter de 100 le salaire de chaque employe 

UPDATE employes SET salaire = salaire + 100; 
 
-- 8 afficher le nombre de service different

SELECT COUNT(DISTINCT service) FROM employes;

-- 9 Afficher le nombre d employes par service

SELECT service, COUNT(id_employes) AS nombre FROM employes GROUP BY service;

-- 10 AFFICHER les infos de l'employer du service commercial ayant le salaire le + eleve
SELECT id_employes, prenom, nom, sexe, service, date_embauche, salaire  FROM employes  WHERE service = 'commercial' ORDER BY salaire DESC LIMIT 0,1;

-- 11 Afficher l'employe ayant ete embauche en dernier
SELECT id_employes, prenom, nom, sexe, date_embauche FROM employes ORDER BY date_embauche DESC LIMIT 1;





