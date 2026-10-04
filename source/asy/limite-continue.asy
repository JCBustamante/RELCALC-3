// Graphe de f(x,y) = 2 x^2 y/(x^2 + y^2) = 2 r cos(t)^2 sin(t) (section 2.2),
// sur le carré [-1, 1]^2 (même domaine que le diagramme de courbes de niveau)
currentprojection = orthographic(5, 3.5, 3, zoom = 0.9);
triple P(pair w) {   // w = (s, t) : « polaires carrées »
  pair q = carre(w.x, w.y);
  real r = length(q);
  return (q.x, q.y, 2*r*cos(w.y)^2*sin(w.y));
}
surface S = surface(P, (0, 0), (1, 2pi), 8, 64);
colorer(S, Spectral, new real(triple q) { return (q.z + 1)/2; });
draw(S);
maillage(P, (0, 0), (1, 2pi), 4, 8, lisse = false, nv_pts = 64);
axes(1.5, 1.5, 1.2);
