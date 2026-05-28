# Master — Suivi global Pitoeuf SA

> Vue d'ensemble du projet. Pour le détail d'une saison, voir le `JOURNAL.md` dans le dossier correspondant.
>
> Ce dépôt héberge **deux types de livrables** qui partagent la même charte
> (design-system) : les **feuillets saisonniers** (landings) et la
> **newsletter** promotionnelle (email Mailchimp).

---

## Feuillets saisonniers (landings)

| Saison | Statut | Validité | URL | Journal |
|---|---|---|---|---|
| **Pâques 2026** | ✅ Publié | 26 mars – 17 avril 2026 | [/paques-2026/](https://caractere-swiss.github.io/pitoeuf-saxon/paques-2026/) | (à créer si besoin) |
| **Été 2026** | 🟡 Draft (basé 2025) | jusqu'au 31 août 2026 | [/ete-2026/](https://caractere-swiss.github.io/pitoeuf-saxon/ete-2026/) | [JOURNAL](./ete-2026/JOURNAL.md) |
| Hiver 2026 | — | — | — | — |
| Volaille 2027 | — | — | — | — |

## Newsletter (email Mailchimp)

| Projet | Statut | Type | URL | Notes |
|---|---|---|---|---|
| **Newsletter « Actions de la semaine »** | 🟡 En attente validation client (Olivier) | HTML email (table-based, CSS inline, MSO Outlook) | [/newsletter/](https://caractere-swiss.github.io/pitoeuf-saxon/newsletter/) | Couleurs alignées sur la charte. Reste : intégration Mailchimp + segmentation (clients/prospects) + tests d'envoi |

**Légende statut :**
- 🟢 Final — catalogue 2026 confirmé, photos validées
- 🟡 Draft — structure prête, contenu en attente de validation
- ⚪ À démarrer
- 🔴 Bloqué

---

## Infrastructure & tronc commun

### Architecture
```
/
├── index.html                  Portail (liste feuillets + newsletter)
├── MASTER.md                   Ce fichier
├── CLAUDE.md                   Contexte projet (méthodologie)
├── JOURNAL.md                  Journal transverse des décisions
├── assets/css/landing-base.css Tronc commun landings (variables CSS)
├── images/                     Assets partagés (logo, favicon)
├── design-system/              ★ Lib visuelle partagée (cross-projet)
│   ├── README.md               Doc tokens + conventions
│   ├── components/             product-card.css / .html
│   └── icons/                  SVG officiels (surgelé, frais, sec, drapeaux)
├── newsletter/                 Newsletter Mailchimp (email HTML)
│   └── index.html
└── <saison>-<année>/           Dossier autonome par saison (landing)
    ├── index.html
    ├── theme.css               Palette saison (override variables)
    ├── images/                 Photos produits saison
    ├── JOURNAL.md              Suivi saison
    ├── IMAGES.md               Manifeste photos (référentiel)
    └── IMAGES-TODO.md          Photos manquantes ou approximatives
```

### Stack
HTML / CSS pur — pas de build, pas de framework, pas de JavaScript.
Hébergement : GitHub Pages servi depuis la branche `gh-pages`
(publiée par les workflows — voir section Déploiement de `CLAUDE.md`).

---

## Backlog transverse (toutes saisons)

### À faire
- [ ] Préparer le squelette `_template/` pour démarrer une nouvelle saison en 30 secondes (mentionné dans nos échanges, pas encore créé)
- [ ] Créer une vraie bannière Open Graph 1200×630 (actuellement = logo blanc, peu visible)
- [ ] Vérifier le rendu impression A4 (`@media print`) sur un vrai PDF — non testé sur une vraie imprimante
- [ ] Si le projet scale au-delà de 5-6 saisons : envisager `products.json` + script de build manuel pour éviter le HTML inline répétitif

### Idées / discussions futures
- Page « styleguide » qui affiche toutes les variables CSS avec un échantillon de chaque palette
- Index des produits récurrents (apparaissant dans plusieurs saisons) avec lien vers les saisons
- Statistiques de fréquentation GitHub Pages (Plausible / Goatcounter ?) — si Pitoeuf veut mesurer

---

## Historique macro

| Date | Événement |
|---|---|
| 2026-05-12 | Création tronc commun (variables CSS) + migration Pâques 2026 + landing Été 2026 (draft 2025). Merge PR #3. |
| 2026-05-28 | Newsletter restaurée (supprimée par erreur au #11), rangée dans `newsletter/`, couleurs alignées sur la charte. Doc déploiement corrigée (gh-pages). Merge PR #17. |

---

## Conventions

- Branche de travail : `claude/<scope>-XXXX`
- Commits : 1 sujet par commit, message en français, format court (`<verbe>: <quoi>`)
- PR : titre court + description structurée (Summary, Test plan)
- Aucun push direct sur `main` — toujours via PR mergée
- Voir `CLAUDE.md` pour les conventions techniques (images, badges, emojis, etc.)
