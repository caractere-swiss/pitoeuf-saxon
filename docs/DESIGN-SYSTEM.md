# Design system — variables CSS

> Catalogue des variables CSS qui pilotent toutes les landings saisonnières.
> Définies par défaut dans `assets/css/landing-base.css` et surchargées par
> saison dans `<saison>-<année>/theme.css`.

## Principe

Une seule feuille de style (`landing-base.css`) gère la mise en page,
la grille, les cartes, les badges, le héros, le footer et le rendu print.
Chaque saison change uniquement les **couleurs** via la surcharge des
variables ci-dessous — jamais le layout.

## Palette principale (à surcharger par saison)

| Variable | Rôle | Où elle apparaît |
|---|---|---|
| `--accent-dark` | Ton foncé de la palette | Titres `<h2>` de catégorie, fond `.notice-banner`, fond `footer`, fond `.hero` en mode print |
| `--accent-mid` | Ton moyen | Hover des liens dans le nom de produit, ligne dégradée sous le titre de catégorie |
| `--accent-light` | Ton clair | Fond `.card-top` (cartes sans image) |
| `--accent-bg` | Fond de page | `body`, transition entre le héros et le contenu (`.hero::before`) |
| `--accent-soft` | Fond très clair | `.card-footer` (zone du prix) |
| `--accent-border` | Bordure | Contour des cartes, séparation `.card-footer` |
| `--accent-hi` | Couleur d'accentuation | `<span>` coloré dans le titre du héros, liens dans le footer |

## Gradient du héros

| Variable | Rôle |
|---|---|
| `--hero-gradient` | Fond du `<header class="hero">`. Format : `linear-gradient(155deg, … 0%, … 50%, … 100%)`. Conseil : 3 stops, du plus foncé en haut-gauche au plus accentué en bas-droite. |

## Typographie

| Variable | Rôle |
|---|---|
| `--text-dark` | Corps de texte principal, prix, nom de produit |
| `--text-mid` | Texte secondaire (peu utilisé en l'état) |
| `--text-muted` | `.card-meta` (méta produit grise) — défini dans le tronc commun, rarement override |
| `--text-faint` | `.card-unit` (unité grise) — défini dans le tronc commun, rarement override |

## Composants (rarement override)

| Variable | Valeur par défaut | Rôle |
|---|---|---|
| `--price-color` | `#1a365d` | Couleur du prix (bleu nuit, neutre et lisible). Override possible si conflit visuel avec la palette saison. |
| `--swiss-red` | `#d52b1e` | Fond du badge CH/VS — **à garder constant** (identité suisse) |
| `--frozen-blue` | `#4aa8d8` | Fond du badge « Surgelé » — **à garder constant** (lecture immédiate du froid) |
| `--white` | `#ffffff` | Fond des cartes, texte sur fonds colorés |
| `--radius-card` | `12px` | Rayon de bord des cartes et du notice banner |
| `--radius-pill` | `30px` | Rayon du chip `.hero-validity` |
| `--shadow-card-hover` | `0 12px 30px rgba(0,0,0,.15)` | Ombre au hover des cartes |
| `--font-stack` | `'Helvetica Neue', Helvetica, Arial, sans-serif` | Police de toute la landing. Décision à valider si une saison veut une police custom (impact perf + RGPD Google Fonts). |

## Patron d'override (theme.css)

```css
:root {
    /* Palette saison */
    --accent-dark:    #2e5c0e;
    --accent-mid:     #5a9018;
    --accent-light:   #dff2b4;
    --accent-bg:      #f8fbf0;
    --accent-soft:    #f2f8e4;
    --accent-border:  #c8e296;
    --accent-hi:      #f5c514;

    /* Gradient héros */
    --hero-gradient:  linear-gradient(155deg, #1a4208 0%, #377a10 50%, #c49818 100%);

    /* Typographie */
    --text-dark:      #1e300a;
    --text-mid:       #3a5018;
}
```

## Cohérence visuelle — recommandations

1. **Contraste** : `--accent-dark` doit garder un contraste ≥ 4.5:1 avec le
   blanc (notice banner, footer, titres sur blanc). Vérifier avec un outil
   comme [Contrast Ratio](https://contrast-ratio.com).
2. **Gradient héros** : la 3ᵉ couleur du gradient doit être proche de
   `--accent-hi` pour que le titre coloré reste harmonieux.
3. **Fond de page** (`--accent-bg`) : choisir une teinte très désaturée
   pour ne pas concurrencer les photos produits.
4. **Bordures** (`--accent-border`) : viser une teinte intermédiaire entre
   `--accent-light` et le ton moyen, sinon les cartes paraissent flotter.

## Badges

Les deux badges présents sur les cartes sont définis dans le tronc commun
et **ne changent pas par saison** (lisibilité immédiate prioritaire) :

| Badge | Classe | Position | Texte | Couleur |
|---|---|---|---|---|
| Origine suisse | `.badge-swiss` | top-right | `CH` ou `VS` | rouge `--swiss-red` |
| Surgelé | `.badge-frozen` | top-left | `Surgelé` | bleu `--frozen-blue` |

Les deux ont le même style « pastille » (`border-radius: 4px`, `padding: 2px 5px`,
`font-size: 10px`, `font-weight: 700`).

## Mode print (`@media print`)

Le tronc commun gère le rendu A4 :

- 3 colonnes au lieu de la grille fluide
- Marges A4 : 10 mm vertical, 8 mm horizontal
- Hero compact (background plat `--accent-dark`, sans clip-path)
- Cartes avec `break-inside: avoid` (jamais coupées entre 2 pages)
- Images compactées à 90 px de haut
- Couleurs forcées (`-webkit-print-color-adjust: exact`)

Les saisons n'ont rien à override sauf cas particulier.

## Responsive (`@media (max-width: …)`)

- `≤ 480 px` : grille 2 colonnes, héros sans décoration latérale
- `≤ 320 px` : grille 1 colonne

Pas de breakpoint tablette/desktop dédié — la grille `auto-fill, minmax(200px, 1fr)`
gère naturellement les tailles intermédiaires.
