---
title: 'Mon homelab'
description: 'Voici mon architecture maison'
pubDate: 'Jul 8 2025'
heroImage: '../../assets/homelab.jpg'
tags: ['Self-hosted', 'Linux', 'Docker']
---

## Mon homelab

Pour que ce site soit accessible, il fallait que je l’héberge quelque part, pour le diffuser sur Internet.  
Passionné par le hardware, mon premier réflexe a été de chercher un vieux PC — un Dell Optiplex ou un HP Prodesk — sur Leboncoin, avec l’idée de le transformer en serveur maison. L’idée me plaisait bien : bricoler un peu, recycler du matos, et héberger moi-même mes projets.

Mais je voulais trouver une machine dans ma région, histoire d’éviter la livraison (et les risques de casse). Malheureusement, il n’y avait pas grand-chose d’intéressant à proximité ou alors la configuration ne correspondait pas à mes besoins. J’ai donc fini par me rabattre sur une autre solution : **les VPS**.

Il existe plein d’hébergeurs qui proposent des VPS à des prix très abordables, tant qu’on ne fait pas tourner des trucs trop gourmands. Dans mon cas, je voulais simplement héberger ce site, mon [site de suivi de PEA](https://peasy-money.fr), et quelques futurs projets web ou webapps. Après de nombreuses heures de recherche, j'ai décidé de mon prendre mon VPS chez **Hetzner**.

#### Hetzner

Hetzner est un hébergeur allemand qui propose tout un tas de solutions, à tous les prix. On peut commencer avec une config très simple — 2 cœurs, 2 Go de RAM et 40 Go de stockage — pour seulement 4,35 € HT par mois. Et si on a besoin de plus, on peut monter jusqu’à 16 cœurs, 32 Go de RAM et 360 Go de stockage pour 54,90 € HT par mois.

<img src="/img/hetzner-logo.jpg" alt="Logo de Hetzner" style="display: block; margin: auto; max-width: 70%; height: auto; margin-bottom: 2rem;" />

Ils proposent aussi des serveurs dédiés, évidemment plus puissants, mais aussi plus chers, puisque les ressources sont entièrement réservées et non partagées, des serveurs GPU et tu peux même louer un espace pour mettre ton propre serveurs dans leurs locaux. Il y a aussi un service de webhosting mais je voulais pouvoir avoir le contrôle et tout faire moi-même. Je trouve ça plus divertissant et puis ça me permet aussi d'apprendre de nouvelles choses.

Ce que je trouve super intéressant chez Hetzner, c’est leur système de facturation à l’usage. Pas d’abonnement fixe : tu paies uniquement en fonction du temps pendant lequel l’instance est active. Tant qu’un serveur est "créé", un tarif horaire s’applique, et tous les 4 du mois, tu reçois ta facture. Tu peux donc très bien utiliser une instance avec beaucoup de ressources pendant deux jours, la détruire, et ne payer que pour ces 48 heures.

C’est vraiment un gros plus. Non seulement les prix sont déjà super compétitifs, mais en plus, il n’y a pas besoin de s’engager pour 12 ou 24 mois pour avoir un bon tarif. On peut tester plein de trucs, profiter de grosses configs pour pas cher, et rester ultra flexible.

Attention cependant : **la facturation continue même si le serveur est éteint**, tant que tu ne l’as pas supprimé. C’est un détail à ne pas oublier, mais ça reste un super moyen d’expérimenter sans se ruiner. Par exemple, l’instance **CPX51** offre 16 cœurs, 32 Go de RAM et 360 Go de stockage pour seulement **0,088 € de l’heure**. Difficile de faire mieux à ce niveau de puissance pour ce prix.

Pour ma part, j'ai décide de partir sur une instance **CPX21** avec 3 VCPU AMD EPYC 7002, 4 GB de ram et 80 GB de stockage. J'ai déployé Ubuntu 24.04 avec docker pour pouvoir séparer mes applications. Docker étant le composant principal de mon architecture, j'ai ajouté portainer, histoire de pouvoir gérer plus facilement mes containers.

#### OVH 

Pour pouvoir héberger mes différents sites, il me faut des noms de domaines. Je voulais d'abord deux noms de domaine [mviolette.fr](mviolette.fr) et [peasy-money.fr](peasy-money.fr). j'ai pris ces noms sur OVH car la gestion est simple, le prix est abordable et je pouvais acheter plusieurs noms de domaine en même temps. Ainsi, pour 13€ j'ai pu obtenir deux noms de domaines avec 5 sous-domaines chacun et une adresse mail gratuite par domaine. Dans le cas de Peasy Money, l'adresse mail va être très utile pour notamment envoyer les emails de confirmation d'inscription ou les emails d'alertes. Les sous-domaines sont aussi très utiles car cela me permet de créer différents sites notamment pour Peasy Money avec le site principal de l'application et un site de présentation de l'application.

## Architecture du serveur

Voici maintenant l'architecture de mon serveur : 

<img src="/img/architecture.png" alt="Schema de l'architecture du serveur" style="display: block; margin: auto; max-width: 70%; height: auto; margin-bottom: 2rem;" />

#### Caddy 

Pour permettre l'accès aux différents services via leurs noms de domaine respectifs, il est nécessaire de mettre en place un serveur web faisant office de reverse proxy. Le rôle de ce reverse proxy est de rediriger le trafic entrant vers le service ou le conteneur Docker correspondant, en fonction du nom de domaine utilisé.
Par exemple, dans mon cas, je souhaite que le domaine mviolette.fr redirige vers mon conteneur Astro, qui héberge mon site web.

L'utilisation d'un reverse proxy offre une grande flexibilité :
- Il permet de centraliser la gestion du trafic via un seul point d'entrée.
- Il renforce la sécurité en exposant uniquement le serveur web au public, tandis que les autres services restent isolés en interne.
- Il facilite le contrôle du trafic entrant et la mise en place de certificats SSL.

Lorsque l'on parle de serveur web, les noms qui reviennent le plus souvent sont : NGINX, Apache HTTP Server et Traefik. Dans mon cas, j'ai décidé d'utiliser Caddy car il est très simple à mettre en place et gère automatiquement les certificats HTTPS via Let's Encrypt. il est compatible avec Docker et est très léger. Cela me permet d'économiser des ressources tout en bénéficiant d'un outil puissant et simple à mettre en place. Pour configurer Caddy, il faut créer un fichier de configuration Caddyfile, que l'on peut modifier à souhait car il suffit juste de redémarrer le conteneur pour que la configuration soit prise en compte. 
Voici des exemples de configuration de Caddy :

```
mviolette.fr {
    reverse_proxy portfolio:3000
}
```
Ici je viens indiquer à Caddy que tous les traffic commençant par mviolette.fr doivent être rediriger vers le conteneur portfolio sur le port 3000.
```
mviolette.fr {
    root * /srv
    file_server
}
```
Plutôt que de rediriger vers un conteneur, on peut également servir des fichiers statiques directement avec Caddy. En montant un volume contenant les fichiers statiques (comme un site HTML) dans le conteneur Caddy via Docker Compose, celui-ci pourra les exposer automatiquement à l'adresse définie par le nom de domaine. Ainsi, au démarrage du conteneur, Caddy servira le site statique depuis le répertoire /srv, sans avoir besoin d’un reverse proxy vers un autre service. Cela me permet notamment de déployer un site simple temporaire comme je l'ai fait pour [peasy-money.fr](https://peasy-money.fr).
 ```
mviolette.fr {
    root * /srv
    file_server
    basic_auth {
        admin JDJhJDEyJHZzZ0ZqZ2Z1Z2Z1Z2Z1Z2Z1Z2Z1Z2Z1Z2Z1Z2Z1Z2Z1Z2Z1Z2Z1Z2Z1Z2Z1Z2Z1Zg==
    }
}
```
Caddy dispose de tellement de paramètres et de configuration possible que tous les énoncés me prendrais des jours. Ici je veux vous montrer qu'il est possible d'ajouter une sécurité supplémentaire avec une authentification basic_auth.

Maintenant que nous avons vu comment rediriger le trafic vers les différents services et leur conteneur, parlons un peu plus de ces fameux services.

#### Portfolio ([mviolette.fr](https://mviolette.fr))

Le portfolio repose sur deux conteneurs : un conteneur Astro, chargé de builder et déployer le site, et un conteneur Watchtower, que je détaillerai un peu plus loin. Comme vous pouvez le voir, j’ai choisi de faire de la section “projets” une sorte de blog, où je publie un nouveau post à chaque fois que j’ai un projet à présenter. Le site est donc amené à évoluer régulièrement. Pour éviter de devoir reconstruire manuellement le conteneur à chaque mise à jour, j’ai mis en place un script GitHub Actions. À chaque push sur la branche master, ce script construit une nouvelle image Docker et la publie sur Docker Hub. C’est là qu’intervient Watchtower : il surveille le dépôt Docker Hub et, dès qu’une nouvelle version de l’image est disponible, il la télécharge et redémarre automatiquement le conteneur avec cette nouvelle version. Grâce à ce système, le projet bénéficie d’une CI/CD complète : le site se met à jour automatiquement à chaque push de code. 

Pour en savoir un peu plus sur mon portfolio et comment je l'ai construit, vous pouvez aller consulter le [post](/blog/portfolio) que j'ai fait dessus.
 

#### Peasy Money ([peasy-money.fr](https://peasy-money.fr))

Je n'ai pas encore mis en place l'architecture de Peasy Money car le site n'est pas encore prêt. En attendant, j'ai mis en place une simple page HTML, servi par Caddy, qui indique que le site est en cours de construction. Cependant, j'ai déjà une bonne idéee de ce à quoi va ressembler son architecture, elle sera très similaire à celle du portfolio pour la CI/CD. Un conteneur Watchtower va s'occuper de mettre à jour les conteneurs Next.js pour le frontend et le conteneur FastAPI pour le backend. Il y aura aussi un conteneur PostgreSQL pour stocker la base de données de l'application.

Pour en savoir un peu plus sur mon portfolio, vous pouvez aller consulter le [post](/blog/peasy-money) que j'ai fait dessus. 

#### Umami Analytics

Afin d'analyser mon trafic et de voir si mon site est visité, j'ai mis en place un conteneur Umami. Léger, open-source et respectueux de la vie privée, Umami permet de suivre les visites, les pages vues, les sources de trafic et d'autres métriques essentielles, sans recourir à des solutions intrusives comme Google Analytics. Il est configuré pour se connecter à une base de données PostgreSQL externe et expose une interface d’administration simple et efficace. Grâce à ce conteneur, je peux visualiser en temps réel les performances de mon portfolio, tout en garantissant la confidentialité des visiteurs.

## Conclusion

Avec cette architecture, j’ai réussi à mettre en place un environnement modulaire, évolutif et automatisé, parfaitement adapté à mes besoins personnels et professionnels. Chaque service est isolé dans son propre conteneur, ce qui facilite la maintenance, les mises à jour et l’ajout de nouvelles fonctionnalités.

Grâce à Docker, Portainer, Caddy, Watchtower et Umami, je dispose d’un écosystème complet : déploiement automatisé, gestion centralisée, sécurité renforcée, et suivi des performances en temps réel. Le tout hébergé sur une instance flexible et économique, sans engagement, ce qui me permet de tester, ajuster et faire évoluer mes projets librement.

Ce setup me permet non seulement de gagner du temps, mais aussi de mieux comprendre et maîtriser les outils modernes du DevOps. Et surtout, il me donne la liberté de créer, expérimenter et apprendre en continu. Pour le moment, mon serveur ne dispose pas de milliers de services mais au vu du plaisir que je prends à découvrir et ajouter différents services, l'architecture risque de beaucoup changer et de s'enrichir.