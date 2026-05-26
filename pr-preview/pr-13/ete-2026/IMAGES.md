# Manifeste images — Été 2026

Pour chaque produit, récupérer la photo depuis pitoeuf.ch (ou source équivalente) et la déposer dans `ete-2026/images/` avec le **nom de fichier indiqué**, en remplaçant le placeholder SVG.

**Format recommandé** : JPG, ratio ~4:3 ou ~16:12, dimension cible **416×312** ou **324×324** (cf. images Pâques).

Une fois toutes les images en place, lancer un find/replace global dans `ete-2026/index.html` :
- chercher : `.svg"`
- remplacer par : `.jpg"`

Et supprimer les `*.svg` du dossier `images/`.

---

## Légende

- ✅ URL fiche produit confirmée
- ⚠️ URL approximative (pas d'exact match trouvé sur pitoeuf.ch — à vérifier)
- ❌ Pas de fiche trouvée (HTML actuel : nom en texte simple, sans lien)

---

## Liste des 21 produits

### Bœuf

| Fichier image | Produit (Art.) | Fiche pitoeuf.ch |
|---|---|---|
| `g38151-entrecote-boeuf.jpg` | Entrecôte de bœuf (G38151.sg) | ⚠️ https://pitoeuf.ch/produit/entrecote-parisienne-de-boeuf-2/ |
| `g3893-tranche-ronde-boeuf.jpg` | Tranche ronde de bœuf (G3893.sg) | ✅ https://pitoeuf.ch/produit/tranche-ronde-de-boeuf/ |

### Agneau

| Fichier image | Produit (Art.) | Fiche pitoeuf.ch |
|---|---|---|
| `g6336-steak-gigot-agneau.jpg` | Steak de gigot d'agneau (G6336) | ⚠️ https://pitoeuf.ch/produit/gigot-dagneau-avec-os-2/ |
| `g6358-cotelette-agneau-bio-vs.jpg` | Côtelette d'agneau BIO du Valais (G6358.sg) | ✅ https://pitoeuf.ch/produit/cotelette-dagneau-du-valais/ |

### Veau suisse

| Fichier image | Produit (Art.) | Fiche pitoeuf.ch |
|---|---|---|
| `g6155-grenadin-veau.jpg` | Grenadin de veau (G6155.sg) | ✅ https://pitoeuf.ch/produit/grenadin-de-veau/ |
| `g6156-quasi-veau.jpg` | Quasi de veau (G6156.sg) | ✅ https://pitoeuf.ch/produit/quasi-de-veau/ |
| `g4209-ribs-veau.jpg` | Ribs de veau (G4209) | ✅ https://pitoeuf.ch/produit/ribs-de-veau/ |

### Porc & Cheval

| Fichier image | Produit (Art.) | Fiche pitoeuf.ch |
|---|---|---|
| `g3900-ribs-porc.jpg` | Ribs de porc (G3900) | ❌ pas de fiche trouvée — à confirmer |
| `g5013-rumsteak-cheval.jpg` | Rumsteak de cheval « Richelieu » 180 gr (G5013.sg) | ✅ https://pitoeuf.ch/produit/rumsteak-de-cheval-richelieu-portionne-par-2-pieces/ |

### Volaille & Canard

| Fichier image | Produit (Art.) | Fiche pitoeuf.ch |
|---|---|---|
| `g3516-escalope-poulet.jpg` | Escalope de poulet en bloc (G3516, BR) | ❌ pas de fiche trouvée (produit grossiste, pas e-commerce ?) |
| `g10083-poulet-entier-epice.jpg` | Poulet entier assorti épicé (G10083, CH) | ❌ pas de fiche trouvée — à confirmer |
| `17555-brochette-yakitori-cuite.jpg` | Brochette poulet Yakitori cuite soja miel (17555) | ✅ https://pitoeuf.ch/produit/brochette-de-poulet-yakitori-cuite-soja-miel/ |
| `g3760-brochette-yakitori-marinee.jpg` | Brochette poulet marinée crue Yakitori 35 gr (G3760.5) | ❌ seul le format « cuit » existe sur le site |
| `g1026-magret-canard.jpg` | Magret de canard gavé (G1026.sg) | ⚠️ https://pitoeuf.ch/produit/filet-de-canard-180-220-gr/ (filet de canard, pas magret stricto sensu) |

### Poisson & Fruits de mer

| Fichier image | Produit (Art.) | Fiche pitoeuf.ch |
|---|---|---|
| `m391-crevettes-2030.jpg` | Crevettes entières 20/30 « Premium » (M391) | ✅ https://pitoeuf.ch/produit/crevettes-entieres-20-30-premium/ |
| `m1049-filet-bar.jpg` | Filets de bar avec peau (M1049.sg) | ✅ https://pitoeuf.ch/produit/filet-de-bar-avec-peau/ |
| `m102-perche-loe-valais.jpg` | Filets de perche 30-40 gr Loë du Valais (M102.vs.sg) | ✅ https://pitoeuf.ch/produit/filets-de-perche-avec-peau-30-40-gr-loe-du-valais/ |
| `m1014-perche-mclean.jpg` | Filets de perche « Mc Lean » 40/50 (M1014) | ⚠️ https://pitoeuf.ch/produit/filets-de-perche-mc-lean-30-40/ (seul le 30/40 référencé) |
| `m101-perche-premium.jpg` | Filets de perche 10-20 gr « Premium » (M101) | ❌ pas de fiche — équivalent Loë du Valais probable |

### Sauces & Huiles

| Fichier image | Produit (Art.) | Fiche pitoeuf.ch |
|---|---|---|
| `100921-huile-colza-holl.jpg` | Huile de Colza HOLL Nutriswiss 20 l (100921) | ✅ https://pitoeuf.ch/produit/huile-de-colza-20-litres-holl-nutriswiss/ |
| `21011-sauce-pizza-mutti.jpg` | Sauce pizza classique « Mutti » (21011) | ✅ https://pitoeuf.ch/produit/sauce-pizza-aromatisee-mutti-hugo-reitzel/ |

---

## Récapitulatif

- **21 produits** au total
- **13 URLs ✅ confirmées**
- **4 URLs ⚠️ approximatives** (Entrecôte, Steak gigot, Magret canard, Perche McLean)
- **4 URLs ❌ introuvables** (Ribs porc, Escalope poulet en bloc, Poulet entier épicé, Brochette marinée crue, Perche Premium 10-20) — *à valider avec Pitoeuf : ces produits sont-ils sur le e-shop ?*
