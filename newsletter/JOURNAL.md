# Journal — Newsletter Pitoeuf SA

> Source de vérité opérationnelle du projet newsletter. À LIRE en début de
> session pour reprendre le fil. Toute décision (même prise ailleurs, ex.
> brainstorming claude.ai) doit être consignée ici pour ne jamais reperdre
> le contexte.
>
> Dernière mise à jour : 2026-06-23

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
- **Christophe Vuignier** — informaticien Pitoeuf. Relais pour le technique boutique :
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
  - ⚠️ `CLAUDE.md` (racine) décrit à tort `pages.yml` + « GitHub Actions mode » → à corriger dans une PR dédiée.

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
- Jaune CTA Pitoeuf : `#F9A600`
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
  anciennes pastilles texte. Basculés en **bande au-dessus de la photo**
  (email-safe : Outlook/Gmail ignorent `position:absolute`). (PR #19)
- 2026-05-28 — **Bouton panier retiré** de la vignette : inutile en email (le
  sélecteur de quantité n'existe que sur le site). `panier.svg` reste dans le
  design-system pour les landings. (PR #19)
- 2026-05-28 — **Hauteur des cartes uniformisée** : chaque vignette est une
  `<table height="100%">` à 2 lignes (corps `valign=top` / bandeau prix
  `valign=bottom`) + `min-height:40px` sur `.card-title` (réserve 2 lignes).
  Les cartes d'une même ligne s'alignent, titres courts ou longs. (PR #19)
- 2026-05-28 — Bloc « avantages » du footer élargi à 600px (retrait du padding
  horizontal) pour matcher la largeur de la section produits. (PR #19)

### DIG-003 — Layout & typo (retours Olivier + Christophe du 03.06) — ⏳ PR #22, en attente validation Olivier

- 2026-06-23 — **Grille produits : 3 → 4 colonnes à 740px.**
  Olivier a précisé vouloir **4 articles/ligne** comme le site. 4 fiches ne tenant
  pas à 600px (bandeau prix cassé à ~150px), **élargissement à 680px** d'abord,
  puis **à 740px sur demande** pour plus de confort visuel. Fiche compactée :
  cercle remise 42→34px, badges 28→24px, promo 11→10px.
  Typo finale **alignée sur le site** : titre 16px, méta 12px (PR #19 re-validée).
  ⚠️ **Outlook desktop ne fait pas de responsive** → 740px fixe assumé (léger
  surplus vs standard 600px, scroll marginal). 8 produits = grille 2×4 parfaite.
  Mobile : 4 → 2 colonnes via `display:inline-block; width:50%` sur les `<td>`.

- 2026-06-23 — **Police de marque Roboto** (le site est en `"Roboto", sans-serif`).
  Chargée via `<link>` Google Fonts sous conditionnel MSO (`<!--[if !mso]><!-->`).
  Stack : `'Roboto', Helvetica, Arial, sans-serif`. Amélioration progressive :
  Apple Mail/iOS/Gmail Android affichent Roboto (= site), Outlook/Gmail web
  retombent sur Arial. Les polices web ne sont PAS fiables en email → bonne approche.

- 2026-06-23 — **Logo compact 1947** : `variante_5.png` (ratio 3.76:1, peu lisible
  mobile) remplacé par `images/logos/1947/logo_pitoeuf_1947_FR.png` (ratio 2.08:1,
  identique au header du site : gris + « DEPUIS 1947 » orange). Centré, max-width
  300px desktop / 280px mobile. **Logos Pitoeuf centralisés** dans `images/logos/`
  (9 fichiers : gris/noir/blanc + variantes 1947 FR/DE), poussés sur `main` →
  fin du hotlink pitoeuf.ch pour le logo. Variante `_DE` prête pour version allemande.

- 2026-06-23 — **Responsive mobile** : plusieurs bugs corrigés dans la même session.
  - **Overflow droit** : table principale avait `width:740px` fixe en inline style.
    Corrigé → `width:100%; max-width:740px`. Tous les blocs footer passent en
    `class="wrapper"` pour que la media query s'applique uniformément.
  - **box-sizing sur `.footer-text-col`** : `width:100%` + `padding:15px` sans
    `box-sizing:border-box` ajoutait 30px de trop → corrigé.
  - **Barre nav orange** : liens `inline-block` (5 liens) dépassaient le viewport.
    Corrigé → `font-size:12px`, `padding:6px`, `overflow:hidden` sur le conteneur.
    Séparateurs `|` masqués sur mobile (`class="nav-sep"`, `display:none !important`).
  - **Images partenaires** : `align="left"` / `align="right"` → `align="center"` +
    `margin:0 auto` sur les images → répartition homogène desktop, empilé centré mobile.

- 2026-06-23 — **Durcissement Outlook** (fonds colorés + a11y) :
  - `bgcolor` ajouté sur les tables portant un fond coloré : `#F2F2F2` (fond gris
    global), `#ffffff` (contenu principal), `#F9A600` (nav orange), `#ffffff` (avantages).
  - `role="presentation"` ajouté sur les 20 tables de mise en page → lecteurs d'écran
    ne les traitent plus comme des tableaux de données.

- 2026-06-23 — **Bugs HTML corrigés** :
  - Attributs `alt` cassés par des guillemets droits `"` dans les valeurs
    (« Courge en cube "Suisse" », « Saumon cru "Premium" ») → remplacés par
    guillemets typographiques `« »`. Titres affichés alignés en conséquence.
  - `lang="fr"` ajouté sur `<html>` (a11y + clients mail).

## Pistes abandonnées (héritage maquettes Gemini)

- Faux sélecteur de quantité `- 1 +` (non cliquable en email).
- Listes textuelles de catégories (remplacées par le bloc « Teaser »).
- Orange site `#E66624` / `#E85D22` sur toute la maquette → revenu à la charte.
- Badges en overlay `position:absolute` → abandonné au profit d'une bande (email-safe).

---

## Checklist

### Vignette produit
- [x] Reconstruire les 8 cartes au style design-system (bandeau date, méta
      Réf/Provenance, badges, bandeau prix crème + cercle remise)
- [x] Badges conditionnement + origine en bande haut-gauche email-safe (assets DS)
- [x] Bouton panier retiré (inutile en email)
- [x] Hauteur des cartes uniformisée (table height=100% + min-height titre)
- [x] Grille 4 colonnes à 740px, responsive 2 colonnes mobile
- [x] Typo alignée sur le site : 16px titre, 12px méta
- [x] Durcissement Outlook : bgcolor + role=presentation
- [ ] Remplacer les 8 produits test par les vraies données (Réf., provenance,
      prix, photos) **avant chaque envoi** ⚠️
- [ ] Remplacer les dates en dur (« jusqu'au 23.02 ») dans chaque bandeau promo ⚠️

### 🅿️ En standby (à traiter à l'occasion)

- **Icônes SVG → PNG** : `surgele.svg` et `frais.svg` ne s'affichent PAS dans
  Gmail/Outlook (SVG non supporté en email). Produire des PNG (56×56 px pour
  la netteté retina) et pointer dessus dans la newsletter. *(Export côté client
  ou installer un convertisseur lors d'une prochaine session.)*
- **Pictos emoji du bloc avantages** (👤 🛒 💳) : rendu variable selon les clients
  mail (noir & blanc, voire absents sous Outlook). À remplacer par des icônes PNG.
- **Correction CLAUDE.md racine** : décrit à tort `pages.yml` + « GitHub Actions
  mode » → corriger en `deploy.yml` + JamesIves → gh-pages. PR #18 fermée
  (conflit dirty) ; à refaire dans une PR dédiée propre.

### ⚠️ Risques email à arbitrer AVANT envoi Mailchimp

1. ~~Badges en overlay `position:absolute`~~ ✅ **réglé**.
2. **Images produits hotlinkées depuis pitoeuf.ch** : le hotlinking est bloqué
   → les ré-héberger dans Mailchimp Content Studio avant envoi.
3. **Badges SVG** : `surgele.svg` / `frais.svg` invisibles dans Gmail/Outlook.
   → produire des PNG (cf. standby ci-dessus).
4. `border-radius` / `box-shadow` : ignorés par Outlook — dégradation acceptable.

### Avant envoi (ops / client)
- [ ] Validation finale par Olivier (preview PR #22)
- [ ] Merge PR #22 dans `main`
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
→ **à vérifier avec Christophe Vuignier (informaticien)**.

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
| #18 | Cohérence doc + portail « Projets internes » | `claude/doc-coherence-Kp3mq` | 🔴 fermée (conflit dirty + description déploiement inexacte) |
| #19 | Vignette produit style DS : badges email-safe, panier retiré, hauteur uniforme | `claude/newsletter-vignette-DS-9xQ2` | ✅ mergée |
| #22 | DIG-003 : grille 4 col 740px, Roboto, typo 16/12, logo 1947, mobile, Outlook | `claude/newsletter-dig003-layout-typo` | ⏳ ouverte, attente validation Olivier (preview) |

> **#18 — fermée** : PR en conflit et description de déploiement incorrecte
> (décrivait à tort le mode « GitHub Actions » au lieu de JamesIves → gh-pages).
> ⚠️ La fermeture via `gh` CLI / MCP GitHub est à faire manuellement si pas encore
> effectuée — les outils GitHub n'étaient pas disponibles en fin de session 2026-06-23.
> Le contenu utile (correction `CLAUDE.md`) sera traité dans une PR dédiée.

## Règle de scope (session)

- Modifier **uniquement** `newsletter/` (+ assets partagés `design-system/` si
  explicitement demandé, + docs racine si explicitement demandé). **Ne pas
  toucher `ete-2026/`** ni les autres landings — lecture seule pour référence.
