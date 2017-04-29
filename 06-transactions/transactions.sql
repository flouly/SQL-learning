-- **************
-- Transactions
-- *************

-- Permet de lancer des requetes, telles que des modifications, et de les annuler si besoin, comme vous pourriez faire un "CTRL+Z" dans votre base de donnees

START TRANSACTION;
  SELECT * FROM employes; --pour voir la table avant modidication
  UPDATE employes SET prenom = 'ALLO' WHERE id_employes = 739;

  ROLLBACK; --  retourne a la valeur initiale

  COMMIT; --valide l ensemble de la transaction

--   si on ne fait ni ROLLBACK ou COMMIT avant la deconnexion au SGBD s est un ROLLBACK QUi s efffectue par default



-- **************
-- Transaction avancee

START TRANSACTION;
    SAVEPOINT point1;
    UPDATE employes SET prenom = 'Julien A' WHERE id_employes = 699;
    SAVEPOINT point2;
    UPDATE employes SET prenom = 'Julien B' WHERE id_employes = 699;

ROLLBACK TO point2; -- pour annuler une partie de la transaction, on revient au point 2 soit "Julien A"

-- OU bien
ROLLBACK; -- POur annuler toute  la transaction

-- ou bien
COMMIT;