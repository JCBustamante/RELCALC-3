// La région E de la section 4.9 et sa frontière, avec un vecteur normal
// extérieur sur chaque face (même région qu'en 3.4, mêmes couleurs)
currentprojection = orthographic(5, 3, 2.5, zoom = 0.85);
currentlight = lumiere;
real Y(real x, real v) { return x^2 + (1 - x^2)*v; }
triple Base(pair w) { return (w.x, Y(w.x, w.y), 0); }
triple Haut(pair w) { return (w.x, Y(w.x, w.y), 1 - Y(w.x, w.y)); }
triple Cyl(pair w)  { return (w.x, w.x^2, w.y*(1 - w.x^2)); }
pair a = (-1, 0), b = (1, 1);
draw(surface(Base, a, b, 12, 4, Spline), surfacepen = face(orange, 0.85));
draw(surface(Haut, a, b, 12, 4, Spline), surfacepen = face(bleu, 0.4));
draw(surface(Cyl, a, b, 12, 4, Spline), surfacepen = face(vert));
pen pa = arete + 0.8pt;
draw(graph(new triple(real x) { return (x, x^2, 0); }, -1, 1, 40, operator ..), pa);
draw(graph(new triple(real x) { return (x, x^2, 1 - x^2); }, -1, 1, 40, operator ..), pa);
draw((-1, 1, 0) -- (1, 1, 0), pa);
// Vecteurs normaux extérieurs
fleche((0.5, 0.7, 0), (0.5, 0.7, -0.5), orange*0.8);
fleche((-0.5, 0.7, 0.3), (-0.5, 1.05, 0.65), bleu);
fleche((0.5, 0.25, 0.5), (0.85, -0.1, 0.5), vert);
axes(1.4, 1.4, 1.3);
