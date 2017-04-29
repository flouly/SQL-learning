--creation de la BDD

create DATABASE bibliotheque;

USE bibliotheque;

-- COPIER/COLLE  le contenu de bibliotheque dans la console



-- 1 quel est l id_abonne de laura ?

SELECT id_abonne FROM abonne WHERE prenom = 'laura';

-- 2 l abonne d id_abonne 2 est venu emprunter un livre a quelle date ?

SELECT id_abonne, date_sortie FROM emprunt WHERE id_abonne = 2;

-- 3 Combien d emprunt ont ete effectue en tout ?

SELECT COUNT(id_emprunt) AS nombre_d_emprunt FROM emprunt;

-- 4 combien de livres sont sortis  le 2011-12-19 ?

SELECT COUNT(id_emprunt) FROM emprunt WHERE date_sortie = '2011-12-19';

-- 5 une Vie est de quel auteur ?

SELECT auteur FROM livre WHERE titre = 'une Vie';

-- 6 de combien de livre d Alexandre Dumas dispose t on ?

SELECT COUNT(id_livre) FROM livre WHERE auteur = 'ALEXANDRE DUMAS';

-- 7 quel id_livre est le plus emprunte ?

SELECT  id_livre, COUNT(id_livre) FROM emprunt GROUP BY id_livre ORDER BY COUNT(id_livre) DESC LIMIT 1;

-- 8 quel id_abonne emprunte le + de livres ?
SELECT id_abonne, COUNT(id_emprunt) FROM emprunt GROUP BY id_abonne ORDER BY COUNT(id_emprunt) DESC LIMIT 1;


-- ******************
-- Requetes imbriques
-- ******************

-- Syntaxe aide memoire
-- SELECT a FROM table_de_a WHERE b IN (SELECT b FROM table_de_b WHERE condition)

-- Il faut un champs commun entre les 2 tables pour une requete imbriquee

-- Un champs NULL se teste avec IS NULL;
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL;

-- Afficher les titres de ces livres non rendu
SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);
    
    -- Afficher le numero des livres que Chloe a emprunte;

    SELECT id_livre FROM emprunt WHERE id_abonne = (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe');

    -- Lorsque qu il y a un seul resultat dans la requete on met un signe "=""

    -- Afficher  le prenom des abonnes ayant emprunte un livre le 19-12-2011

    SELECT id_abonne, prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE date_sortie = '2011-12-19');

    -- Afficher le prenom des abonnes ayant emprunter un livre d Alphonse Daudet

    SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE id_livre IN(SELECT id_livre FROM livre where auteur = 'ALPHONSE DAUDET'));

    -- Afficher les titres que Chloe a emprunte
    SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe' ));

    -- Afficher les titres que Chloe n a pas encore rendu
    SELECT titre FROM livre WHERE id_livre IN (SELECT  id_livre FROM emprunt WHERE date_rendu IS NULL AND id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe' ));

    -- Combien de livres Benoit a emprunte
    SELECT  COUNT(id_livre) FROM emprunt WHERE id_abonne IN(SELECT id_abonne FROM abonne WHERE prenom = 'Benoit' );

    -- Qui a emprunter le plus de livres

     SELECT prenom FROM abonne WHERE id_abonne = (SELECT id_abonne FROM emprunt GROUP BY id_abonne ORDER BY COUNT(id_livre) DESC LIMIT 1); -- avec LIMIT on ne peut pas utiliser IN mais obligatoirement "="



-- ****************
-- JOINTURE INTERNE
-- ***************

-- Difference entre une jointure et un requete imbriquee :  une R I est possible seulenebnt dans le cas ou les champs affiches(ceux qui dont dans le select) sont issue de  la meme table.
-- Une jointure est une requete permetttant  de faire des relations entre les differentes tables afin d avoir des colonnes ASSOCIES qui ne forment qu un SEUL resultat



-- Afficher les dates de sortie et de rendu pour l abonne Guillaume
SELECT a.prenom, e.date_sortie, e.date_rendu
FROM abonne a 
INNER JOIN emprunt e
ON a.id_abonne = e.id_abonne
WHERE a.prenom = 'guillaume';

-- 1e ligne : ce que je souhaite afficher
-- 2e ligne : la 1er table d ou viennent les informations
-- 3e ligne : la seconde table d ou proviennent les informations
-- 4e ligne : la jointure qui lie les 2 tables avec le champs commun
-- 5e ligne : la ou les conditions supplementaire

-- les mouvements des livres (titres , dates) ecrits par ALPHONSE

SELECT e.date_sortie, e.date_rendu, l.titre
FROM livre l
INNER JOIN emprunt e
ON l.id_livre = e.id_livre
WHERE l.auteur = "ALPHONSE DAUDET";

-- qui a emprunter  "une Vie" sur l annee 2011

SELECT a.prenom
FROM abonne a
INNER JOIN emprunt e
ON a.id_abonne = e.id_abonne
INNER JOIN livre l
ON e.id_livre = l.id_livre
WHERE l.titre = 'une vie' and e.date_sortie LIKE '2011%';

-- Afficher le nombre de livres empruntes par chaque abonne
SELECT a.prenom, COUNT(e.id_emprunt) AS nombre 
FROM abonne a
INNER JOIN emprunt e
ON a.id_abonne = e.id_abonne
GROUP BY a.prenom;

-- Afficher qui a emprumter quel livre et a quel date de sortie?
SELECT a.prenom, l.titre, e.date_sortie
FROM abonne a
INNER JOIN emprunt e
ON a.id_abonne = e.id_abonne
INNER JOIN livre l
ON e.id_livre = l.id_livre
-- Ici pas de GROUP BY car il est normal que  les penoms sortent plusieurs fois, ils empruntent plusieurs livres

-- Afficher les prenoms des abonnes avec les id_livres qu ils ont empruntes
SELECT a.prenom, e.id_livre
FROM abonne a
INNER JOIN emprunt e
ON a.id_abonne = e.id_abonne;

-- Jointure externe
-- une jointure externe permet de faire des requetes sans correspondance exigee entre les valeurs requetes

-- Ajoutez vous dans la table abonne
INSERT INTO abonne (prenom) VALUES('moi');

-- Si on relance la derniere requete  de jointure interne, nous n apparaissons pas dansla liste car nous n avons pas emprunte de livres
-- Pour y remedier nous faisons un jointure externe
SELECT a.prenom, e.id_livre
FROM abonne a
LEFT JOIN emprunt e
ON a.id_abonne = e.id_abonne;

-- La clause LEFT JOIN permet de rapatrier  toutes les donnees dans la table consideree comme etant a gauche de l instruction LEFT JOIN (donc abonne dans cas), sans correspondance exigee dans l autre table.

-- Cas avec un livre suppreimme de la biblio
DELETE FROM livre WHERE id_livre = 100;

-- On visualise les emprunts avec une jointure interne
SELECT emprunt.id_emprunt, livre.titre
FROM emprunt
INNER JOIN livre
ON emprunt.id_livre = livre.title
-- On ne voit pas dans cettte requete le livre qui a ete supprime

-- Donc jointure externe
SELECT emprunt.id_emprunt, livre.titre
FROM emprunt
LEFT JOIN livre
ON emprunt.id_livre = livre.id_livre;
-- ici tous les emprunts sont affiches . meme les NULL


-- ************
-- Union permet de fusionner le resultat de 2 requetes dans la meme liste de resultat
-- ************

-- si on supprime Guillaume on peut afficher a la f ois tous les livrress empruntes, yconpris ceux par des lecteurs desinscrits et tous les abonnes meme ceux desinscrits
DELETE FROM abonne WHERE id_abonne = 1;

-- requete sur les livres empruntes avec UNION
(SELECT abonne.prenom, emprunt.id_livre FROM abonne LEFT JOIN emprunt ON abonne.id_abonne = emprunt.id_abonne)
UNION
(SELECT abonne.prenom, emprunt.id_livre FROM abonne RIGHT JOIN emprunt ON abonne.id_abonne = emprunt.id_abonne);

