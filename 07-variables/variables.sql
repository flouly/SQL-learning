-- *******************
-- Les variables en SQL
-- ********************

-- variable est un espace memoire nomme qui permet de conserver une valeur

-- permet d observer les variables systemes :
SHOW VARIABLES;

-- ON Peut acceder a une variable systeme avec 2 @
SELECT @@version;

-- determiner nos propres variables
SET @ecole = 'WF3';

SELECT @ecole;