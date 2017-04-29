-- *********************
-- Functions predefinies
-- **********************

-- Dernier Id insere:
INSERT INTO abonne (prenom) VALUES ('test');
SELECT LAST_INSERT_ID();

-- Fonctions de dates:
SELECT *, DATE_FORMAT(date_rendu, '%d-%m-%y') AS date_rendu_fr FROM emprunt; -- mets les dates du champs date_rendu au format francais; c est juste de la lecture cela ne change pas le format de la base de donnees

SELECT NOW(); -- affiche la date et l heure en cours

SELECT CURDATE();-- date du jour
SELECT CURTIME();

-- Crypter un mot de passe avec l algorithme AES :
SELECT PASSWORD('mypass'); -- affiche 'mypass' crypte
INSERT INTO abonne (prenom) VALUES(PASSWORD('mypass')); -- insere le mdb crypte en base

-- Concatenation :
SELECT CONCAT ('a','b','c');
SELECT CONCAT_WS('-','a','b','c'); --concat  with separator

-- Fonctions sur les chaines de caractaires
SELECT SUBSTRING('bonjour, 1, 3'); --affiche 'bon'compte 3 a partir dela posituon 1
SELECT TRIM('   bonjour    '); -- supprime les espaces avant et apres la chaine de caracteres