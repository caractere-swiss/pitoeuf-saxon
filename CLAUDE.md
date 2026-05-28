# Pitoeuf Saxon — Contexte projet

## Client
**Pitoeuf SA** — Grossiste en comestibles, basé à Saxon (Valais, Suisse).
Site web : pitoeuf.ch

## Projet
Série de **landings pages promotionnelles saisonnières** destinées aux clients
professionnels (restaurateurs, bouchers, traiteurs). Une landing par saison /
thème (Pâques, Été, Hiver, Volaille, etc.) — chacune réutilise un tronc commun
de mise en page et n'adapte que sa palette + son catalogue produits.

---

## ⚠️ AVANT DE CRÉER OU MODIFIER UN COMPOSANT VISUEL — LIRE `design-system/README.md`

Le dossier `design-system/` est la **source de vérité visuelle** pour tous
les projets Pitoeuf (ce dépôt + tous les futurs : newsletters, microsites,
intranet, autres landings…). Les vignettes produit, badges, bandeaux promo
et couleurs de marque y sont définis **une seule fois**.

**Règles non négociables :**

1. **Avant de créer un composant** → vérifier qu'il n'existe pas déjà dans
   `design-system/components/`. Si oui, l'utiliser.
2. **Avant de modifier un composant existant** → faire la modif dans
   `design-system/components/`, pas dans la page qui l'utilise. Tous les
   projets bénéficieront ainsi du changement.
3. **Avant d'inventer un nouveau visuel partageable** → proposer son ajout
   au design system pour qu'il soit réutilisable.

**Couleurs marque immuables** (jamais override par un thème saisonnier) :
- Bleu Surgelé : `#4aa8d8`
- Rouge CH/VS : `#d52b1e`
- Rouge promo (bandeau + remise) : `#f95600`
- Beige bandeau prix : `#fff6e3`

Le thème saisonnier (vert forêt été, vert printemps Pâques, etc.) ne pilote
que les éléments décoratifs (héros, titres catégorie, fonds) — **jamais** la
vignette produit elle-même.

---

## Architecture

```
/
├── index.html                      Portail listant les feuillets
├── MASTER.md                       Suivi global du projet
├── CLAUDE.md                       Ce fichier
├── JOURNAL.md                      Journal transverse des décisions
│                                   (préférences client, pistes rejetées,
│                                   TODO différés) — À LIRE avant toute
│                                   nouvelle session pour reprendre le fil
├── assets/
│   └── css/
│       └── landing-base.css        Tronc commun (layout, grille, héros,
│                                   footer) — variables CSS thématisables
├── images/
│   ├── logo-pitoeuf-blanc.png      Assets partagés (logo, favicon, bois…)
│   └── …
├── design-system/                  ★ LIB partagée Pitoeuf (cross-projet)
│   ├── README.md                   Doc d'usage + tokens + conventions
│   └── components/
│       ├── product-card.css        Vignette produit standalone
│       └── product-card.html       Exemples de markup à copier
├── paques-2026/                    Une saison = un dossier autonome
│   ├── index.html
│   ├── theme.css                   Surcharge variables CSS (palette saison)
│   ├── images/
│   └── JOURNAL.md
├── ete-2026/                       (en cours, mockup quasi-final)
├── v3.html                         ★ Newsletter Mailchimp (livrable client)
│                                   — NE PAS SUPPRIMER (cf. note ci-dessous)
└── …                               (hiver-2026, volaille-2027, …)
```

> ⚠️ **`v3.html` (newsletter) n'est PAS du désordre à nettoyer.** C'est le
> livrable newsletter promotionnelle Pitoeuf (HTML email Mailchimp,
> table-based, CSS inline). Il a déjà été supprimé par erreur lors d'un
> « nettoyage racine » (commit #11) puis restauré. **Toute future session
> doit le conserver.** La newsletter et les landings cohabitent dans ce repo
> et partagent la même charte (design-system).

## Méthodologie : créer une nouvelle landing saisonnière

1. Créer le dossier `<saison>-<année>/`
2. Copier `theme.css` d'une saison existante, ajuster la palette (variables
   `--accent-*`, `--hero-gradient`, etc. — voir `assets/css/landing-base.css`)
3. Créer `index.html` avec dans le `<head>` :
   ```html
   <link rel="stylesheet" href="../assets/css/landing-base.css" />
   <link rel="stylesheet" href="../design-system/components/product-card.css" />
   <link rel="stylesheet" href="theme.css" />
   ```
4. Pour chaque produit, utiliser le markup `<article class="product-card">` —
   voir `design-system/components/product-card.html` pour l'exemple complet
5. Placer les photos produits dans `<saison>-<année>/images/` (JPG 416×312, q85)
6. Ajouter une tuile dans `/index.html` (portail)
7. URL finale : `https://caractere-swiss.github.io/pitoeuf-saxon/<saison>-<année>/`

## Stack
- HTML / CSS pur (pas de framework, pas de JS, pas de build)
- Variables CSS pour le thème : un seul tronc commun, surcharge par saison
- Hébergement : GitHub Pages depuis la branche `main`

## Conventions
- **Images produits** : toujours hébergées localement (pitoeuf.ch bloque le
  hotlinking). JPG 416×312 q85 EXIF stripped. Nommage
  `<code-article>-<slug-produit>.jpg`. Photos dans `<saison>/images/`,
  assets partagés dans `/images/`.
- **Emojis Unicode** : à éviter dans le HTML — préférer SVG inline (pour les
  icônes) ou texte simple.
- **Liens produits** : pointer vers la fiche pitoeuf.ch correspondante quand
  elle existe (`<a href="https://pitoeuf.ch/produit/..." target="_blank">`).
- **Icônes** : SVG inline, jamais Font Awesome ou autre lib externe.
- **Branches** : `claude/<scope>-XXXX`, commits en français format court
  (`<verbe>: <quoi>`), PR avec titre + description structurée.

## Déploiement (GitHub Pages)

**Source : `GitHub Actions`** (et NON pas `Deploy from a branch`) — réglé dans
Settings → Pages. Le déploiement est piloté par `.github/workflows/pages.yml`
qui se déclenche à chaque push sur `main`.

⚠️ **Ne pas revenir au mode "Deploy from a branch"** : le runner automatique
de GitHub plante de façon récurrente avec l'erreur
`Failed to download archive 'actions/upload-pages-artifact'` qui semble
liée à la résolution de version d'action côté CDN GitHub. Le workflow
explicite contourne le bug en épinglant les versions (`@v4`, `@v5`, `@v3`).

**`.nojekyll` à la racine** : indispensable, désactive le pré-traitement
Jekyll qui peut ignorer/casser des fichiers (dossiers `_template/`, etc.).

**Si un déploiement échoue à nouveau** : vérifier l'onglet Actions, puis
"Re-run all jobs". Si le bug persiste, mettre à jour les versions des
actions dans `pages.yml` (actions/checkout, configure-pages,
upload-pages-artifact, deploy-pages) vers les dernières majeures stables.

## Notes
- `landing-paques-2026.html` (racine) est conservé en redirection vers
  `paques-2026/` pour préserver les URLs déjà diffusées.
- Pâques 2026 utilise encore l'ancienne structure de carte (`.card` /
  `landing-base.css`). À migrer sur `product-card` du design system quand
  on fera la prochaine itération de cette landing.

---

## Compact instructions

Quand tu compresses le contexte (`/compact`), préserve en priorité :
1. **Décisions visuelles validées** (palette saison, comportements corrigés)
2. **Couleurs marque immuables** (`#f95600`, `#d52b1e`, `#fff6e3`, etc.)
3. **État des PRs ouvertes** et leur branche associée
4. **TODOs actifs** (photos manquantes, prix réels, badges conditionnement)
5. **Règles non négociables** : design system source de vérité, zéro hotlink
   images pitoeuf.ch, zéro framework JS, zéro build
