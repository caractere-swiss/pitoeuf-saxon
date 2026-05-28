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
- 2026-05-28 — Bouton « Ajouter » remplacé par l'**icône panier officielle**
  (`design-system/icons/panier.svg`, blanche sur bouton jaune). SVG pour la preview,
  **PNG à produire pour l'envoi Mailchimp**.
- 2026-05-28 — Icône panier rangée dans les assets partagés (`design-system/icons/`),
  réutilisable par les landings / futurs projets.

## Pistes abandonnées (héritage maquettes Gemini)

- Faux sélecteur de quantité `- 1 +` (non cliquable en email).
- Listes textuelles de catégories (remplacées par le bloc « Teaser »).
- Orange site `#E66624` / `#E85D22` sur toute la maquette → revenu à la charte.

---

## Checklist

### Vignette produit
- [x] Reconstruire les 6 cartes au style design-system (bandeau date, méta
      Réf/Provenance, badges, bandeau prix crème + cercle remise)
- [x] Intégrer l'icône panier (bouton jaune, à droite du bandeau prix)
- [ ] Remplacer les valeurs d'exemple (Réf., provenance, conditionnement, quantité)
      par les vraies données produit **avant envoi** ⚠️
- [ ] Produire le PNG du panier pour Mailchimp (SVG ok en preview navigateur,
      pas en email) ⚠️
- [ ] Vérifier rendu badges/cercle remise dans Outlook (border-radius dégradé)

### Avant envoi (ops / client)
- [ ] Validation finale par Olivier
- [ ] Intégration dans le template Mailchimp
- [ ] Vérifier merge tags Mailchimp (`*|UNSUB|*` ok ; besoin de `*|FNAME|*`, `*|ARCHIVE|*` ?)
- [ ] Segmentation Mailchimp : footer « Devenez client » (prospects) vs « Mon compte » (clients)
- [ ] Tests de rendu (Gmail, Outlook, Apple Mail)
- [ ] Communiquer la nouvelle URL preview au client (l'ancien lien iliasfun est mort)

---

## PRs

| PR | Sujet | Branche | Statut |
|---|---|---|---|
| #17 | Restauration + organisation + couleurs charte | `claude/nice-galileo-zFUNp` | ✅ mergée |
| #18 | Cohérence doc (déploiement gh-pages) + portail « Projets internes » | `claude/doc-coherence-Kp3mq` | 🟡 ouverte |
| (à venir) | Vignette produit au style design-system + icône panier | `claude/newsletter-vignette-DS-9xQ2` | 🟡 en cours |

## Règle de scope (session)

- Modifier **uniquement** `newsletter/` (+ assets partagés `design-system/` si
  explicitement demandé). **Ne pas toucher `ete-2026/`** ni les autres landings —
  lecture seule pour référence.
