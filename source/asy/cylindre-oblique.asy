// Le cylindre oblique de l'exercice 10 de la section 2.3 : base = cercle
// unité du plan xy, génératrices parallèles à la droite z = y du plan yz
currentprojection = orthographic(6, 1.5, 1.4, zoom = 0.9);
currentlight = light(gray(0.7), specularfactor = 0.15, (4, 3, 6), (-4, -2, 3));
triple P(pair w) { return (cos(w.x), sin(w.x) + w.y, w.y); }   // w = (t, s)
pair a = (0, -1), b = (2pi, 1.2);
draw(surface(P, a, b, 24, 4, Spline),
     surfacepen = material(bleu + opacity(0.6), emissivepen = 0.25*white, specularpen = black));
maillage(P, a, b, 12, 4, bleu*0.7 + 0.2pt);
// Le cercle de base, dans le plan xy
draw(graph(new triple(real t) { return (cos(t), sin(t), 0); }, 0, 2pi, 48, operator ..) .. cycle,
     rouge + 0.9pt + dashed);
axes(1.6, 2.6, 1.6);
