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
├── MASTER.md                       Suivi global du projet
├── CLAUDE.md                       Ce fichier (contexte + conventions)
├── assets/
│   └── css/
│       └── landing-base.css        Tronc commun (layout, grille, cards, hero,
│                                   footer, print, responsive). Définit
│                                   toutes les variables CSS thématisables.
├── images/
│   ├── logo-pitoeuf-blanc.png      Assets partagés entre toutes les landings
│   └── favicon.svg
├── docs/
│   ├── DESIGN-SYSTEM.md            Catalogue des variables CSS + rôle
│   └── IMAGES.md                   Procédure photos (sourcing, dimensions,
│                                   normalisation ImageMagick, nommage)
├── _template/                      Squelette pour démarrer une saison en 5 min
│   ├── README.md                   Procédure pas-à-pas
│   ├── index.html                  Page type avec `{{placeholders}}`
│   ├── theme.css                   Palette neutre commentée
│   ├── JOURNAL.md
│   ├── IMAGES.md
│   └── IMAGES-TODO.md
├── paques-2026/                    Une saison = un dossier autonome
│   ├── index.html                  Contenu (utilise classes du tronc commun)
│   ├── theme.css                   Surcharge des variables CSS (palette saison)
│   ├── images/                     Photos produits de la saison
│   └── JOURNAL.md                  Suivi spécifique
├── ete-2026/
└── …                               (hiver-2026, volaille-2027, …)
```

## Méthodologie : créer une nouvelle landing

**Suivre `_template/README.md`** — résumé :

1. `cp -r _template/ <saison>-<année>/` puis renommer le dossier
2. Substituer les `{{placeholders}}` dans tous les fichiers
3. Choisir la palette dans `theme.css` (voir `docs/DESIGN-SYSTEM.md` pour le
   rôle de chaque variable)
4. Remplir les produits (dupliquer les blocs `<div class="card">`)
5. Récupérer les photos (voir `docs/IMAGES.md`)
6. Ajouter une tuile dans le portail racine `/index.html`
7. Mettre à jour `MASTER.md` (table des feuillets) et créer/peupler `JOURNAL.md`
8. Suivre la checklist publication dans `_template/README.md`

URL finale : `https://caractere-swiss.github.io/pitoeuf-saxon/<saison>-<année>/`

## Stack
- HTML / CSS pur — **pas de framework, pas de JS, pas de build**
- Variables CSS pour le thème : un seul tronc commun, surcharge par saison
- Hébergement : GitHub Pages depuis la branche `main`

## Conventions

### Images
- Toujours **hébergées localement** (le hotlinking pitoeuf.ch est bloqué)
- Photos produits dans `<saison>/images/`, assets partagés dans `/images/`
- Format : **JPG 416×312 px, qualité 85, EXIF stripped**
- Nommage : `<code-article-minuscules-sans-points>-<slug-produit>.jpg`
- Procédure complète : `docs/IMAGES.md`

### HTML
- **Pas d'emojis Unicode** — préférer texte simple ou entités HTML
- **Liens produits** : pointer vers la fiche pitoeuf.ch quand elle existe
  (`<a href="https://pitoeuf.ch/produit/..." target="_blank">`)
- **Open Graph** + favicon SVG sur chaque page

### Badges (pastilles identiques sur toutes les saisons)
- `badge-swiss` : rouge, position top-right, texte `CH` ou `VS`
- `badge-frozen` : bleu, position top-left, texte `Surgelé`
- Style « pastille » (10 px, padding 2/5, border-radius 4) — défini une
  seule fois dans `landing-base.css`, ne pas override en theme.css

### Branches & commits
- Branche de travail : `claude/<scope>-XXXX`
- Commits : 1 sujet par commit, message en français, format court
  (`<verbe>: <quoi>` — ex : `design: améliore palette`, `doc: ajoute …`)
- PR : titre court + description structurée (Summary, Test plan)
- **Aucun push direct sur `main`** — toujours via PR mergée

## Notes
- `landing-paques-2026.html` (racine) est conservé en redirection vers
  `paques-2026/` pour préserver les URLs déjà diffusées
- Les anciens brouillons (`old.html`, `v1.html`, `v2.html`, `v3.html`) sont
  des versions antérieures conservées pour référence
