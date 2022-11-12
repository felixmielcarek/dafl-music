<p align="center">
  <img src="https://codefirst.iut.uca.fr/git/DAFLDev/DAFLMusic/raw/branch/master/Documentation/Images/banner.png" />
</p>

[![Build Status](https://codefirst.iut.uca.fr/api/badges/DAFLDev/DAFLMusic/status.svg)](https://codefirst.iut.uca.fr/DAFLDev/DAFLMusic)
[![Bugs](https://codefirst.iut.uca.fr/sonar/api/project_badges/measure?project=DAFLMusic&metric=bugs&token=d36308dfacfc3cb26e1944ec2441cd9563e0c912)](https://codefirst.iut.uca.fr/sonar/dashboard?id=DAFLMusic)
[![Code Smells](https://codefirst.iut.uca.fr/sonar/api/project_badges/measure?project=DAFLMusic&metric=code_smells&token=d36308dfacfc3cb26e1944ec2441cd9563e0c912)](https://codefirst.iut.uca.fr/sonar/dashboard?id=DAFLMusic)
[![Technical Debt](https://codefirst.iut.uca.fr/sonar/api/project_badges/measure?project=DAFLMusic&metric=sqale_index&token=d36308dfacfc3cb26e1944ec2441cd9563e0c912)](https://codefirst.iut.uca.fr/sonar/dashboard?id=DAFLMusic)
[![Duplicated Lines (%)](https://codefirst.iut.uca.fr/sonar/api/project_badges/measure?project=DAFLMusic&metric=duplicated_lines_density&token=d36308dfacfc3cb26e1944ec2441cd9563e0c912)](https://codefirst.iut.uca.fr/sonar/dashboard?id=DAFLMusic)
[![Lines of Code](https://codefirst.iut.uca.fr/sonar/api/project_badges/measure?project=DAFLMusic&metric=ncloc&token=d36308dfacfc3cb26e1944ec2441cd9563e0c912)](https://codefirst.iut.uca.fr/sonar/dashboard?id=DAFLMusic)
[![Security Rating](https://codefirst.iut.uca.fr/sonar/api/project_badges/measure?project=DAFLMusic&metric=security_rating&token=d36308dfacfc3cb26e1944ec2441cd9563e0c912)](https://codefirst.iut.uca.fr/sonar/dashboard?id=DAFLMusic)
[![Vulnerabilities](https://codefirst.iut.uca.fr/sonar/api/project_badges/measure?project=DAFLMusic&metric=vulnerabilities&token=d36308dfacfc3cb26e1944ec2441cd9563e0c912)](https://codefirst.iut.uca.fr/sonar/dashboard?id=DAFLMusic)

# <div align="center">Le contexte du projet</div>

Ce projet est un travail universitaire pour la deuxième année du B.U.T Informatique de Clermont-Ferrand. Il correspond au travail demandé pour la SAE 3.01, nous disposons de 480 heures théoriques pour le réaliser.

<br>

# <div align="center">L'application</div>

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

* Notre projet est un réseau social destiné aux appareils mobiles Android
et iOS focalisé sur la musique.

* Chaque utilisateur voit défiler les profils des autres personnes utilisant
notre application et se trouvant dans un périmètre restreint (environ une
cinquantaine de mètres).

* Un profil peut être "liké" et si les deux personnes se "likent" mutuellement, un "match" a alors lieu, et une conversation est créée pour qu'elles puissent entrer en contact. Après un "like", le profil suivant est affiché. Si ce profil ne l'intéresse pas il peut le "passer", et l'application propose un autre profil, etc.

* Pour chaque profil affiché, il est possible d'envoyer un message, ce qui
créera une conversation en attente chez l'autre personne. Elle pourra
ensuite choisir de répondre ou de le supprimer si elle n'est pas intéressée.

* Un profil affiché est anonyme. Seulement la musique écoutée en temps
réel par la personne possédant le compte est renseignée.

* En cliquant sur un bouton, il est aussi possible de voir des informations
complémentaires toujours sur les goûts musicaux du profil. Ces
informations sont remplies préalablement par chaque utilisateur, cela
peut être par exemple : "Quelle est la musique que je passerais à mon
mariage ?".

* Les informations complémentaires de tous les utilisateurs sont aussi
utilisées pour établir des statistiques dans une page à part. Il y sera
indiqué, pour chaque catégorie, quelle est la musique la plus choisie parmi
tous les utilisateurs.

* Si l'utilisateur est consentant, après un "Match", il peut accepter de
révéler quelques informations personnelles (nom, âge, sexe).
Le but est qu'une mise en contact entre 2 personnes se base uniquement
sur des critères musicaux et non personnels.