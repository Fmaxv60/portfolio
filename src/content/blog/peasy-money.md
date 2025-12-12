---
title: 'Peasy Money, le tracker de PEA'
description: 'Peasy Money est une application web de tracking d''investissement'
pubDate: 'Jun 30 2025'
heroImage: '../../assets/peasy-money.png'
tags: ['Next.js', 'Python', 'SQL', 'Self-hosted']
---

## Peasy Money, le tracker de PEA

Après être devenu alternant, j'ai cherché un moyen efficace d'épargner. Je me suis alors renseigné et j'ai décidé d'ouvrir un PEA. Cependant, la banque vers laquelle je me suis tourné propose une interface vétuste et très peu pratique. J'ai donc décidé de faire mon propre dashboard. Je pensais, à tort, que cela ne serait pas si compliqué, mais le projet s'est révélé plus complexe que prévu. En effet, faire des calculs et proposer des indicateurs pertinents est un vrai métier. J'ai essayé tout de même de me débrouiller et pour le moment, je suis satisfait de ce que j'ai réussi à faire.

Le projet se compose de :
- Une interface web faite avec Next.js
- Une API faite avec FastAPI
- Une base de données PostgreSQL

Le projet intègre un flux CI/CD complet avec un déploiement automatique dès chaque push GitHub sur mon serveur personnel. Je ne fais tourner le site qu'en local pour mon utilisation pour le moment.

Vous pouvez trouver le repo github du projet [ici](https://github.com/Fmaxv60/peasy-money) pour plus d'informations.