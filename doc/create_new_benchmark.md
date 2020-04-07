# Benchmarks

# infos

pixi.js doc : http://pixijs.download/dev/docs/index.html
pixi.js exemples : http://pixijs.io/examples/#/basics/basic.js
pixi.js repos : https://github.com/pixijs
pixi dart : autre facade possible : https://github.com/emergent-design/pixi.dart

## Folders structure

- lib/custom/__benchmark_name__
    - /engines
        - common.dart:
            - placer le manager Customisé qui contient les méthode tests à lancer
    - /interfaces
    placer quoi ???
    
- lib/runs//__benchmark_name__.dart
    - placer le benchmark en soit

## Create a new benchmark

1. créer une structure de dossier/fichier dans custom/__benchmark_name__ similaire à filters
    - engines et interfaces
    
2. créer un dossier lib/runs/__benchmark_name__.dart

2. placer les benchmarks dans /web/run/__benchmark_name__/
    - __benchmark_name__.dart
    - __benchmark_name__.html