# Journal des décisions — Pitoeuf Saxon

Journal **transverse** de toutes les landings. Les entrées sont datées,
classées par thème, et capturent le **pourquoi** des choix (le code dit
déjà le *quoi*).

Une nouvelle entrée à chaque fois qu'on tranche un choix non évident,
qu'un client exprime une préférence, ou qu'on écarte une piste — pour
ne pas re-proposer plus tard ce qui a déjà été refusé.

---

## Conventions du journal

- **Format** : `### YYYY-MM-DD — <titre court>`
- **Sections** : Design system / Infra & déploiement / Landing `<saison>`
- **À journaliser** :
  - Préférences explicites du client (« Olivier préfère X à Y »)
  - Pistes essayées et rejetées (avec le pourquoi du rejet)
  - TODO différés (avec la condition de déblocage)
  - Choix esthétiques tranchés après hésitation
- **À ne PAS journaliser** : les modifs triviales que le code rend
  évidentes (renommage, fix typo, ajustement padding).

---

## Design system (cross-projet)

### 2026-05-26 — Couleurs marque immuables

Définies dans `CLAUDE.md` comme **non modifiables par un thème saisonnier** :
- Bleu Surgelé : `#4aa8d8` (en réalité icône SVG `#00c0f9`)
- Vert Frais : `#97db16`
- Jaune Sec : `#f5d41c`
- Rouge CH/VS : `#d52b1e`
- Rouge promo (bandeau + cercle remise) : `#f95600` *(corrigé depuis
  `#e8821a` qui était trop orange)*
- Beige bandeau prix : `#fff6e3`

Le thème saisonnier (`theme.css`) ne touche **jamais** la vignette
produit. Il ne pilote que les éléments décoratifs (héros, titres
catégorie, fonds).

### 2026-05-26 — Vignette produit : ajustements suite premier feedback

- Titre passé de 14 → **16px** (lisibilité)
- Border-radius passé de 8 → **14px** (esthétique plus douce)
- Texte « Origine : » remplacé par **« Provenance : »** partout
- Drapeau CH/VS désormais collé au badge de conditionnement (était
  aligné à droite de la carte par défaut → corrigé avec
  `width: max-content` + `right: auto` sur `.product-card__badges`)
- Image cliquable → même URL que le titre du produit
- `height: auto` ajouté sur `.product-card__media img` : sans ça, les
  attributs HTML `width="416" height="312"` (qu'on a ajoutés pour le
  CLS) écrasaient le ratio quand la CSS appliquait `width: 100%`

### 2026-05-26 — Compactage des vignettes pour impression A4

Premier rendu PDF faisait **5 pages** : les images n'avaient aucune
hauteur max et la grille restait sur 2 colonnes. Itérations :
1. Grille print forcée à **4 colonnes** (`!important` pour battre la
   règle base `auto-fill, minmax(200px, 1fr)`)
2. Photo cappée à **`max-height: 22mm`**
3. Tous les textes resserrés (titre 8pt, prix 9pt, meta 6.5pt)

Résultat : **2 pages** au lieu de 5.

---

## Infra & déploiement Claude Code (sessions web)

### 2026-05-28 — pitoeuf.ch inaccessible depuis les environnements Claude Code web

Les environnements Claude Code sur le web ont une **network policy** qui filtre
les hôtes sortants. `pitoeuf.ch` n'est pas dans la liste blanche par défaut →
`curl` et `WebFetch` retournent `403 Host not in allowlist`.

**Conséquences pratiques :**
- Impossible de fetcher pitoeuf.ch/societe/ pour détecter textes/images
- Impossible de télécharger des images depuis pitoeuf.ch
- La modification de la policy ne prend effet qu'à la **prochaine session**
  (le conteneur en cours ne recharge pas la policy à chaud)

**Contournements validés :**

1. **Claude Cowork** (autre session, environnement sans restriction réseau) —
   peut fetcher la page ET télécharger les images, puis les pousser via
   GitHub MCP (`create_or_update_file` avec base64).
   Prompt type → voir `societe/download-images.sh` pour la liste des URLs.

2. **Script `download-images.sh`** dans chaque dossier projet — convention
   établie le 2026-05-28 pour tous les futurs projets Pitoeuf (voir ci-dessous).

3. **Terminal local** — cloner le repo, exécuter `bash <dossier>/download-images.sh`,
   committer les images, pusher.

**Convention établie — `download-images.sh` par projet** :

Chaque dossier de page/landing qui référence des images depuis pitoeuf.ch doit
contenir un fichier `download-images.sh` qui :
- Liste toutes les URLs sources avec les noms de fichiers cibles
- Est idempotent (skip si fichier déjà présent)
- Se suffit à lui-même (pas de dépendance externe hors `curl`)

Cela permet à n'importe qui ayant accès réseau (dev local, Cowork, CI future)
de récupérer les images en une commande, indépendamment de la session Claude.

Exemple existant : `societe/download-images.sh`

---

## Infra & déploiement

### 2026-05-26 — Workflow Pages explicite (contourne bug CDN GitHub)

Le runner automatique de GitHub Pages (« Deploy from a branch »)
plantait avec `Failed to download archive 'actions/upload-pages-artifact'`
de façon récurrente — bug structurel côté CDN GitHub, pas transitoire.

**Solution** : `.github/workflows/deploy.yml` explicite avec versions
épinglées (`@v4`, `@v5`, `@v3`), source Pages = « GitHub Actions ».

**`.nojekyll`** à la racine : indispensable, sinon Jekyll filtre
certains fichiers (dossiers commençant par `_`, etc.).

⚠️ **Ne jamais revenir** à « Deploy from a branch » sans avoir testé,
le bug réapparaît.

### 2026-05-26 — Previews par PR via `rossjrw/pr-preview-action`

Mise en place pour pouvoir **valider visuellement avant merge**
(jusque-là on mergeait à l'aveugle).

Architecture :
- Source Pages = **« Deploy from a branch » → `gh-pages` / root**
- `deploy.yml` : push sur `main` → `JamesIves/github-pages-deploy-action`
  écrit le site à la racine de `gh-pages`
- `preview.yml` : ouverture/update d'une PR → `rossjrw/pr-preview-action`
  écrit sous `gh-pages/pr-preview/pr-<N>/`, supprime le dossier à la
  fermeture/merge

URL preview : `https://caractere-swiss.github.io/pitoeuf-saxon/pr-preview/pr-<N>/<saison>/`

Le bot poste l'URL dans un commentaire sticky sur chaque PR.

### 2026-05-26 — Perf : fond bois WebP + lazy-loading

- `fond-bois-blanc.jpg` (480 ko) → `.webp` (224 ko, **-54%**)
- 21 photos produits : ajout `width`/`height` (élimine le CLS) +
  `loading="lazy"` + `decoding="async"`

### 2026-05-26 — Fond bois `background-attachment: fixed`

Le bois tilait avec `repeat-y` mais l'image contient une **fleur
décorative** → chaque répétition dupliquait la fleur (effet sapin de
Noël). Passage en `fixed` + `cover` : l'image reste collée au viewport,
le contenu défile par-dessus, plus de répétition visible.

Fallback mobile (max-width 767px) : `scroll` + `no-repeat` (fixed
mal supporté sur iOS Safari).

### 2026-05-26 — Fond blanc en PDF

Tentative initiale : garder le bois en print pour préserver l'identité.
Problème : `cover + no-repeat` ne couvrait que la page 1, pages 2-3
montraient le fallback beige `#ece5d6` → effet « bande moutarde » bizarre.

**Décision** : fond **blanc propre** en print. Plus pro pour un PDF B2B,
moins d'encre, plus lisible. On garde uniquement le **dégradé vert du
héros** pour l'identité visuelle.

---

## Landing — Été 2026

### 2026-05-26 — Hero : retrait du logo + ajout bouton « Télécharger en PDF »

- Logo retiré : la landing finale sera intégrée au site pitoeuf.ch qui
  a déjà son menu / branding. Le héros n'a donc plus besoin du logo.
- Bouton « Télécharger en PDF » → `window.print()` (zéro JS framework,
  zéro lib externe, dialogue natif du navigateur).

### 2026-05-26 — Hero adouci + filigrane « 2026 »

Premier rendu jugé trop brut par Olivier. Ajustements :
- Filigrane décoratif `26` → **`2026`** (plus lisible, opacité 8% → 6%)
- Dégradé adouci : darks moins agressifs (`#1a4208` → `#2a5810`)
- **Halo radial** chaud superposé en haut-droite pour casser l'aspect
  « bandeau plat »

### 2026-05-26 — Rappel « prix au carton complet » répété

Au lieu d'être uniquement en bas de page, la bannière apparaît aussi
après les catégories **Veau suisse** et **Volaille & Canard** pour que
le lecteur la croise pendant son parcours (page longue).

### TODO Été 2026 (différés)

- [ ] **Validation 5 photos approximatives** par Pitoeuf — listées dans
  `ete-2026/IMAGES-TODO.md`
- [ ] **3 photos manquantes** : `g6358-cotelette-agneau-bio-vs`,
  `g3900-ribs-porc`, `g3760-brochette-yakitori-marinee` (placeholders SVG)
- [ ] **Prix réels 2026** : remplacer les remises placeholder
  (-15/-20/-25/-30%) quand Pitoeuf fournit le catalogue final
- [ ] **Badges conditionnement** : assigner Frais/Sec/Surgelé sur chaque
  produit avec les icônes officielles quand le catalogue arrive
- [ ] **`og:image`** : créer un vrai bandeau 1200×630 saisonnier (utilise
  actuellement le logo PNG)
- [ ] **`<meta name="theme-color">`** : couleur barre de nav mobile en
  vert forêt

---

## Landing — Pâques 2026

### TODO (différé, après finalisation Été)

- [ ] **Migrer vers `product-card`** du design system (utilise encore
  l'ancienne structure `.card` de `landing-base.css`)
- [ ] Aligner palette si demande similaire à Été 2026 (rouge promo
  `#f95600` déjà aligné)
