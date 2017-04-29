-- qui conduit la voiture d id_vehicule 503

-- qui conduit quel modele

-- Inserer vous dans la table conducteur. Puis afficher tous les conducteurs( meme ceux non affectes) ainsi les modeles de vehicules

-- Ajouter l enregistrement suivant
INSERT INTO vehicule (marque, modele, couleur, immatriculation) VALUES ('Renault', 'Espace', 'noir', 'ZE-123-RT');
-- PUIS afficher tous les modeles de vehicule, y compris cwua qui n ont pas de chauffeur affecte , et le prenom des conducteurd

-- afficher les premom des conducteurs et tousles modeles


-- 1
SELECT c.nom
FROM conducteur c
INNER JOIN association_vehicule_conducteur a
ON c.id_conducteur = a.id_conducteur
WHERE id_vehicule = 503;

-- 2
SELECT c.nom, v.modele
FROM conducteur c
INNER JOIN association_vehicule_conducteur a
ON  c.id_conducteur = a.id_conducteur
INNER JOIN vehicule v
ON a.id_vehicule = v.id_vehicule;


-- 3
INSERT INTO conducteur (prenom, nom) VALUES ('Frederic', 'Louly');

SELECT c.nom, v.modele
FROM conducteur c
LEFT JOIN association_vehicule_conducteur a
ON  c.id_conducteur = a.id_conducteur
LEFT JOIN vehicule v
ON a.id_vehicule = v.id_vehicule;

-- 4


SELECT v.modele, c.prenom
FROM vehicule v
LEFT JOIN association_vehicule_conducteur a
ON  a.id_vehicule = v.id_vehicule
LEFT JOIN conducteur c
ON c.id_conducteur = a.id_conducteur;

-- 5

(SELECT c.nom, v.modele
FROM conducteur c
LEFT JOIN association_vehicule_conducteur a
ON  c.id_conducteur = a.id_conducteur
LEFT JOIN vehicule v
ON a.id_vehicule = v.id_vehicule)
UNION
(SELECT c.nom, v.modele
FROM vehicule v
LEFT JOIN association_vehicule_conducteur a
ON  a.id_vehicule = v.id_vehicule
LEFT JOIN conducteur c
ON c.id_conducteur = a.id_conducteur);

-- Il faut que les SELECT portent sur les meme champs et soit dans le meme ordre avec UNION
