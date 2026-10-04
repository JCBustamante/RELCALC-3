// La région E de l'exemple de la section 3.4 : au-dessus du plan Oxy,
// sous le plan y + z = 1, à l'intérieur du cylindre parabolique y = x^2
currentprojection = orthographic(5, 3, 2.5, zoom = 0.85);
currentlight = light(gray(0.7), specularfactor = 0.15, (4, 3, 6), (-4, -2, 3));
// (x, v) avec y = x^2 + (1 - x^2) v parcourt la région D du plan Oxy
real Y(real x, real v) { return x^2 + (1 - x^2)*v; }
triple Base(pair w) { return (w.x, Y(w.x, w.y), 0); }
triple Haut(pair w) { return (w.x, Y(w.x, w.y), 1 - Y(w.x, w.y)); }
triple Cyl(pair w)  { return (w.x, w.x^2, w.y*(1 - w.x^2)); }   // paroi y = x^2
triple Proj(pair w) { return (w.x, 0, w.y*(1 - w.x^2)); }       // projection R sur Oxz
pair a = (-1, 0), b = (1, 1);
draw(surface(Base, a, b, 12, 4, Spline), surfacepen = face(orange, 0.85));
draw(surface(Haut, a, b, 12, 4, Spline), surfacepen = face(bleu, 0.4));
draw(surface(Cyl, a, b, 12, 4, Spline), surfacepen = face(vert));
draw(surface(Proj, a, b, 12, 4, Spline), surfacepen = face(violet, 0.5));
// Arêtes
pen pa = arete + 0.8pt;
draw(graph(new triple(real x) { return (x, x^2, 0); }, -1, 1, 40, operator ..), pa);
draw(graph(new triple(real x) { return (x, x^2, 1 - x^2); }, -1, 1, 40, operator ..), pa);
draw((-1, 1, 0) -- (1, 1, 0), pa);
axes(1.4, 1.4, 1.3);
