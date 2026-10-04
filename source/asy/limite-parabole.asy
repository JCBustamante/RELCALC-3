// Graphe de f(x,y) = x y^2/(x^2 + y^4) (section 2.2) ; en polaires,
// f = r cos(t) sin(t)^2/(cos(t)^2 + r^2 sin(t)^4) : crête étroite le long de
// la parabole x = y^2 (où f = 1/2) près de l'origine, d'où un maillage
// resserré près de l'origine. Domaine : le carré [-2, 2]^2 (même domaine que
// le diagramme de courbes de niveau), en « polaires carrées ».
currentprojection = orthographic(5, 3.5, 3, zoom = 0.9);
real f(real r, real t) { return r*cos(t)*sin(t)^2/(cos(t)^2 + r^2*sin(t)^4); }
triple P(pair w) {   // w = (s, t)
  pair q = carre(w.x^2, w.y, 2);
  return (q.x, q.y, f(length(q), w.y));
}
surface S = surface(P, (0.001, 0), (1, 2pi), 16, 48);
colorer(S, Spectral, new real(triple q) { return q.z + 0.5; });
draw(S);
maillage(P, (0.001, 0), (1, 2pi), 4, 8, lisse = false, nv_pts = 48);
axes(2.6, 2.6, 1.2);
