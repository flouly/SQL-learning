-- ******************
-- Requetes preparees
-- ********************

-- Requetes qui dissocie les phases Analyse/ Interpretation / Execution  La preparation de la requete consiste a realiser  lsea etapes d analyses  et d interpretation Ensuite on effectue l execution a part

-- La separation des phasses permet de faire des gains de performance quand une requete est executee  une multitude de fois


-- Requete preparee sans marqueur 
-- 1er preparation
PREPARE req FROM "SELECT * FROM employes WHERE service = 'commercial'";

-- 2em Execution de  ma requete:
EXECUTE req;
-- On peut executer la requete plusieur fois


-- Requete preparee avec un marqueur
-- 1er preparation :
PREPARE req2 FROM "SELECT * FROM employes WHERE prenom = ?"; -- le ' ?' est un marqueur qui attend une valeur

-- 2em execution :
SET @prenom = 'Emilie'; -- declare et affecte une variable
EXECUTE req2 USING @prenom;

-- Supprimer une requete preparee :
DROP PREPARE req2;

-- Les requetes preparees ne sont valables que le temps de la session.