# Template — Nouvelle landing saisonnière

Squelette à dupliquer pour démarrer une nouvelle saison.

## Procédure (≈ 5 minutes)

```bash
# 1. Dupliquer le template dans un dossier nommé <saison>-<année>
cp -r _template hiver-2026
cd hiver-2026

# 2. Créer le dossier images (vide)
mkdir -p images

# 3. Ouvrir chaque fichier et remplacer les placeholders `{{...}}`
#    Liste des placeholders à substituer :
#      {{SAISON}}          — ex : « Hiver », « Été »
#      {{saison}}           — version slug : « hiver », « ete »
#      {{ANNEE}}            — ex : « 2026 »
#      {{TITRE_PAGE}}       — titre <title> et OG (ex : « Suggestions Hiver 2026 »)
#      {{META_DESCRIPTION}} — meta description (≈ 150 caractères)
#      {{OG_DESCRIPTION}}   — version courte pour partage social
#      {{EYEBROW}}          — surtitre du héros (ex : « Saveurs de saison »)
#      {{TITRE_LIGNE_1}}    — première ligne du <h1> (ex : « Feuillet »)
#      {{TITRE_LIGNE_2}}    — mot coloré du <h1> (ex : « Estival »)
#      {{ACCROCHE}}         — sous-titre italique
#      {{DATE_VALIDITE}}    — ex : « 31 août 2026 »
#      {{NOM_CATEGORIE}}    — ex : « Bœuf »
#      {{NOM_PALETTE}}      — nom interne (ex : « Soleil & herbes »)
```

## Étapes ensuite

1. **Choisir la palette** dans `theme.css` — voir `../docs/DESIGN-SYSTEM.md` pour
   le rôle de chaque variable. Coller les codes hex à la place des `#XXXXXX`.
2. **Lister les produits** : dupliquer le bloc `<div class="card">` pour chaque
   produit, dupliquer `<section class="category-section">` pour chaque catégorie.
3. **Récupérer les photos** : suivre `../docs/IMAGES.md` (procédure Cowork +
   ImageMagick). En attendant, les références `.svg` du HTML utilisent des
   placeholders à générer.
4. **Ajouter une tuile** dans le portail racine `/index.html` pour rendre la
   nouvelle saison visible.
5. **Mettre à jour `MASTER.md`** (table des feuillets, historique).
6. **Remplir `JOURNAL.md`** au fil des décisions.

## Checklist avant publication (merge vers `main`)

- [ ] Tous les `{{...}}` remplacés (`grep -r "{{" <saison>-<année>/` doit être vide)
- [ ] Prix vérifiés avec le catalogue final reçu de Pitoeuf
- [ ] Date de validité affichée correcte
- [ ] Toutes les photos en `.jpg` (plus de `.svg` dans `index.html`) ou
      photos manquantes listées dans `IMAGES-TODO.md`
- [ ] Badges `badge-swiss` (CH/VS) et `badge-frozen` (Surgelé) corrects
- [ ] Liens produits pitoeuf.ch valides (pas de 404)
- [ ] Test responsive : 320 px, 375 px, 768 px, 1024 px
- [ ] Test impression A4 (3 colonnes, pas de coupure de carte)
- [ ] Tuile ajoutée dans le portail `/index.html`
- [ ] `MASTER.md` mis à jour
- [ ] `JOURNAL.md` reflète l'historique
- [ ] Image OG correcte (à terme : bannière 1200×630 dédiée)
