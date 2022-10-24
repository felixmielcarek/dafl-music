# dafl_project_flutter

*```dafl_project_flutter``` est le nom de notre projet Flutter.*

## Gestion de Git

* Ceci est un **ordre** !

Faire les commit en ligne de commande car Android Studio déclare des erreurs factices dans des fichiers créés pour les plateformes.

1. Ajout de tous les fichiers modifiés / ou créés dans la staging area (fichers locaux prêts à être commit)

```shell
git add -A
```

2. Validation des fichiers destinées à être envoyé sur le repo

```shell
git commit -m "Message corresponding to modifications done in my commmit"
```

*Insérer un message entre les doubles quotes après le ```-m```*

3. Envoi des commit

```shell
git push origin my_branch
```

*Remplacer ```my_branch``` par la branche sur laquelle on a voulu trailler*

## Convention de nommage des répertoires

```
mon_repertoire
```

*Penser à ajouter un ```.gitkeep``` pour que Git conserve le repertoire.*

## Convention de nommage des fichiers

| Contenu du fichier | Convention |
| :- | :- |
| Page de vue | ```p_ma_page.dart``` |
| Page de widget | ```w_mon_widget.dart``` |
