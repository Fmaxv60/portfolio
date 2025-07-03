---
title: 'Mon homelab'
description: 'Voici mon architecture maison'
pubDate: 'Jul 1 2025'
heroImage: '../../assets/homelab.jpg'
tags: ['Self-hosted', 'Linux', 'Docker']
---

## Mon homelab

Pour que ce site soit accessible, il fallait que je l’héberge quelque part, pour le diffuser sur Internet.  
Passionné par le hardware, mon premier réflexe a été de chercher un vieux PC — un Dell Optiplex ou un HP Prodesk — sur Leboncoin, avec l’idée de le transformer en serveur maison. L’idée me plaisait bien : bricoler un peu, recycler du matos, et héberger moi-même mes projets.

Mais je voulais trouver une machine dans ma région, histoire d’éviter la livraison (et les risques de casse). Malheureusement, il n’y avait pas grand-chose d’intéressant à proximité ou alors la configuration ne correspondait pas à mes besoins. J’ai donc fini par me rabattre sur une autre solution : **les VPS**.

Il existe plein d’hébergeurs qui proposent des VPS à des prix très abordables, tant qu’on ne fait pas tourner des trucs trop gourmands. Dans mon cas, je voulais simplement héberger ce site, mon [site de suivi de PEA](https://peasy-money.fr), et quelques futurs projets web ou webapps. Après de nombreuses heures de recherche, j'ai décidé de mon prendre mon VPS chez **Hetzner**.

<img src="/img/hetzner-logo.jpg" alt="Logo de Hetzner" style="display: block; margin: auto; max-width: 70%; height: auto; margin-bottom: 2rem;" />

Hetzner est un hébergeur allemand qui propose tout un tas de solutions, à tous les prix. On peut commencer avec une config très simple — 2 cœurs, 2 Go de RAM et 40 Go de stockage — pour seulement 4,35 € HT par mois. Et si on a besoin de plus, on peut monter jusqu’à 16 cœurs, 32 Go de RAM et 360 Go de stockage pour 54,90 € HT par mois.

Ils proposent aussi des serveurs dédiés, évidemment plus puissants, mais aussi plus chers, puisque les ressources sont entièrement réservées et non partagées, des serveurs GPU et tu peux même louer un espace pour mettre ton propre serveurs dans leurs locaux. Il y a aussi un service de webhosting mais je voulais pouvoir avoir le contrôle et tout faire moi-même. Je trouve ça plus divertissant et puis ça me permet aussi d'apprendre de nouvelles choses.

Ce que je trouve super intéressant chez Hetzner, c’est leur système de facturation à l’usage. Pas d’abonnement fixe : tu paies uniquement en fonction du temps pendant lequel l’instance est active. Tant qu’un serveur est "créé", un tarif horaire s’applique, et tous les 4 du mois, tu reçois ta facture. Tu peux donc très bien utiliser une instance avec beaucoup de ressources pendant deux jours, la détruire, et ne payer que pour ces 48 heures.

C’est vraiment un gros plus. Non seulement les prix sont déjà super compétitifs, mais en plus, il n’y a pas besoin de s’engager pour 12 ou 24 mois pour avoir un bon tarif. On peut tester plein de trucs, profiter de grosses configs pour pas cher, et rester ultra flexible.

Attention cependant : **la facturation continue même si le serveur est éteint**, tant que tu ne l’as pas supprimé. C’est un détail à ne pas oublier, mais ça reste un super moyen d’expérimenter sans se ruiner. Par exemple, l’instance **CPX51** offre 16 cœurs, 32 Go de RAM et 360 Go de stockage pour seulement **0,088 € de l’heure**. Difficile de faire mieux à ce niveau de puissance pour ce prix.

Pour ma part, j'ai décide de partir sur une instance **CPX21** avec 3 VCPU AMD EPYC 7002, 4 GB de ram et 80 GB de stockage. J'ai déployé Ubuntu 24.04 avec docker pour pouvoir séparer mes applications. Docker étant le composant principal de mon architecture, j'ai ajouté portainer, histoire de pouvoir gérer plus facilement mes containers.

Avant de déployer 
