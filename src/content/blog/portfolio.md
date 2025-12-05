---
title: 'Mon portfolio'
description: 'Petit portfolio fait avec Astro'
pubDate: 'Jul 1 2025'
heroImage: '../../assets/portfolio.jpg'
tags: ['Astro', 'Web', 'Self-hosted']
---

En tant qu'ingénieur en informatique, avoir un site portfolio personnel est un gros plus. Cela me permet de développer ou de renforcer mes compétences mais aussi de les montrer aux recruteurs et aux potentiels collaborateurs. Au-delà d'un simple site développé en JavaScript / Markdown, il s'agit d'un ensemble : choix d'outils, pipeline d'intégration continue, build optimisé et stratégie de déploiement adaptée à l'hébergement (self‑hosted ou plateforme cloud).

## Choix du framework

J'ai choisi Astro pour ce projet pour plusieurs raisons : rendu statique par défaut (performances et SEO), possibilité d'intégrer des composants UI isolés (React/Vue/Svelte) sans surcharger le bundle client, et un écosystème simple pour le contenu Markdown/MDX. Concrètement :

- Rendu côté build (SSG) pour les pages marketing et le blog — faible coût CPU côté serveur.
- Hydratation partielle quand nécessaire (islands architecture) pour garder le JS côté client minimal.
- Intégration transparente d'outils modernes (Tailwind, image optimization, adapters pour Netlify/Vercel).

Astro permet aussi d'exporter un site entièrement statique ou de l'adapter à une cible server‑side (SSR) si besoin ultérieur.

## Pipeline CI/CD

Le pipeline doit valider le code et produire un artefact reproductible (build statique, image Docker ou archive). Voici une pipeline type (GitHub Actions) qui couvre lint, tests, build et création d'une image Docker :

```yaml
name: CI
on: [push, pull_request]
jobs:
	build:
		runs-on: ubuntu-latest
		steps:
			- uses: actions/checkout@v4
			- name: Setup Node
				uses: actions/setup-node@v4
				with:
					node-version: 20
			- name: Install
				run: npm ci
			- name: Lint
				run: npm run lint
			- name: Test
				run: npm test
			- name: Build
				run: npm run build
			- name: Build Docker image
				if: github.event_name != 'pull_request'
				run: |
					docker build -t ghcr.io/${{ github.repository }}:latest .
					echo "Image built"
```

Bonnes pratiques à appliquer :

- Cacher les dépendances (actions cache) pour accélérer les builds.
- Séparer `build` et `release` : le job `build` produit un artefact ; `release` publie l'artefact après approbation.
- Gérer les secrets via le gestionnaire de la CI (SSH key, tokens) et limiter les permissions.

## Déploiement

Le déploiement dépend de votre cible. Pour un hébergement self‑hosted sur un serveur Docker, la stratégie que j'utilise : construire une image reproducible, la pousser dans un registre privé (ex. GitHub Container Registry), puis déployer via `docker-compose` ou `traefik` sur le serveur.

Exemple simplifié : Dockerfile pour servir le build statique avec `nginx` :

```dockerfile
FROM node:20 AS build
WORKDIR /app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

Déploiement minimal via SSH (CI) :

- CI construit l'image et la publie au registre.
- Sur le serveur, `docker-compose pull && docker-compose up -d --no-deps --build` pour mettre à jour le service.

Alternatives :

- Déploiement sur une plateforme (Vercel/Netlify) pour simplicité (auto‑deploy sur push).
- Utiliser un runner self‑hosted si vous souhaitez garder tout le pipeline dans votre infra.

## Optimisations et bonnes pratiques techniques

- Cache navigateur & CDNs pour assets statiques (images, fonts). Utiliser `Cache-Control` agressif pour `/assets` et invalidation lors des releases.
- Images : générer des tailles multiples et servir via `srcset` ou un service d'optimisation d'images.
- Monitoring des performances (Lighthouse CI) dans le pipeline pour garder un seuil de qualité.
- Sécurité : headers HTTP (HSTS, CSP), mise à jour régulière des dépendances, scan SCA (dependabot/ou équivalent).
- Infrastructure as Code : garder vos playbooks Ansible / manifests Terraform versionnés avec le repo si vous gérez l'hébergement.

## Retour d'expérience

Ce portfolio m'a permis d'expérimenter l'équilibre entre minimalisme frontend (Astro) et robustesse opérationnelle (CI reproducible, images Docker). Le principal challenge a été d'optimiser la configuration de build pour obtenir des temps de déploiement rapides tout en gardant la possibilité d'ajouter des fonctionnalités interactives.

Vous pouvez trouver le repo github du projet [ici](https://github.com/Fmaxv60/portfolio)
