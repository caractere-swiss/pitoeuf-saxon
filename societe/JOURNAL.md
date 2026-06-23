# Journal des décisions — Page Société

Journal propre à `societe/` (page institutionnelle « À propos / Société »
de pitoeuf.ch). Pour les décisions transverses (infra, design system,
conventions images), voir `/JOURNAL.md`.

---

## 2026-05-28 — Création de la page

**Contexte :** maquette brouillon de la page `pitoeuf.ch/societe/` à valider
avant portage WordPress/Elementor. Page institutionnelle sobre — pas de
produits, pas de palette saisonnière, pas de badges promo.

**Palette retenue :** orange institutionnel `#E66624` (couleur pitoeuf.ch
réelle, identifiée sur la page live) + gris neutres `#333` / `#F2F2F2`.
Pas de rouge promo `#f95600` sur cette page.

**Structure de la page (6 blocs) :**
1. En-tête sombre (`#222`) + filet orange + fil d'Ariane vers pitoeuf.ch
2. Intro narrative : texte 2 colonnes + photo (layout `intro-layout`)
3. 3 piliers : Confiance / Sécurité / Traçabilité (textes exacts du site live)
4. Chiffres clés : 3'000+ / 40'000 / 1'600+ / 2'500 t + CTA shop
5. Téléphone 027 205 60 60 + 4 services du shop (icônes SVG)
6. Ancrage local & environnement (panneaux solaires Saxon)

**Textes** : récupérés via Claude Cowork (cet environnement ne peut pas
atteindre pitoeuf.ch — voir `/JOURNAL.md` section "Infra Claude Code").

---

## 2026-05-28 — Images : placeholders SVG + download-images.sh

pitoeuf.ch bloque le hotlinking → toutes les images doivent être hébergées
localement (règle générale du projet, voir `CLAUDE.md`).

Les images de la page live ont été identifiées mais pas encore téléchargées
(environnement réseau bloqué). Solution mise en place :

- `societe/images/` contient des **placeholders SVG** pour chaque emplacement
- `societe/download-images.sh` documente toutes les URLs sources et télécharge
  les vrais fichiers en une commande (exécuter depuis un terminal avec accès
  réseau ou via Cowork)
- Les emplacements à remplacer sont marqués par des commentaires
  `<!-- TODO : télécharger ... -->` dans `index.html`

**Images à remplacer (8 fichiers) :**

| Placeholder actuel | Fichier cible | Source pitoeuf.ch |
|---|---|---|
| `placeholder-facade.svg` | `pitoeuf-equipe-fr.webp` | Photo intro principale |
| SVG inline | `icon-confiance.png` | Ellipse-0204 |
| SVG inline | `icon-securite.png` | xEllipse-0203 |
| SVG inline | `icon-tracabilite.png` | Ellipse-0201 |
| SVG inline | `icon-shop-commander.png` | xGroupe-287 |
| SVG inline | `icon-shop-prix.png` | xGroupe-289 |
| SVG inline | `icon-shop-favoris.png` | xGroupe-288 |
| SVG inline | `icon-shop-historique.png` | xGroupe-290 |

Une fois les images téléchargées, mettre à jour `index.html` pour remplacer
les `src` placeholder et les icônes SVG inline par les vrais fichiers.

---

## 2026-05-28 — Slider CSS-only 3 photos aériennes (BLOC 6)

3 photos drone du centre logistique Saxon (fournies par Ilias depuis kDrive)
intégrées dans un slider CSS-only (`input[type=radio]` + `~` sibling combinator).

- **Technique** : `.slider-track { width: 300% }`, chaque `.slider-slide` =
  `calc(100%/3)`, `translateX` par paliers de 33.33%
- **Format photos** : 2048×1152 px (16:9) — `aspect-ratio: 16/9` dans le CSS,
  attributs `width/height` en HTML pour éviter le CLS
- **Dots** : 3 `<label for="solN">` actionnables, dot actif en orange

Photos poussées via CLI local (Claude Code Mac) car le dossier kDrive
n'est pas un repo git → push via `push-photos-github.sh` avec `gh api`.

---

## 2026-05-28 — Réorganisation structure : BLOC 5 déplacé en bas

Sur demande d'Olivier, le bloc Téléphone + services shop (BLOC 5) a été
déplacé **après** le slider solaire (BLOC 6), juste avant le footer.

Ordre final de la page :
1. En-tête
2. Intro narrative (blanc)
3. Piliers Confiance/Sécurité/Traçabilité (gris)
4. Chiffres clés + CTA shop (blanc)
5. Slider photos aériennes + ancrage local (gris)
6. **Téléphone + services shop** (blanc) ← déplacé ici
7. Footer

Le fond du BLOC 5 est passé de `--grey` à `--white` pour alterner
correctement avec la section grise qui le précède.

---

---

## 2026-06-23 — Section « Nos origines » (photo Vissigen 1968)

**Contexte :** Ilias a fourni une photo aérienne N&B des installations Pitoeuf
à Vissigen (Sion) datant de 1968. Section historique ajoutée pour renforcer
l'ancrage territorial de la marque.

**Emplacement :** entre BLOC 2 (intro narrative) et BLOC 3 (piliers services).

**Technique :**
- Layout 2 colonnes (`origins-layout`) : photo gauche + texte droite
- CSS `filter: grayscale(100%) contrast(1.05)` + bordure `3px solid var(--border)`
  pour rendu archives — zéro filtre JS/lib externe
- `<figure>` + `<figcaption>` : *"Vissigen, Sion — vers 1968"*
- Mobile : 1 colonne, photo au-dessus du texte (`order: -1`)

**Image :** `societe/images/pitoeuf-1968-vissigen.jpg` (poussée depuis CLI local
via `git push` — kDrive n'est pas un repo git)

**PR :** #21 (`claude/sweet-einstein-DQdJD`) — preview active :
`https://caractere-swiss.github.io/pitoeuf-saxon/pr-preview/pr-21/societe/`

**Texte retenu :** conservateur, sans dates inventées — "Avant de s'établir à
Saxon, Pitoeuf était implanté dans la plaine du Rhône, à Sion. [...] Quatre
générations plus tard, l'ancrage dans le terroir est resté le même."

---

## 2026-06-23 — Uniformisation graphique : tokens design system

**Problème signalé par Ilias :** incohérence typo/couleurs sur la page —
3 oranges différents (`#E66624` accent, `#E6A080` liens footer, `#cc5310`
survol CTA) et **5 tailles de corps** (13/14/15/16/18 px) sans logique d'échelle.

**Correction couleur :** l'orange institutionnel officiel pitoeuf.ch est
`#f9a600` (doré/ambre), **pas** `#E66624`. Remplacé partout.

**Solution :** création de `design-system/tokens.css` (source de vérité
transverse, choix validé : design system partagé plutôt que local).
- **Couleurs** : `--orange` (#f9a600) + `--orange-dark` (#d99000, survol) +
  `--orange-light` (#ffc24d, liens sur fond sombre) ; neutres `--grey-*`
- **Échelle typo** : 7 crans (`--fs-display/h1/h2/h3/body/small/label`),
  graisses 300/400/700/900 (titres standardisés sur 700 — Roboto n'est pas
  chargé en 800)

`societe/theme.css` entièrement recâblé : **zéro taille/couleur en dur**, tout
passe par `var(--fs-*)` / `var(--orange*)`. Ordre de chargement :
`landing-base.css` → `tokens.css` → `theme.css`.

**Portée :** appliqué à `societe/` uniquement pour l'instant. Été/Pâques
gardent leur rendu vert actuel (pas de régression) — migration possible plus tard.

---

## TODO différés

- [x] **4 images téléchargées** via Cowork + token temporaire (2026-05-28) :
      `pitoeuf-equipe-fr.webp`, `icon-confiance.png`, `icon-securite.png`,
      `icon-tracabilite.png` — intégrées dans `index.html`
- [x] **3 photos solaires** poussées via CLI local (2026-05-28) :
      `depot-solaire-1/2/3.jpg` — intégrées dans le slider BLOC 6
- [x] **Photo Vissigen 1968** poussée via CLI local (2026-06-23) :
      `pitoeuf-1968-vissigen.jpg` — intégrée dans section « Nos origines »
- [ ] **4 icônes shop** restantes (`icon-shop-*.png`) — toujours en SVG
      inline, à télécharger via `download-images.sh`
- [ ] **Valider la maquette** avec Olivier (textes, structure, palette)
      avant portage WordPress/Elementor
- [ ] **Vérifier les icônes des piliers** : les images pitoeuf.ch
      (`Ellipse-0201/0203/0204`) sont peut-être des pastilles colorées —
      adapter le CSS si elles remplacent les icônes SVG actuelles
- [ ] **Photos complémentaires** à fournir par client : façade Saxon, camion
      de livraison, chambre froide, 1-2 photos terroir valaisan
