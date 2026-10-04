// La courbe C, une surface S dont elle est le bord (orientée par le vecteur
// rouge) et, en vert, le domaine R (section 4.8)
currentprojection = orthographic(5, 3, 3, zoom = 0.9);
currentlight = lumiere;
size(7cm, 0);
real k = 0.7;   // compression verticale de la figure (z affiché = 0.7 z)
// Le cylindre parabolique z = y^2, en arrière-plan
triple Cyl(pair w) { return (w.x, w.y, k*w.y^2); }
draw(surface(Cyl, (-2.1, -2.1), (2.1, 2.1), 6, 12, Spline), surfacepen = face(orange, 0.25));
// La surface S : z = y^2 au-dessus du disque de rayon 2
triple S(pair w) { return (2*w.x*cos(w.y), 2*w.x*sin(w.y), k*4*w.x^2*sin(w.y)^2); }   // w = (r, t)
draw(surface(S, (0, 0), (1, 2pi), 6, 32, Spline), surfacepen = face(orange, 0.65));
maillage(S, (0, 0), (1, 2pi), 4, 12, orange*0.6 + 0.2pt);
// Le domaine R du plan xy
triple D(pair w) { return (2*w.x*cos(w.y), 2*w.x*sin(w.y), 0); }
draw(surface(D, (0, 0), (1, 2pi), 4, 32, Spline), surfacepen = face(vert, 0.65));
// La courbe C, r(t) = 2 cos t i + 2 sin t j + 4 sin^2 t k, et son orientation
triple C(real t)  { return (2*cos(t), 2*sin(t), k*4*sin(t)^2); }
triple dC(real t) { return (-2*sin(t), 2*cos(t), k*8*sin(t)*cos(t)); }
draw(graph(C, 0, 2pi, 120, operator ..) .. cycle, bleu + 1.5pt);
fleche(C(pi/3), C(pi/3) + 0.2*dC(pi/3), bleu + 1pt, 11);
fleche(C(4pi/3), C(4pi/3) + 0.125*dC(4pi/3), bleu + 1pt, 11);
// Le vecteur normal à S au point (0, 1, 1), dirigé vers le haut : (0, -2y, 1)
triple N0 = (0, 1, k);
fleche(N0, N0 + 0.9*unit((0, -2*k, 1)), rouge + 1pt, 11);
axes(2.6, 2.6, k*4.7);
