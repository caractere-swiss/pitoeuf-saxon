# Rapport stratégique — Feuillets Pitoeuf SA

> **Destinataire :** Shala (stratégie feuillets / client Pitoeuf)
> **Auteur :** Ilias Müller — Caractère Swiss
> **Date :** 9 juin 2026
> **Objet :** Bilan de la session Été 2026 + système réutilisable + vision

---

## 1. En une phrase

On dispose désormais d'un **système réutilisable** qui transforme chaque
feuillet saisonnier Pitoeuf en **page web dédiée + PDF imprimable**, déclinable
en quelques heures pour chaque nouvelle saison — démontré sur le feuillet
**Été 2026**.

---

## 2. Ce qui a été livré (Été 2026)

- **Page web** reprenant le feuillet officiel Été 2026 : 21 produits, 7
  catégories (Bœuf, Agneau, Veau, Porc & Cheval, Volaille, Poisson & Fruits
  de mer, Divers).
- **21 photos produit** + **21 liens** vers les fiches pitoeuf.ch.
- **Prix promo + prix barrés + cercles de remise** (−8 % à −47 %).
- **Bouton « Télécharger en PDF »** : impression native optimisée (mise en
  page dense 4 colonnes, pairing des petites catégories, fond blanc propre).
- **Aperçu actuel (temporaire) :**
  https://caractere-swiss.github.io/pitoeuf-saxon/pr-preview/pr-20/ete-2026/
  → URL définitive après mise en ligne :
  https://caractere-swiss.github.io/pitoeuf-saxon/ete-2026/

---

## 3. Le vrai actif stratégique : l'industrialisation

Au-delà d'Été 2026, l'investissement clé est un **socle mutualisé** :

- **Design system** (`design-system/`) : vignette produit, badges, couleurs
  de marque, rendu impression — **source de vérité unique** pour tous les
  projets Pitoeuf (feuillets, futures newsletters, microsites…).
- **Tronc commun** (`assets/css/landing-base.css`) : mise en page, héros,
  grille, rendu PDF dense — partagé par tous les feuillets.
- **Conséquence** : un nouveau feuillet = copier un dossier, ajuster la
  palette saisonnière et la liste produits. Le rendu web **et** le PDF sont
  hérités automatiquement et restent **cohérents d'une saison à l'autre**.

**Bénéfice business :** coût marginal d'un feuillet en forte baisse, délai de
production réduit, qualité homogène, image de marque maîtrisée.

---

## 4. Workflow de production d'un nouveau feuillet

1. Réception du feuillet validé (PDF / liste produits + prix).
2. Duplication du dossier saison + palette saisonnière.
3. Intégration produits (photos + prix + liens fiches).
4. Relecture / aperçu PR (lien partageable au client avant mise en ligne).
5. Mise en ligne sur page dédiée + PDF téléchargeable.

**Dépendances externes à anticiper** (cf. §6).

---

## 5. État actuel & points en attente

| Sujet | Statut |
|---|---|
| Maquette web + PDF Été 2026 | ✅ Prête (en attente retour des 2 Olivier) |
| Photos / liens produits | ✅ Complets (2 cas approximatifs à confirmer) |
| Prix & remises | ⏳ 3 anomalies à valider (M1005 0 %, M65 −34 %, Romanesco −47 %) |
| Fiche + prix « Entrecôte G38151 » | ⏳ Introuvable sur pitoeuf.ch — à fournir |
| Décision bandeau promo en PDF | ⏳ Garder le mini-liseré ou retirer |
| Bannière de partage (Open Graph) | ⏳ À créer (1200×630) |
| Mise en ligne définitive (merge) | ⏳ Sur feu vert client |

---

## 6. Risques & points d'attention

- **Contenus dépendants de Pitoeuf** : photos, prix catalogue d'origine et
  fiches produit viennent de pitoeuf.ch / des équipes. Tout produit sans
  fiche bloque le lien + le calcul de remise.
- **Données promo seules** : le feuillet ne donne que les prix promo ; les
  prix « barrés » nécessitent les prix catalogue (collectés cette fois, à
  re-demander à chaque saison).
- **Validation humaine indispensable** sur les écarts de remise inhabituels
  (éviter d'afficher une fausse réduction au client final).

---

## 7. Recommandations / vision

1. **Page dédiée permanente sur pitoeuf.ch** : intégrer chaque feuillet
   saisonnier comme page du site (vs. PDF par email uniquement).
2. **PDF téléchargeable** conservé pour ceux qui veulent imprimer (bouton
   déjà en place).
3. **Calendrier saisonnier** : décliner le modèle (Automne, Fêtes, Volaille,
   Pâques…) sur le même socle.
4. **Process « prix » amont** : demander systématiquement prix promo **et**
   prix catalogue dès la validation du feuillet, pour les remises.
5. **Mesure d'audience** (optionnel) : si Pitoeuf veut suivre la
   fréquentation des pages feuillets (outil léger type Plausible).

---

## 8. Prochaine étape immédiate

Attente du retour des 2 Olivier sur la **version web** (mail programmé pour
demain matin). Selon leur intérêt : peaufinage + mise en ligne sur page
dédiée. Les validations métier en attente (prix, entrecôte) peuvent être
traitées en parallèle.

---

*Détail technique et historique des décisions : `JOURNAL.md` (transverse),
`ete-2026/JOURNAL.md` (saison), `design-system/README.md` (socle partagé),
`MASTER.md` (suivi global).*
