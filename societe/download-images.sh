#!/usr/bin/env bash
# =============================================================
# Pitoeuf SA — societe/ : téléchargement des images depuis pitoeuf.ch
# =============================================================
# Exécuter depuis n'importe quel environnement ayant accès à pitoeuf.ch.
# Idempotent : ne re-télécharge pas si le fichier existe déjà.
#
# Usage :
#   cd /chemin/vers/pitoeuf-saxon
#   bash societe/download-images.sh
#
# Après exécution, committer les images téléchargées :
#   git add societe/images/
#   git commit -m "feat(societe): images réelles depuis pitoeuf.ch"
# =============================================================

set -euo pipefail

DEST="$(dirname "$0")/images"
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0 Safari/537.36"

fetch() {
    local url="$1" out="$2"
    if [ -f "$DEST/$out" ]; then
        echo "  [skip] $out (déjà présent)"
        return
    fi
    echo "  [dl]   $out"
    curl -fsSL -A "$UA" "$url" -o "$DEST/$out"
}

echo "=== Téléchargement images societe/ ==="

# Photo principale — équipe / dépôt (version FR)
fetch \
    "https://pitoeuf.ch/wp-content/uploads/2023/10/xpitoeuf_3_FR.webp.pagespeed.ic.gLoP8x1FQc.webp" \
    "pitoeuf-equipe-fr.webp"

# Icônes piliers (PNG, ~100 px)
fetch \
    "https://pitoeuf.ch/wp-content/uploads/2022/03/Ellipse-0204.png.pagespeed.ce.o3DidcxCgq.png" \
    "icon-confiance.png"

fetch \
    "https://pitoeuf.ch/wp-content/uploads/2022/03/xEllipse-0203.png.pagespeed.ic.bY1HFL_9FF.png" \
    "icon-securite.png"

fetch \
    "https://pitoeuf.ch/wp-content/uploads/2022/03/Ellipse-0201.png.pagespeed.ce._4UXj2N_NI.png" \
    "icon-tracabilite.png"

# Icônes services shop
fetch \
    "https://pitoeuf.ch/wp-content/uploads/2021/08/xGroupe-287.png.pagespeed.ic.te2HF8dII9.png" \
    "icon-shop-commander.png"

fetch \
    "https://pitoeuf.ch/wp-content/uploads/2021/08/xGroupe-289.png.pagespeed.ic.RP4XpELP2J.png" \
    "icon-shop-prix.png"

fetch \
    "https://pitoeuf.ch/wp-content/uploads/2021/08/xGroupe-288.png.pagespeed.ic.PM_dxxcKKD.png" \
    "icon-shop-favoris.png"

fetch \
    "https://pitoeuf.ch/wp-content/uploads/2021/08/xGroupe-290.png.pagespeed.ic.fj6ushUkRZ.png" \
    "icon-shop-historique.png"

echo ""
echo "=== Terminé. Fichiers dans $DEST/ ==="
echo "Pensez à mettre à jour societe/index.html pour remplacer"
echo "les src placeholder par les vrais fichiers, puis :"
echo "  git add societe/images/ && git commit -m 'feat(societe): images réelles'"
