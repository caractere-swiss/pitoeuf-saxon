# Journal — Feuillet Été 2026

> Journal de suivi spécifique au feuillet Été 2026.
> Pour la vue d'ensemble du projet, voir `MASTER.md` à la racine.
> Pour les décisions transverses (design system, infra), voir `../JOURNAL.md`.

## État actuel

- **Version** : maquette finale — **feuillet officiel 2026 intégré** (PDF
  `feuilleteteFR2026.pdf`), en attente de validation finale d'Olivier
- **En ligne** : https://caractere-swiss.github.io/pitoeuf-saxon/ete-2026/
- **Preview PR** : https://caractere-swiss.github.io/pitoeuf-saxon/pr-preview/pr-20/ete-2026/
- **Validité affichée** : « Valable jusqu'au 31 août 2026 »
- **Catalogue** : ✅ 21 produits du feuillet officiel
- **Photos** : ✅ 21 / 21 en place
- **Liens fiches** : ✅ 21 / 21 (2 approximatifs — cf. `IMAGES-TODO.md`)
- **Prix** : prix promo du feuillet + prix barrés/remises (2 anomalies à
  valider Olivier — cf. `IMAGES-TODO.md`)

## Décisions

- **Palette** : « Soleil & herbes » — or doré (`#f5c542`) + olive (`#8ba62a`)
  + ivoire (`#fbf8e7`)
- **Structure** : 7 catégories — Bœuf, Agneau, Veau suisse, Porc & Cheval,
  Volaille, Poisson & Fruits de mer, Divers
- **Accroche** : « Notre sélection pour un bel été »
- **Titre hero** : « **Suggestions Été 2026** » (« Été » coloré or doré ;
  « Feuillet » abandonné car évoquait l'imprimé)
- **Eyebrow** : « Saveurs de saison »
- **Vignettes** : composant `product-card` du design system (badges
  conditionnement + drapeau, cercle de remise, prix barré)
- **Fond bois** : `cover` + `fixed` (couvre toute la page, sans répétition)
- **Bouton « Télécharger en PDF »** : `window.print()` (zéro JS framework)

## Points en suspens

### À valider avec Pitoeuf / Olivier — cf. `IMAGES-TODO.md`
- [ ] Fiche + prix catalogue **G38151 Entrecôte** (absente du shop)
- [ ] Format fiche **M1014 Perche McLean** (40/50 vs 30/40)
- [ ] Anomalies de remise : **M1005** (0%), **M65** (-34%), **110550** (-47%)
- [ ] Validation finale de la sélection + date de fin de l'offre

### Améliorations possibles
- [ ] Bannière Open Graph 1200×630 (actuellement = logo seul)
- [ ] `<meta name="theme-color">` vert forêt (barre nav mobile)
- [x] ~~Fond bois en PDF~~ — fait : fond blanc propre en impression (le bois
  laissait une bande beige, `fixed` inopérant en print)
- [ ] Nettoyer les ~16 images orphelines de l'ancienne maquette 2025

## Historique

| Date | Action |
|---|---|
| 2026-05-12 | Création landing Été 2026 (draft basé sur PDF 2025) — 21 produits, 7 catégories, placeholders SVG |
| 2026-05-12 | Récupération de 18/21 photos depuis pitoeuf.ch (Cowork) |
| 2026-05-12 | Merge PR #3 — landing publiée |
| 2026-05-26 | Migration sur le design system `product-card` + héros adouci + filigrane |
| 2026-06-09 | **Intégration du feuillet officiel 2026** : catalogue entièrement revu (21 produits), photos réelles 21/21, prix barrés + remises, liens fiches 21/21, titre « Suggestions Été 2026 », catégorie « Divers » (PR #20) |

## Liens utiles

- PR de création : https://github.com/caractere-swiss/pitoeuf-saxon/pull/3 (mergée)
- PR feuillet officiel 2026 : https://github.com/caractere-swiss/pitoeuf-saxon/pull/20
- Manifeste images : `./IMAGES.md`
- TODO images & prix : `./IMAGES-TODO.md`
- Tronc commun CSS : `../assets/css/landing-base.css`
- Thème : `./theme.css`
