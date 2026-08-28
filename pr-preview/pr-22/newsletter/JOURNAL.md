# Journal — Newsletter Pitoeuf SA

> Source de vérité opérationnelle du projet newsletter. À LIRE en début de
> session pour reprendre le fil. Toute décision (même prise ailleurs, ex.
> brainstorming claude.ai) doit être consignée ici pour ne jamais reperdre
> le contexte.
>
> Dernière mise à jour : 2026-08-28

---

## Contexte projet

- **Livrable** : newsletter promotionnelle « Actions de la semaine » (email HTML).
- **Client** : Pitoeuf SA — Route d'Ecône 116, 1907 Saxon (Valais). info@pitoeuf.ch
- **Agence** : Caractère Communication (caractere.swiss).
- **Outil d'envoi** : Mailchimp (variable `*|UNSUB|*` présente, images footer sur mcusercontent.com).
- **Fichier** : `newsletter/index.html`.
- **URL live** (active après merge dans `main`) :
  https://caractere-swiss.github.io/pitoeuf-saxon/newsletter/

### Contacts

- **Olivier Pitteloud** — interlocuteur principal client (`olivier.pitteloud@pitoeuf.ch`).
- **Christophe** — informaticien Pitoeuf. Relais pour le technique boutique :
  synchro WooCommerce ↔ Mailchimp, données clients, webshop. (À solliciter pour Q1.)

### Infra / hébergement

- Repo GitHub : `caractere-swiss/pitoeuf-saxon` (ancienne org `iliasfun` migrée →
  **tous les liens `iliasfun.github.io` sont morts**).
- Déploiement via **branche `gh-pages`** (mode « Deploy from a branch » dans Settings → Pages) :
  - `deploy.yml` → prod, déclenché sur push vers `main`.
    Utilise `JamesIves/github-pages-deploy-action@v4` → pousse tout le repo dans la branche `gh-pages`.
    ⚠️ Ce n'est **PAS** le mode « GitHub Actions » (pas de `configure-pages` / `upload-pages-artifact`).
  - `preview.yml` → previews de PR via `rossjrw/pr-preview-action@v1`, qui écrit aussi dans `gh-pages`
    sous `/pr-preview/pr-N/`.
  - `.nojekyll` à la racine (désactive Jekyll).
  - ⚠️ `CLAUDE.md` (racine) décrit à tort `pages.yml` + « GitHub Actions mode » → source d'erreur à corriger (cf. PR #18).

## Contraintes techniques (email HTML)

- Mise en page 100 % `<table>` + CSS inline / `<style>` (compat Outlook via MSO).
- **Pas de CSS externe ni de variables CSS** → impossible d'importer `product-card.css`
  du design-system ; la vignette est répliquée à la main, alignée sur la charte.
- **Pas de SVG** dans l'email (Gmail/Outlook le suppriment) → prévoir des PNG.
- **Pas de `position:absolute`** fiable (Outlook l'ignore, Gmail le dégrade).
- **Pas de JS** (pas de vrai sélecteur de quantité).
- Images pitoeuf.ch : hotlinking bloqué → héberger localement / Mailchimp.

## Charte (couleurs marque immuables)

- Rouge promo (bandeau + cercle remise) : `#f95600`
- Beige bandeau prix : `#fff6e3`
- Rouge CH/VS : `#d52b1e`
- Bleu Surgelé : `#4aa8d8`
- Orange institutionnel (corporate) : `#f9a600` — sert aussi de couleur CTA Pitoeuf.
  Source de vérité : `design-system/tokens.css` (PR #21). ⚠️ Ne PAS confondre
  avec le rouge promo `#f95600`. L'ancien orange site `#E66624` est abandonné.
- Prix (vignette design-system) : near-black `#1a1a1a`

---

## Décisions validées

- 2026-05-28 — Newsletter restaurée (avait été supprimée par erreur au commit #11),
  rangée dans `newsletter/`, couleurs alignées sur la charte. (PR #17, mergée)
- 2026-05-28 — Vignette produit alignée sur le style design-system (réf. = carte
  « Bœuf » d'Été 2026) : bandeau promo avec date, méta Réf/Provenance, bandeau prix
  crème avec cercle remise + bloc prix. (PR #19, mergée)
- 2026-05-28 — Badges (conditionnement + origine) avec les vrais assets
  design-system (`surgele.svg`, `frais.svg`, `drapeau-ch.png`) au lieu des
  anciennes pastilles texte. D'abord en overlay `position:absolute`, puis
  basculés en **bande au-dessus de la photo** (email-safe : Outlook/Gmail
  ignorent `position:absolute`). (PR #19)
- 2026-05-28 — **Bouton panier retiré** de la vignette : inutile en email (le
  sélecteur de quantité n'existe que sur le site). `panier.svg` reste dans le
  design-system pour les landings. (PR #19)
- 2026-05-28 — **Hauteur des cartes uniformisée** : chaque vignette est une
  `<table height="100%">` à 2 lignes (corps `valign=top` / bandeau prix
  `valign=bottom`) + `min-height:42px` sur `.card-title` (réserve 2 lignes).
  Les cartes d'une même ligne s'alignent, titres courts ou longs. (PR #19)
- 2026-05-28 — Bloc « avantages » du footer élargi à 600px (retrait du padding
  horizontal) pour matcher la largeur de la section produits. (PR #19)

- 2026-06-23 — **Token couleur transverse (brief page Société, PR #21).**
  Création de `design-system/tokens.css` : source de vérité unique couleurs +
  typo cross-projet. L'orange institutionnel est officialisé à **`#f9a600`**
  (doré/ambre), l'ancien `#E66624` est abandonné. Le rouge promo `#f95600`
  reste immuable. **Impact newsletter : nul** — `index.html` utilise déjà
  `#F9A600` partout (titres, encadré « Devenez client », bouton, liens footer)
  et aucun `#E66624`/`#E85D22` ne traîne. La newsletter ne peut pas importer
  `tokens.css` (Outlook : pas de CSS externe ni de variables) → alignement
  manuel, déjà conforme. Roboto/Google Fonts inapplicable à l'email : inchangé.

### DIG-003 — Layout & typo (retours Olivier + Christophe du 03.06) — ✅ PR #22 validée par Olivier le 25.08.2026

- 2026-06-23 — **Grille produits : 3 → 2 → finalement 4 colonnes à 680px.**
  1er essai 2 col (interprétation « fiche large comme le site »). Olivier a
  précisé vouloir **4 articles/ligne** comme le site. Comme 4 fiches ne tiennent
  pas à 600px (bandeau prix cassé à ~150px), **élargissement à 680px** + fiche
  compactée. ⚠️ **Outlook desktop ne fait pas de responsive** → la largeur 680px
  est fixe et assumée (risque scroll faible, surplus léger vs 600). 6 produits =
  ligne 1 (4 fiches) + ligne 2 (2 fiches centrées via spacers) ; avec 8 produits
  réels → grille 2×4 parfaite. Mobile : 4 → 2 colonnes.

### Post-validation Olivier (25.08.2026) — ⏳ PR #22 ouverte, en attente merge

- 2026-08-28 — **Élargissement 740px → 800px** (demande Olivier en séance du
  25.08). 7 occurrences `max-width: 740px` → `800px` + media query breakpoint
  740 → 800. Fiches produit : `width="150"` → `width="180"` (8 photos). Outlook
  desktop : largeur fixe assumée, pas de responsive ajouté.
- 2026-08-28 — **Changement de cadrage modèle de référence** (décision séance
  25.08) : la newsletter finale n'est plus générée par nous. Un outil tiers côté
  Pitoeuf produit l'envoi (produits + rabais) → Mailchimp expédie. Ce fichier
  devient un **modèle de référence** à transmettre. Conséquence : ne plus
  chercher à remplacer les données produit d'exemple par des données réelles.
- 2026-08-28 — **Badges SVG → PNG : bloqué.** Fichiers `surgele-56.png` et
  `frais-56.png` annoncés dans le brief mais absents du repo
  `design-system/icons/`. SVG maintenus en l'état (ils fonctionnent en
  navigateur pour la preview). À débloquer quand Ilias fournit les PNG.
- 2026-08-28 — **PR #18 fermée** (doc-coherence, était en conflit depuis juin,
  description du déploiement inexacte). Nettoyage sans correction alternative
  (la PR n'avait pas de valeur ajoutée suffisante pour un refaire).
- 2026-06-23 — **Fiche compactée pour la densité 4 col** (~150px/colonne) :
  titre 18→14px, méta 13→11px, cercle remise 42→34px, prix 16→15px, badges
  28→24px, promo 11→10px. ⚠️ Touche la vignette validée PR #19 → **re-validation
  Olivier requise** sur la preview.
- 2026-06-23 — **Police de marque Roboto** (le site est en `"Roboto", sans-serif`).
  Chargée via `<link>` Google Fonts sous conditionnel MSO ; stack
  `'Roboto', Helvetica, Arial, sans-serif`. Amélioration progressive : Apple
  Mail/iOS/Gmail Android affichent Roboto (= site), Outlook/Gmail web retombent
  sur Arial (proche). Les polices web ne sont PAS fiables en email → c'est la
  bonne approche (pas de `@font-face` obligatoire).
- 2026-06-23 — **Hiérarchie typo agrandie** (Christophe : « tout un peu plus
  grand ») : titres 16→18px, méta 12→13px, plus de respiration dans les fiches.
- 2026-06-23 — **Logo compact 1947** : `variante_5.png` (ratio 3.76:1, peu
  lisible mobile) remplacé par `images/logos/1947/logo_pitoeuf_1947_FR.png`
  (ratio 2.08:1, identique au header du site : gris + « DEPUIS 1947 » orange).
  Affiché centré max-width 300/280px. **Logos Pitoeuf centralisés** dans
  `images/logos/` (9 fichiers : gris/noir/blanc + variantes 1947 FR/DE),
  poussés sur `main` → fin du hotlink pitoeuf.ch pour le logo. Variante `_DE`
  prête pour la future version allemande.

## Pistes abandonnées (héritage maquettes Gemini)

- Faux sélecteur de quantité `- 1 +` (non cliquable en email).
- Listes textuelles de catégories (remplacées par le bloc « Teaser »).
- Orange site `#E66624` / `#E85D22` sur toute la maquette → revenu à la charte.
- Badges en overlay `position:absolute` → abandonné au profit d'une bande (email-safe).

---

## Checklist

### Vignette produit
- [x] Reconstruire les 6 cartes au style design-system (bandeau date, méta
      Réf/Provenance, badges, bandeau prix crème + cercle remise)
- [x] Badges conditionnement + origine en bande haut-gauche email-safe (assets DS)
- [x] Bouton panier retiré (inutile en email)
- [x] Hauteur des cartes uniformisée (table height=100% + min-height titre)
- [x] Bloc avantages aligné sur 600px
- [ ] Remplacer les valeurs d'exemple (Réf., provenance, conditionnement, quantité)
      par les vraies données produit **avant envoi** ⚠️

### 🅿️ En standby (à traiter à l'occasion)

- **Icônes SVG → PNG** : `surgele.svg` et `frais.svg` ne s'affichent PAS dans
  Gmail/Outlook (SVG non supporté en email). Produire des PNG (ex. 56×56 px
  pour la netteté retina) et pointer dessus dans la newsletter. *(Pas d'outil
  de conversion SVG→PNG dans l'environnement Claude → à exporter côté client,
  ou installer un convertisseur lors d'une prochaine session.)*
- **Pictos emoji du bloc avantages** (👤 🛒 💳) : la charte projet recommande
  d'éviter les emojis Unicode (rendu variable selon les clients mail — noir &
  blanc, voire absents sous Outlook). À remplacer par des icônes image (PNG).

### ⚠️ Risques email à arbitrer AVANT envoi Mailchimp

Le rendu est nickel en preview navigateur, mais l'email a des contraintes que
le navigateur n'a pas. À trancher avec Olivier / tester avant diffusion :

1. ~~Badges en overlay `position:absolute`~~ ✅ **réglé** : basculés en bande
   au-dessus de la photo (email-safe).
2. **Images produits hotlinkées depuis pitoeuf.ch** : le hotlinking est bloqué
   → en email elles peuvent ne pas charger. Les ré-héberger dans Mailchimp
   (upload dans le Content Studio) avant envoi.
3. `border-radius` / `box-shadow` : ignorés par Outlook (coins droits, pas
   d'ombre) — dégradation acceptable, à valider visuellement.

### Avant envoi (ops / client)
- [ ] Validation finale par Olivier
- [ ] Intégration dans le template Mailchimp
- [ ] Vérifier merge tags Mailchimp (`*|UNSUB|*` ok ; besoin de `*|FNAME|*`, `*|ARCHIVE|*` ?)
- [ ] Segmentation Mailchimp : footer « Devenez client » (prospects) vs « Mon compte » (clients)
- [ ] Tests de rendu (Gmail, Outlook, Apple Mail) — idéalement via Litmus / Email on Acid
- [ ] Communiquer la nouvelle URL live au client (l'ancien lien iliasfun est mort)

---

## Questions client en attente

### Q1 — Détection « client déjà enregistré sur le shop » selon l'adresse email

**Question (Olivier, retour du 2026-02-18)** : a-t-on l'info, selon l'adresse de
réception de l'e-mail, si le destinataire est **déjà enregistré sur le shop** ?
Quel concept pourrait-on mettre en place ? L'idée est aussi de **capter
l'intérêt du client**.

**Statut** : 🟡 en attente — brouillon de réponse créé dans Gmail (fil « Refonte
newsletter », **non envoyé**, en attente d'envoi puis du retour d'Olivier).

**Réponse donnée** : faisable via **contenu conditionnel Mailchimp** (ex.
« Créez votre compte » pour un prospect vs « Accédez à votre compte » pour un
client). Préalable technique : une synchro liste clients boutique ↔ Mailchimp
→ **à vérifier avec Christophe (informaticien)**.

**Prochaines étapes** :
1. Envoyer le brouillon à Olivier (attendre son retour).
2. Se renseigner avec Christophe sur la synchro existante.
3. Une fois la donnée confirmée → cadrer le concept de perso (prospect vs client,
   CTA différencié, éventuelle reco produits).

> ⚠️ Même sujet que la ligne « segmentation footer » de la checklist, mais vu
> côté concept. Confirmer d'abord la **disponibilité de la donnée** avant tout.

---

## PRs

| PR | Sujet | Branche | Statut |
|---|---|---|---|
| #17 | Restauration + organisation + couleurs charte | `claude/nice-galileo-zFUNp` | ✅ mergée |
| #18 | Cohérence doc + portail « Projets internes » | `claude/doc-coherence-Kp3mq` | 🔴 fermée (28.08.2026) |
| #19 | Vignette produit style DS : badges email-safe, panier retiré, hauteur uniforme | `claude/newsletter-vignette-DS-9xQ2` | ✅ mergée |
| #22 | DIG-003 : grille 4 col, police Roboto, typo agrandie, logo compact 1947, 800px | `claude/newsletter-dig003-layout-typo` | ⏳ ouverte — validée Olivier 25.08, attente merge par Ilias |

> **#18 — décision en attente** : la PR est en conflit (`dirty`) ET sa description
> du déploiement est inexacte (elle dit que `deploy.yml` pousse sur `gh-pages` ;
> en réalité la prod passe par les actions GitHub Pages, `gh-pages` ne sert qu'aux
> previews). Recommandation : **la fermer** et refaire une petite correction de doc
> exacte (corriger le nom `pages.yml` → `deploy.yml` + mentionner `preview.yml`,
> renommer le portail « Projets internes », ajouter newsletter/design-system dans
> `MASTER.md`).

## Règle de scope (session)

- Modifier **uniquement** `newsletter/` (+ assets partagés `design-system/` si
  explicitement demandé, + docs racine si explicitement demandé). **Ne pas
  toucher `ete-2026/`** ni les autres landings — lecture seule pour référence.

### Répartition des rôles (ne pas déborder)

- **Pilotage projet / relation client / emails** → géré par le chat
  `3.solution-marketing`. C'est lui qui programme et envoie les mails (Olivier,
  Christophe…), cadre le concept et pilote le planning.
- **Ce chat (newsletter) = opérationnel pur** : code `newsletter/index.html`,
  rendu email, conformité charte, commits/PR. **Je n'envoie pas de mail client
  et ne pilote pas le projet.** Si une décision client/mail est nécessaire,
  je la remonte — c'est `3.solution-marketing` qui la porte.
