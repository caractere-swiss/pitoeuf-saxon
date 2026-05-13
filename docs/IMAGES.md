# Procédure photos produits

> Comment récupérer, normaliser et nommer les photos des produits Pitoeuf
> pour les landings saisonnières.

## Spécifications cibles

| Critère | Valeur |
|---|---|
| Format | JPG progressif |
| Dimensions | **416 × 312 px** (ratio 4:3) |
| Qualité | 85 (compromis taille / netteté) |
| Métadonnées | EXIF stripped (`-strip`) |
| Poids cible | ≈ 15–35 ko / image |
| Emplacement | `<saison>-<année>/images/` |
| Nommage | `<code-article-minuscules>-<slug-produit>.jpg` |

**Exemple de nommage** : pour l'article `G38151.sg` (Entrecôte de bœuf) →
`g38151-entrecote-boeuf.jpg`. Les points et suffixes (`.sg`, `.vs`) sont
omis dans le slug pour rester lisibles.

## Source des photos

Les images officielles vivent sur `pitoeuf.ch`. **Le hotlinking est bloqué
côté serveur**, on doit donc systématiquement héberger les copies localement.

URL type d'une image produit :
```
https://pitoeuf.ch/wp-content/uploads/<année>/<mois>/<nom-fichier>.jpg
```

Pour trouver l'URL exacte d'un produit, on part de sa fiche e-shop :
```
https://pitoeuf.ch/produit/<slug-produit>/
```
puis on inspecte la balise `<img>` principale.

## Workflow pratique

L'environnement Claude Code n'a pas accès à `pitoeuf.ch` (sandbox). Deux
options pour récupérer les photos en masse :

### Option A — Claude Cowork (Claude avec accès web)

Recommandé quand on doit récupérer ≥ 5 images.

1. Préparer la liste des URLs cibles dans le `IMAGES.md` de la saison
2. Briefer Cowork avec un message du type :

   > « Voici 18 URLs d'images pitoeuf.ch à télécharger dans le kDrive
   > Caractère Swiss, dossier `pitoeuf-saxon/<saison>-<année>/raw/`.
   > Une fois téléchargées, lance le script de redimensionnement (voir
   > ci-dessous) et dépose les `.jpg` finaux dans `images/`. »

3. Cowork retourne les fichiers normalisés via kDrive ou commit Git

### Option B — Téléchargement manuel local

Pour 1–3 photos isolées : télécharger manuellement depuis pitoeuf.ch puis
appliquer la commande de normalisation ci-dessous.

## Commande de normalisation (ImageMagick)

À appliquer sur chaque image source :

```bash
convert /tmp/raw_FILENAME \
    -resize 416x312^ \
    -gravity center \
    -extent 416x312 \
    -strip \
    -quality 85 \
    <saison>-<année>/images/FILENAME.jpg
```

**Décomposition :**
- `-resize 416x312^` : agrandit/réduit en couvrant la zone (ratio préservé)
- `-gravity center -extent 416x312` : crop centré aux dimensions exactes
- `-strip` : retire les métadonnées EXIF (GPS, appareil, etc.)
- `-quality 85` : compression JPG raisonnable

Si plusieurs images :

```bash
for f in /tmp/raw_*.jpg; do
    name=$(basename "$f" | sed 's/^raw_//')
    convert "$f" -resize 416x312^ -gravity center -extent 416x312 \
            -strip -quality 85 "<saison>-<année>/images/$name"
done
```

## Placeholders SVG (photo manquante)

Pour les produits dont la photo n'est pas encore disponible, on génère un
placeholder SVG temporaire avec le nom du produit et un fond cohérent avec
la palette de saison.

Modèle minimal :

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 416 312">
  <rect width="416" height="312" fill="var(--accent-light)"/>
  <text x="208" y="156" font-family="Helvetica, Arial, sans-serif"
        font-size="18" font-weight="700" text-anchor="middle"
        fill="var(--accent-dark)">
    Nom du produit
  </text>
</svg>
```

Astuce : le HTML référence directement `images/<code>-<slug>.svg`. Quand la
photo arrive, renommer en `.jpg` et faire un find/replace `.svg"` → `.jpg"`
dans `index.html`.

## Checklist par image avant commit

- [ ] Dimensions exactes 416 × 312 px (`identify <fichier>`)
- [ ] Poids < 50 ko (sinon : augmenter compression ou revoir source)
- [ ] EXIF retiré (`identify -verbose <fichier> | grep -i exif` doit être vide)
- [ ] Nom de fichier conforme (minuscules, slug-tirets, code sans points)
- [ ] Référencée dans `IMAGES.md` avec URL source et statut
