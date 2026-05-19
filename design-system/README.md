# Pitoeuf Design System

> Composants visuels partagés entre tous les projets Pitoeuf (landings
> saisonnières, newsletters, microsites). **Source de vérité** du design Pitoeuf.

## Pourquoi ce dossier

Le design des vignettes produits, des badges, des couleurs de marque doit
rester cohérent **à travers tous les projets** (feuillets promo, emails,
intranet…). Plutôt que de copier-coller à chaque fois, on définit ici une
fois pour toutes, et chaque projet le consomme.

## Comment l'utiliser

### Cas 1 — Un projet du dépôt `pitoeuf-saxon` (landings)

Lien CSS relatif :

```html
<link rel="stylesheet" href="../design-system/components/product-card.css">
```

### Cas 2 — Un projet externe (newsletter web, microsite tiers…)

Lien CSS via GitHub Pages CDN (toujours à jour, dernière version de `main`) :

```html
<link rel="stylesheet"
      href="https://caractere-swiss.github.io/pitoeuf-saxon/design-system/components/product-card.css">
```

### Cas 3 — Email newsletter (HTML email)

⚠️ Les clients email (Outlook surtout) ne supportent pas les CSS externes ni
les variables CSS. Il faut une version **inline-friendly** avec `<table>`.
Cette version sera ajoutée dans `email/` quand la première newsletter sera
développée. En attendant, voir `components/product-card.html` pour le markup
sémantique de référence (à transposer en `<table>`).

---

## Composants

### `product-card` — Vignette produit

**Fichiers :**
- `components/product-card.css` — styles
- `components/product-card.html` — exemple de markup à copier

**Anatomie :**

```
┌─────────────────────┐
│ ⛄ [CH]              │  ← groupe top-left : conditionnement
│                     │    + origine (CH/VS) immédiatement à droite
│       PHOTO         │  ← 4:3, object-fit cover
│                     │
├─────────────────────┤
│   Nom du produit    │  ← titre centré
│      Réf. G1234     │  ← méta centré
│   Provenance : CH   │
├─────────────────────┤
│ ╭───╮      1 carton │  ← bandeau crème
│ │-20│  CHF 42.80/kg │  ← cercle remise + bloc prix à droite
│ ╰───╯  CHF 53.50/kg │
└─────────────────────┘
```

**Badges de conditionnement disponibles** (mutuellement exclusifs — un produit
a UN seul état de conditionnement). Icônes officielles dans `icons/` :
- `product-card__badge--frozen` — Surgelé (flocon `#00c0f9` — `icons/surgele.svg`)
- `product-card__badge--fresh`  — Frais (goutte `#97db16` — `icons/frais.svg`)
- `product-card__badge--dry`    — Sec / épicerie (soleil `#f5d41c` — `icons/sec.svg`)
- Pour ajouter un nouveau type : déposer le SVG dans `icons/`, ajouter
  une variable `--pcard-XXX-color` et une règle CSS associée

**Badge origine** : `product-card__badge--origin`, contenu texte libre
(`CH`, `VS`, ou autre). Toujours **à droite du conditionnement** s'il
existe, sinon seul au top-left.

**Éléments optionnels** (à omettre simplement dans le HTML) :
- Le groupe de badges entier (`product-card__badges`) ou chaque badge individuellement
- Cercle remise (`product-card__discount`)
- Prix barré (`product-card__price-regular`)
- Bandeau Promo (`product-card__promo-banner`)

**Tokens CSS thématisables** (à surcharger dans le theme.css de chaque projet) :

| Token | Rôle | Valeur défaut |
|---|---|---|
| `--pcard-bg` | Fond carte | `#ffffff` |
| `--pcard-border` | Bordure carte | `#e5e5e5` |
| `--pcard-radius` | Rayon coins | `8px` |
| `--pcard-shadow` | Ombre repos | `0 2px 8px rgba(0,0,0,.06)` |
| `--pcard-shadow-hover` | Ombre survol | `0 8px 20px rgba(0,0,0,.10)` |
| `--pcard-title-color` | Couleur titre | `#1a1a1a` |
| `--pcard-meta-color` | Couleur méta | `#707070` |
| `--pcard-price-color` | Couleur prix | `#1a1a1a` |
| `--pcard-price-bg` | Fond bandeau prix | `#fff6e3` |
| `--pcard-frozen-color` | Couleur icône Surgelé | `#00c0f9` (officiel Pitoeuf) |
| `--pcard-fresh-color` | Couleur icône Frais | `#97db16` (officiel Pitoeuf) |
| `--pcard-dry-color` | Couleur icône Sec | `#f5d41c` (officiel Pitoeuf) |
| `--pcard-origin-bg` | Fond badge CH/VS | `#d52b1e` (rouge suisse) |
| `--pcard-discount-bg` | Fond cercle remise | `#e8821a` |

---

## Conventions

- **HTML sémantique** : `<article>` pour chaque carte, `<h3>` pour le titre
  (la page utilise `<h1>` pour le héros et `<h2>` pour les catégories)
- **Accessibilité** : `aria-label` sur les badges purement icôniques (flocon)
- **Photos** : JPG 416×312 (4:3), q85, EXIF stripped — voir `docs/IMAGES.md`
- **Icônes** : SVG inline (pas de dépendance Font Awesome). Pour les emails,
  un fallback PNG sera fourni
- **Couleurs marque** : ne pas changer `--pcard-frozen-bg` (bleu froid) ni
  `--pcard-origin-bg` (rouge suisse) ni `--pcard-discount-bg` (orange promo)
  → ils font partie de l'identité Pitoeuf et doivent rester cohérents

---

## Versionnage

Le design system n'est **pas versionné** pour le moment — chaque projet
consomme la `main`. Si un breaking change devient nécessaire (refonte
visuelle majeure), on créera un dossier `v2/` à côté de `v1/` pour que les
projets existants ne soient pas cassés.

---

## Pour démarrer un nouveau projet Pitoeuf (autre repo)

Quand un nouveau dépôt Pitoeuf sera créé (ex : `pitoeuf-newsletter`,
`pitoeuf-microsite-2027`), il doit dès le départ pointer vers ce design
system pour rester harmonisé.

### Template à mettre dans le `CLAUDE.md` du nouveau repo

```markdown
# <Nom du projet> — Contexte projet

## Client
Pitoeuf SA — Grossiste en comestibles, Saxon (Valais, Suisse).

## ⚠️ Design system Pitoeuf — SOURCE DE VÉRITÉ EXTERNE

Ce projet **doit** utiliser les composants visuels partagés Pitoeuf
définis dans le dépôt `pitoeuf-saxon` :

- Doc : https://github.com/caractere-swiss/pitoeuf-saxon/blob/main/design-system/README.md
- CSS via CDN : https://caractere-swiss.github.io/pitoeuf-saxon/design-system/components/product-card.css
- Exemples markup : https://github.com/caractere-swiss/pitoeuf-saxon/tree/main/design-system/components

**Règles :**
1. Avant de créer un composant visuel, vérifier qu'il n'existe pas déjà
   dans le design system Pitoeuf
2. Couleurs marque (bleu Surgelé `#4aa8d8`, rouge CH/VS `#d52b1e`, orange
   remise `#e8821a`, beige prix `#fff6e3`) — JAMAIS modifier
3. Si on a besoin d'un nouveau composant partageable, le proposer en PR
   sur le dépôt `pitoeuf-saxon` (pas dans ce projet)
```

Coller ce bloc dans le `CLAUDE.md` du nouveau repo garantit que toute
session Claude qui ouvrira ce projet saura immédiatement où chercher.

---

## Roadmap

- [ ] Version `email/` du `product-card` (HTML table + styles inline + PNG icônes)
- [ ] Composants additionnels :
    - [ ] Bannière promo (le bandeau "Promo jusqu'au DD.MM" de pitoeuf.ch)
    - [ ] Bouton primaire (CTA)
    - [ ] Hero saisonnier réutilisable
- [ ] `tokens.css` — fichier dédié aux variables de marque transverses
