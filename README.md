# Ailerons App iOS

## Aperçu

Ailerons App iOS est une application mobile collaborative développée en collaboration avec l'[association Ailerons](https://www.asso-ailerons.fr/) de l'Université de Montpellier 2. Ce projet vise à fournir une solution mobile pour gérer certains aspects des activités de l'association.

## Fonctionnalités

- **Développement Mobile Full-Stack :** L'application est développée en utilisant SwiftUI dans une architecture MVVM, offrant une expérience utilisateur fluide sur les appareils iOS.
- **Intégration d'Apple MapKit :** Utilise l'API Apple MapKit dans UIKit pour afficher des points GPS sur la carte, facilitant les services basés sur la localisation.
- **Intégration de UIKit avec SwiftUI :** Incorporation de composants UIKit dans SwiftUI à l'aide de UIViewRepresentable, permettant une interface utilisateur plus riche et plus personnalisable.
- **Injection de Dépendances :** Implémente l'injection de dépendances pour découpler les composants et améliorer la testabilité et la maintenabilité de la base de code.
- **Conteneurs de Contrôleurs de Vue :** Utilise les conteneurs de contrôleurs de vue pour gérer plusieurs contrôleurs de vue au sein d'un seul contrôleur de vue parent, améliorant la modularité et l'organisation.
- **Intégration de l'API Subapase avec Swift Package Manager (SPM) :** Exploite Swift Package Manager pour une intégration transparente de l'API Subapase, simplifiant le processus de gestion des dépendances.
- **Développement d'une API Backend avec Flask :** Développe une [API backend](https://github.com/mobileailerons/ailerons-tracker-backend) en utilisant Flask pour prendre en charge les fonctions administratives et la gestion des données, assurant une communication transparente entre l'application mobile et les composants côté serveur.
- **Compatibilité Multiplateforme :** Complémente l'application iOS avec une [application Android native](https://github.com/onatyr/ailerons-app-map-android), offrant une expérience utilisateur cohérente sur différentes plateformes.

## Technologies Utilisées

- **Développement iOS :** SwiftUI, UIKit
- **Services de Cartographie :** Apple MapKit
- **Développement Backend :** Flask
- **Gestion des Dépendances :** Swift Package Manager (SPM)
- **Contrôle de Version :** Git

## Captures d'Écran

<img width="412" alt="" src="https://github.com/Jezzatator/ailerons-app-ios/assets/84284069/c10b7c1b-492d-4401-9036-54d6ba1e0281">

## Contributeurs

- [Jérémie Patot](https://github.com/Jezzatator) - Développeur iOS
- [LouisCoutel](https://github.com/LouisCoutel) - Développeur Backend
- [Onat Rigault](https://github.com/onatyr) - Développeur Android

## Remerciements

Nous tenons à exprimer notre gratitude à l'association Ailerons pour leur collaboration et leur soutien tout au long du processus de développement. Un merci spécial à Ada Tech School pour avoir fourni conseils et mentorats.
