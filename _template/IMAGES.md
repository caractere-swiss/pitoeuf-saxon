# Manifeste images — {{SAISON}} {{ANNEE}}

> Référentiel des photos produits utilisées dans `index.html`.
> Pour la procédure complète de récupération et de redimensionnement, voir `../docs/IMAGES.md`.

## Convention

- **Format** : JPG, 416×312 px (ratio 4:3), qualité 85, EXIF stripped
- **Nommage** : `<code-article-en-minuscules-sans-points>-<slug-produit>.jpg`
  - ex : `g38151-entrecote-boeuf.jpg` pour l'article `G38151.sg`
- **Emplacement** : `<saison>-<année>/images/`
- **Placeholder** : SVG temporaire si la photo n'est pas encore disponible (référencer `.svg` dans le HTML, basculer en `.jpg` une fois la photo livrée)

## Inventaire

| Code article | Nom produit | URL pitoeuf.ch | Fichier image | Statut |
|---|---|---|---|---|
| G... | ... | https://pitoeuf.ch/produit/.../ | g...-slug.jpg | ✅ |
| ... | ... | ... | ...svg | ⚠️ placeholder |

**Légende statut :**
- ✅ Photo récupérée, dimensions/qualité OK
- ⚠️ Photo approximative (mauvais grammage / produit voisin) — à valider avec Pitoeuf
- ❌ Placeholder SVG, photo manquante (voir `IMAGES-TODO.md`)
