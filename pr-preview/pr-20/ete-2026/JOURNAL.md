# Journal — Feuillet Été 2026

> Journal de suivi spécifique au feuillet Été 2026.
> Pour la vue d'ensemble du projet, voir `MASTER.md` à la racine.

## État actuel

- **Version** : draft (basé sur le catalogue 2025)
- **En ligne** : https://caractere-swiss.github.io/pitoeuf-saxon/ete-2026/
- **Validité affichée** : « Valable jusqu'au 31 août 2026 »
- **Catalogue 2026 final** : ⏳ en attente
- **Photos** : 18 / 21 récupérées depuis pitoeuf.ch

## Décisions

- **Palette** : « Soleil & herbes » — or doré (`#f5c542`) + olive (`#8ba62a`) + ivoire (`#fbf8e7`)
- **Structure** : 7 catégories — Bœuf, Agneau, Veau suisse, Porc & Cheval, Volaille & Canard, Poisson & Fruits de mer, Sauces & Huiles
- **Accroche** : « Notre sélection pour un bel été » (reprise du PDF 2025)
- **Titre hero** : « Feuillet Estival 2026 » (« Estival » coloré or doré)
- **Eyebrow** : « Saveurs de saison »

## Points en suspens

### Catalogue
- [ ] **Recevoir le catalogue 2026 final** (prix & sélection définitive) — actuellement reprise du 2025
- [ ] Ajuster prix / produits / dates de validité une fois le 2026 reçu

### Photos manquantes (3) — cf. `IMAGES-TODO.md`
- [ ] `g6358-cotelette-agneau-bio-vs` — page pitoeuf.ch 404 → vérifier avec Pitoeuf
- [ ] `g3900-ribs-porc` — pas de fiche e-shop → confirmer si produit catalogué
- [ ] `g3760-brochette-yakitori-marinee` — seule la version « cuite » existe sur le site → décider si on garde ou remplace

### Photos approximatives (5) à valider
- [ ] `g38151-entrecote-boeuf` — photo de l'entrecôte parisienne utilisée
- [ ] `g6336-steak-gigot-agneau` — photo gigot entier au lieu de steak de gigot
- [ ] `g1026-magret-canard` — photo filet de canard utilisée
- [ ] `m1014-perche-mclean` — photo McLean 30/40 (40/50 indisponible)
- [ ] `m102-perche-loe-valais` — photo Loë 20-30gr (30-40 page 404)

### Améliorations possibles
- [ ] Créer une vraie bannière Open Graph 1200×630 (actuellement = logo seul, peu visible sur previews)
- [ ] Vérifier les écarts entre prix CHF affichés (au kg vs au carton, à la bte, au bibox) — homogénéité

## Historique

| Date | Action |
|---|---|
| 2026-05-12 | Création du tronc commun (`assets/css/landing-base.css`) + variables CSS thématisables |
| 2026-05-12 | Migration Pâques 2026 vers `paques-2026/` (nouvelle architecture) |
| 2026-05-12 | Création de la landing Été 2026 (draft basé sur PDF 2025) — 21 produits, 7 catégories, placeholders SVG |
| 2026-05-12 | Récupération de 18/21 photos depuis pitoeuf.ch (via Cowork) — JPG 416×312 |
| 2026-05-12 | Merge PR #3 vers `main` — landing publiée |

## Liens utiles

- PR de création : https://github.com/caractere-swiss/pitoeuf-saxon/pull/3 (mergée)
- Manifeste images : `./IMAGES.md`
- TODO images : `./IMAGES-TODO.md`
- Tronc commun CSS : `../assets/css/landing-base.css`
- Thème : `./theme.css`
