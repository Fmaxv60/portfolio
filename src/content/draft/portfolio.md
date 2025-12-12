---
title: 'Mon portfolio'
description: 'Petit portfolio fait avec Astro'
pubDate: 'Jul 1 2025'
updatedDate: 'Dec 08 2025'
heroImage: '../../assets/portfolio.jpg'
tags: ['Astro', 'Web', 'Self-hosted']
---

En tant qu'ingénieur en informatique, avoir un site portfolio personnel est un gros plus. Cela me permet de développer ou de renforcer mes compétences mais aussi de les montrer aux recruteurs et aux potentiels collaborateurs. Au-delà d'un simple site développé en JavaScript / Markdown, il s'agit d'un ensemble : choix d'outils, pipeline d'intégration continue, build optimisé et stratégie de déploiement adaptée à l'hébergement. 

## Choix des technologies

Avant de choisir quelles technologies utilisées et changer toutes les deux minutes parce que cela ne convient pas à mon projet, j'ai pris le temps d'établir clairement mes besoins et ce que je voulais pour ce site. J'ai finit par établir ce plan :
- une page d'accueil avec un petit texte, asez bref, sur moi.
- une section "blog" où je pourrais parler de mes projets dans des petits (ou grands) articles.
- une page à propos avec plus d'informations sur moi-même. 

Ayant un penchant pour tout ce qui est en raport avec le SysAdmin, le DevOps ou encore le backend en général, on comprend vite que mes compétences en design sont faibles. Je n'ai jamais été un grand fan du CSS et même si de nombreux frameworks rendent cela plus simple et accessible, ce n'est toujours pas ma tasse de thé. Cependant, je voudrais quand même pouvoir ajouter une page stylisé avec plein d'effets parce que je trouve ça cool (oui ça arrivera un jour, promis !). Il me faut donc quelque chose qui me permet de faire des sites types "blogs", avec la possibilité d'ajouter des pages qui ne sont pas des postes de blog, et peu de design à faire. 

Ayant déjà quelques connaissances en site web (cf [mon site de tracking PEA](/blog/peasy-money)), je voulais quelque chose qui se rapproche de react, next.js etc. Au cours de mes recherche, je suis tombé sur le framework Astro. 

<img src="/img/astro.png" alt="Logo de Hetzner" style="display: block; margin: auto; max-width: 70%; height: auto; margin-bottom: 2rem;" />

Astro est un framework "content-based". Contrairement aux frameworks conçus pour les applications web complexes (comme React/Next.js qui envoient souvent beaucoup de JavaScript), Astro est optimisé pour les sites où le contenu est roi (blogs, sites marketing, portfolios, e-commerce léger). Le gros plus d'astro est que l'on peut écrire des articles en Markdown ou même en MDX et astro s'occupe d'en faire de belles pages et par exetension de beaux articles. Avec markdown, on peut ajouter facilement des tableaux, des morceaux de code (très pratique dans un portfolio de dev !), des images et j'en passe. Pour ce qui est du rendu et des perfomances, Astro a une politique 0 javascript, ce qui veut dire que le rendu final ne contient que du HTML et du CSS. Ainsi les performances sont maximisé. Puisque mon site n'est pas une application et doit juste afficher du contenu en somme, Astro est LE framework idéal pour mon projet. Il reste juste un petit détail : le design du site ? Eh bien Astro permet de créer des templates de sites. Il existe donc des quantités de templates prêtes à l'emploi qui n'attendent que d'être utilisé. Pour ma part j'ai choisi le template de blog base d'astro. Le style me plait et je peux aisément faire les quelques modifs que je souhaite (ajout de la tables des matières, ajout de tags, ...)  

Le développement n'était pas très compliqué. J'ai fait 

## Déploiement continue et déploiement

Avoir 

#### Github Actions

#### Watchtower

Vous pouvez trouver le repo github du projet [ici](https://github.com/Fmaxv60/portfolio)
