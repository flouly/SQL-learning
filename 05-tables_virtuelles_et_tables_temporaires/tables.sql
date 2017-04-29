-- ****************
-- Tables virtuelles : vues
-- *****************

-- Les vues sont des objets de la BDD constistue d un nom et d une requete de    selection

-- Une fois une vue definie om peut utiliser comme on le ferait avec une table laquelle serait constituee des donnees silectionnees   par la requete definissant la   vue


-- Creation d une vue
CREATE VIEW vue_homme AS SELECT prenom, nom, sexe, service FROM employes WHERE sexe = 'm';

-- une seconde requete effectuee dur la vue

SELECT prenom FROM vue_homme;

-- les tables vues sont dynamiques (tout changement est enregistres entre la table vue et la table d origine)

-- Elles sont visibles dans la BDD

-- Supprimmer une vue
DROP VIEW vue_homme;

-- ***************
-- Tables temporaires
-- *************

CREATE TEMPORARY TABLE temp SELECT * FROM employes WHERE sexe = 'f';-- Creer une table qui s efface lorsqu on quitte la session, elle n est pas visible dans la liste des tables SHOW TABLE

SELECT prenom FROM temp;

-- N est pas dynamique, c est une copie a un instant t, les donnees sont dupliques