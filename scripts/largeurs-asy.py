#!/usr/bin/env python3
"""Largeurs des figures Asymptote, réglées par la hauteur affichée.

La hauteur d'une figure à l'écran vaut (largeur attribuée) x (proportions
hauteur/largeur de la figure). Pour que toutes les figures 3D aient à peu
près la même hauteur, on fixe une hauteur cible H (en fraction de la largeur
du texte) et on en déduit la largeur : largeur = H / proportions, bornée.

- Figure dans un <sidebyside> : la colonne de la figure prend cette largeur,
  la colonne de texte prend le reste (moins un espace de 5 %), ou bien la
  largeur fixée par --texte (l'espace entre les colonnes prend alors le reste).
- Figure seule : attribut width de <image>.

Les proportions sont lues dans les fichiers HTML générés
(generated-assets/asymptote/<xml:id>.html) : lancer d'abord
`pretext generate asymptote -t web`.

Le script sert à donner une largeur de DÉPART à une figure qu'on vient de
convertir. Une fois la figure réglée à l'oeil dans le .ptx, on ne relance plus
le script sur elle : il écraserait le réglage. D'où l'option --xmlid, exigée
pour appliquer (sauf --tout, à n'utiliser qu'en connaissance de cause).

Usage :
    python3 scripts/largeurs-asy.py [--hauteur 0.40] [--texte 50] [--fichier Sec-Courbes]
    python3 scripts/largeurs-asy.py --xmlid asy-ma-figure [--hauteur 0.40] [--texte 50] --appliquer
Sans --appliquer, le script affiche seulement les changements proposés.
"""
import argparse
import glob
import re
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
ESPACE = 5          # espace entre les colonnes d'un sidebyside, en %
LMIN, LMAX = 30, 60  # bornes de la largeur d'une figure, en %


def proportions(xmlid):
    """Hauteur/largeur de la figure, lue dans le HTML généré."""
    f = RACINE / "generated-assets" / "asymptote" / f"{xmlid}.html"
    if not f.exists():
        return None
    m = re.search(r'<canvas[^>]*width="(\d+)"[^>]*height="(\d+)"', f.read_text())
    return int(m.group(2)) / int(m.group(1)) if m else None


def largeur(xmlid, h):
    p = proportions(xmlid)
    if p is None:
        return None, None
    return p, max(LMIN, min(LMAX, round(100 * h / p)))


def traiter(fichier, h, appliquer, texte=None, cibles=None):
    s = fichier.read_text()
    changements = []   # (début, fin, ancien, nouveau, description)
    for m in re.finditer(r'<image xml:id="(asy-[^"]+)"([^>]*)>', s):
        xmlid = m.group(1)
        if cibles and xmlid not in cibles:
            continue
        p, l = largeur(xmlid, h)
        if l is None:
            print(f"  {xmlid} : HTML généré introuvable, ignoré")
            continue
        avant = s[:m.start()]
        o, c = avant.rfind("<sidebyside"), avant.rfind("</sidebyside>")
        if o > c:   # la figure est dans un sidebyside
            fin = s.index(">", o)
            balise = s[o:fin]
            fin_sbs = s.index("</sidebyside>", o)
            if s[o:fin_sbs].count("<figure") > 1 or s[o:fin_sbs].count("<image") > 1:
                print(f"  {xmlid} : sidebyside de plusieurs figures ou images, laissé tel quel")
                continue
            w = re.search(r'widths="([^"]*)"', balise)
            if not w:
                print(f"  {xmlid} : sidebyside sans widths, ignoré")
                continue
            n = len(w.group(1).split())
            t = 100 - ESPACE - l
            if texte:   # texte fixé, mais jamais au point de dépasser 100 %
                t = min(texte, t)
            if n == 3:
                nouv = f"{t}% {100 - t - l}% {l}%"
            elif n == 2:
                nouv = f"{t}% {l}%"
            else:
                print(f"  {xmlid} : sidebyside à {n} colonnes, ignoré")
                continue
            if w.group(1) != nouv:
                a, b = o + w.start(1), o + w.end(1)
                changements.append((a, b, w.group(1), nouv,
                                    f"{xmlid} (h/l = {p:.2f}) sidebyside"))
        else:       # figure seule
            attrs = m.group(2)
            w = re.search(r'width="([^"]*)"', attrs)
            nouv = f"{l}%"
            if w and w.group(1) != nouv:
                a = m.start(2) + w.start(1)
                b = m.start(2) + w.end(1)
                changements.append((a, b, w.group(1), nouv, f"{xmlid} (h/l = {p:.2f}) seule"))
            elif not w:
                a = b = m.end(2)
                changements.append((a, b, "", f' width="{nouv}"', f"{xmlid} (h/l = {p:.2f}) seule"))
    for a, b, anc, nouv, d in changements:
        print(f"  {d} : {anc or '(aucune)'} -> {nouv.strip()}")
    if appliquer and changements:
        for a, b, anc, nouv, d in sorted(changements, reverse=True):
            s = s[:a] + nouv + s[b:]
        fichier.write_text(s)
    return len(changements)


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--hauteur", type=float, default=0.40,
                    help="hauteur cible, en fraction de la largeur du texte (0.40)")
    ap.add_argument("--texte", type=int, default=None,
                    help="largeur fixe de la colonne de texte d'un sidebyside, en %%")
    ap.add_argument("--fichier", default="", help="ne traiter que les fichiers dont le nom contient ce texte")
    ap.add_argument("--xmlid", nargs="+", default=None, help="ne traiter que ces figures (xml:id)")
    ap.add_argument("--appliquer", action="store_true", help="modifier les fichiers")
    ap.add_argument("--tout", action="store_true",
                    help="permettre --appliquer sans --xmlid (écrase les réglages manuels)")
    args = ap.parse_args()
    if args.appliquer and not args.xmlid and not args.tout:
        ap.error("--appliquer exige --xmlid (ou --tout, qui écrase les réglages manuels)")
    total = 0
    for f in sorted(glob.glob(str(RACINE / "source" / "**" / "*.ptx"), recursive=True)):
        f = Path(f)
        if args.fichier not in f.name:
            continue
        if "asy-" not in f.read_text() or (args.xmlid and not any(x in f.read_text() for x in args.xmlid)):
            continue
        print(f.relative_to(RACINE))
        total += traiter(f, args.hauteur, args.appliquer, args.texte, args.xmlid)
    print(f"{total} changement(s) {'appliqué(s)' if args.appliquer else 'proposé(s)'}")


if __name__ == "__main__":
    main()
