# Journal — Newsletter Pitoeuf SA

> Source de vérité opérationnelle du projet newsletter. À LIRE en début de
> session pour reprendre le fil. Toute décision (même prise ailleurs, ex.
> brainstorming claude.ai) doit être consignée ici pour ne jamais reperdre
> le contexte.

---

## Contexte projet

- **Livrable** : newsletter promotionnelle « Actions de la semaine » (email HTML).
- **Client** : Pitoeuf SA — Route d'Ecône 116, 1907 Saxon (Valais). info@pitoeuf.ch
- **Contact** : Olivier.
- **Outil d'envoi** : Mailchimp (variable `*|UNSUB|*` présente, images footer sur mcusercontent.com).
- **Fichier** : `newsletter/index.html`.
- **URL preview (après merge dans `main`)** : https://caractere-swiss.github.io/pitoeuf-saxon/newsletter/

## Contraintes techniques (email HTML)

- Mise en page 100 % `<table>` + CSS inline / `<style>` (compat Outlook via MSO).
- **Pas de CSS externe ni de variables CSS** → impossible d'importer `product-card.css`
  du design-system ; la vignette est répliquée à la main, alignée sur la charte.
- **Pas de SVG** dans l'email (Gmail/Outlook le suppriment) → prévoir des PNG.
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
  crème avec cercle remise + bloc prix. (en cours)
- 2026-05-28 — Icône panier rangée dans les assets partagés (`design-system/icons/`),
  réutilisable par les landings / futurs projets.
- 2026-05-28 — Badges (conditionnement + origine) avec les vrais assets
  design-system (`surgele.svg`, `frais.svg`, `drapeau-ch.png`) au lieu des
  anciennes pastilles texte. D'abord en overlay `position:absolute`, puis
  basculés en **bande au-dessus de la photo** (email-safe : Outlook/Gmail
  ignorent `position:absolute`).
- 2026-05-28 — **Bouton panier retiré** de la vignette : inutile en email (le
  sélecteur de quantité n'existe que sur le site). `panier.svg` reste dans le
  design-system pour les landings.
- 2026-05-28 — **Hauteur des cartes uniformisée** : chaque vignette est une
  `<table height="100%">` à 2 lignes (corps `valign=top` / bandeau prix
  `valign=bottom`) + `min-height:42px` sur `.card-title` (réserve 2 lignes).
  Les cartes d'une même ligne s'alignent, titres courts ou longs.

## Pistes abandonnées (héritage maquettes Gemini)

- Faux sélecteur de quantité `- 1 +` (non cliquable en email).
- Listes textuelles de catégories (remplacées par le bloc « Teaser »).
- Orange site `#E66624` / `#E85D22` sur toute la maquette → revenu à la charte.

---

## Checklist

### Vignette produit
- [x] Reconstruire les 6 cartes au style design-system (bandeau date, méta
      Réf/Provenance, badges, bandeau prix crème + cercle remise)
- [x] Badges conditionnement + origine en bande haut-gauche email-safe (assets DS)
- [x] Bouton panier retiré (inutile en email)
- [x] Hauteur des cartes uniformisée (table height=100% + min-height titre)
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
- [ ] Communiquer la nouvelle URL preview au client (l'ancien lien iliasfun est mort)

---

## Questions client en attente (à répondre plus tard)

### Q1 — Détection « client déjà enregistré sur le shop » selon l'adresse email

**Question (Olivier, 2026-05-28)** : a-t-on l'info, selon l'adresse de réception
de l'e-mail, si le destinataire est **déjà enregistré sur le shop** ? Quel
concept pourrait-on mettre en place ? L'idée est aussi de **capter l'intérêt
du client**.

**Statut** : 🟡 à creuser — réponse à formuler plus tard.

**Pistes à explorer** (notes de travail, à valider) :
- Mailchimp peut **segmenter** une audience (tags / groupes / champs perso).
  Si la base d'inscrits porte un attribut « compte shop = oui/non » (synchronisé
  depuis WooCommerce/pitoeuf.ch), on peut afficher un **contenu conditionnel**
  (blocs « Devenez client » vs « Mon compte / Mes commandes ») selon le segment.
- Le lien dépend donc d'une **synchro Mailchimp ↔ boutique** (plugin
  WooCommerce↔Mailchimp, ou export régulier de la liste clients). À vérifier :
  cette synchro existe-t-elle déjà côté Pitoeuf ?
- Côté « capter l'intérêt » : personnalisation (`*|FNAME|*`), bloc CTA différent
  selon prospect/client, voire reco produits. À cadrer une fois la donnée dispo.

> ⚠️ Ne PAS confondre avec la segmentation footer déjà notée (« Devenez client »
> vs « Mon compte ») : c'est le même sujet vu côté ops. Cette Q1 demande d'abord
> de **confirmer la disponibilité de la donnée** avant tout concept.

---

## PRs

| PR | Sujet | Branche | Statut |
|---|---|---|---|
| #17 | Restauration + organisation + couleurs charte | `claude/nice-galileo-zFUNp` | ✅ mergée |
| #18 | Cohérence doc (déploiement gh-pages) + portail « Projets internes » | `claude/doc-coherence-Kp3mq` | 🟡 ouverte |
| #19 | Vignette produit style DS : badges overlay, panier retiré, hauteur uniforme | `claude/newsletter-vignette-DS-9xQ2` | 🟡 en cours |

## Règle de scope (session)

- Modifier **uniquement** `newsletter/` (+ assets partagés `design-system/` si
  explicitement demandé). **Ne pas toucher `ete-2026/`** ni les autres landings —
  lecture seule pour référence.
