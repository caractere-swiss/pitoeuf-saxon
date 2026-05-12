# Pitoeuf Saxon — Contexte projet

## Client
**Pitoeuf SA** — Grossiste en comestibles, basé à Saxon (Valais, Suisse).
Site web : pitoeuf.ch

## Projet
Série de **landings pages promotionnelles saisonnières** destinées aux clients
professionnels (restaurateurs, bouchers, traiteurs). Une landing par saison /
thème (Pâques, Été, Hiver, Volaille, etc.) — chacune réutilise un tronc commun
de mise en page et n'adapte que sa palette + son catalogue produits.

## Architecture

```
/
├── index.html                      Portail listant les feuillets disponibles
├── assets/
│   └── css/
│       └── landing-base.css        Tronc commun (layout, grille, cards, hero,
│                                   footer). Définit toutes les variables CSS.
├── images/
│   ├── logo-pitoeuf-blanc.png      Assets partagés entre toutes les landings
│   └── …
├── paques-2026/                    Une saison = un dossier autonome
│   ├── index.html                  Contenu (utilise classes du tronc commun)
│   ├── theme.css                   Surcharge des variables CSS (palette saison)
│   └── images/                     Photos produits de la saison
├── ete-2026/                       (en cours)
└── …                               (hiver-2026, volaille-2027, …)
```

## Méthodologie : créer une nouvelle landing

1. Créer le dossier `<saison>-<année>/`
2. Copier `theme.css` d'une saison existante, ajuster la palette via les
   variables CSS (voir `assets/css/landing-base.css` pour la liste complète :
   `--accent-dark`, `--accent-mid`, `--accent-light`, `--accent-bg`,
   `--accent-soft`, `--accent-border`, `--accent-hi`, `--hero-gradient`, etc.)
3. Créer `index.html` (chemin CSS : `../assets/css/landing-base.css` puis
   `theme.css`)
4. Placer les photos produits dans `<saison>-<année>/images/`
5. Ajouter une tuile dans `/index.html` (portail)
6. URL finale : `https://caractere-swiss.github.io/pitoeuf-saxon/<saison>-<année>/`

## Stack
- HTML / CSS pur (pas de framework, pas de JS, pas de build)
- Variables CSS pour le thème : un seul tronc commun, surcharge par saison
- Hébergement : GitHub Pages depuis la branche `main`

## Conventions
- **Images** : toujours hébergées localement (le hotlinking pitoeuf.ch est
  bloqué). Photos produits dans `<saison>/images/`, assets partagés (logo) dans
  `/images/`.
- **Emojis Unicode** : à éviter dans le HTML — préférer texte simple ou entités
  HTML.
- **Liens produits** : pointer vers la fiche pitoeuf.ch correspondante quand
  elle existe (`<a href="https://pitoeuf.ch/produit/..." target="_blank">`).
- **Badges** : `badge-swiss` (rouge, top-right) pour CH/VS, `badge-frozen`
  (bleu, top-left) pour les surgelés.

## Notes
- `landing-paques-2026.html` (racine) est conservé en redirection vers
  `paques-2026/` pour préserver les URLs déjà diffusées.
- Les anciens brouillons (`old.html`, `v1.html`, `v2.html`, `v3.html`) sont
  des versions antérieures conservées pour référence.
