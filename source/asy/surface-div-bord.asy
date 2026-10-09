// La surface S : z = f(x,y) au-dessus du disque unité (section 4.9)
currentprojection = orthographic(5, 3, 1.3, zoom = 0.85);
currentlight = lumiere;
real f(real x, real y) { return (1 - x^2 - y^2)*(1 - y^3)*cos(x)*exp(y); }
triple S(pair w) {   // w = (r, t)
  real x = w.x*cos(w.y), y = w.x*sin(w.y);
  return (x, y, f(x, y));
}
draw(surface(S, (0, 0), (1, 2pi), 8, 32, Spline), surfacepen = face(orange, 0.65));
maillage(S, (0, 0), (1, 2pi), 4, 12, orange*0.6 + 0.2pt);
// Vecteur normal (vers le haut) au point (x0, y0, f(x0, y0))
real x0 = 0.6, y0 = -0.3, e = 1e-5;   // point du versant tourné vers le lecteur
real fx = (f(x0 + e, y0) - f(x0 - e, y0))/(2e);
real fy = (f(x0, y0 + e) - f(x0, y0 - e))/(2e);
real h = sqrt(fx^2 + fy^2 + 1)/0.7;   // normale unitaire, longueur 0.7
triple p0 = (x0, y0, f(x0, y0));
fleche(p0, p0 + (-fx/h, -fy/h, 1/h), bleu);
// Le bord C : le cercle unité du plan xy
draw(graph(new triple(real t) { return (cos(t), sin(t), 0); }, 0, 2pi, 60, operator ..) .. cycle, rouge + 1.5pt);
axes(1.6, 1.6, 1.6);
