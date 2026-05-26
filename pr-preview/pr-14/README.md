# Pitoeuf Saxon — Landings saisonnières

Série de **feuillets promotionnels web** pour Pitoeuf SA (grossiste en
comestibles, Saxon / Valais), destinés aux clients professionnels
(restaurateurs, bouchers, traiteurs).

Une landing par saison ou thème, hébergées en GitHub Pages, construites
sans framework ni build (HTML/CSS pur).

## Feuillets en ligne

| Saison | URL | Statut |
|---|---|---|
| Été 2026 | [caractere-swiss.github.io/pitoeuf-saxon/ete-2026/](https://caractere-swiss.github.io/pitoeuf-saxon/ete-2026/) | en cours |
| Pâques 2026 | [caractere-swiss.github.io/pitoeuf-saxon/paques-2026/](https://caractere-swiss.github.io/pitoeuf-saxon/paques-2026/) | publié |

Portail (toutes les saisons) :
[caractere-swiss.github.io/pitoeuf-saxon/](https://caractere-swiss.github.io/pitoeuf-saxon/)

## Architecture

```
/
├── assets/css/landing-base.css   Tronc commun de mise en page
├── design-system/                Composants partagés (vignette produit, badges)
├── images/                       Assets partagés (logo, favicon, fond bois)
├── <saison>-<année>/             Une landing autonome par saison
└── .github/workflows/pages.yml   Déploiement GitHub Pages
```

## Documentation

- **[CLAUDE.md](./CLAUDE.md)** — Contexte projet, conventions, méthodologie
  pour créer une nouvelle landing, setup déploiement
- **[design-system/README.md](./design-system/README.md)** — Composants
  visuels partagés (à utiliser dans tous les projets Pitoeuf)
- **[MASTER.md](./MASTER.md)** — Suivi global du projet

## Stack

HTML / CSS pur, zéro JS, zéro build. Déployé en GitHub Pages.

## Réalisation

[Caractère Swiss](https://caractere-swiss.ch) pour [Pitoeuf SA](https://pitoeuf.ch).
