# TypeScript + PixiJS

## Configuration

### Installer NodeJS et NPM
Afin de tester l'environnement, vous devez avoir NodeJS et NPM installé sur votre machine.  
Ces deux outils peuvent être installés via l'[installateur de NodeJS](https://nodejs.org/en/download/).

### Installer les dépendences
Une fois Node et NPM installés, il faut télécharger les modules node utilisés par le projet.  
Pour cela exécuter la commande:

```npm install```

### Configurer WebStorm

#### Linter
todo
![Enable linter](./doc/enable_linter.png)
![Enable prettier](./doc/enable_prettier.png)

## Utilisation
Afin de lancer le projet, exécuter la commande:

```npm run start```

## Plus d'information

### Webpack
Webpack est un _static module bundler_ pour JavaScript. Il permet de regrouper les différents modules d'un projet en un 
ou plusieurs bundle tout en gérant les dépendences entre ces modules.
- [Core concepts](https://webpack.js.org/concepts/)
- [Getting started](https://webpack.js.org/guides/getting-started/)
- [Webpack with TypeScript](https://webpack.js.org/guides/typescript/)

### TypeScript

## TODO

- Ajouter un linter (https://eslint.org/blog/2019/01/future-typescript-eslint)
- Optimiser webpack (https://webpack.js.org/guides/build-performance/#typescript-loader)
- Gérer la mise en production (https://webpack.js.org/guides/production/)
- Comparer Parcel et Webpack (https://parceljs.org/)
- Resizer automatiquement le canvas