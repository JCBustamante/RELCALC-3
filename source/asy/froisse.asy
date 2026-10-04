// Graphe de f(x,y) = x y/sqrt(x^2 + y^2) = (r/2) sin(2 t), continue mais non
// différentiable à l'origine (section 2.4), sur le carré [-1, 1]^2 (même
// domaine que le diagramme de courbes de niveau), en « polaires carrées »
currentprojection = orthographic(5, 3.5, 3, zoom = 0.85);
triple P(pair w) {   // w = (s, t)
  pair q = carre(w.x, w.y);
  return (q.x, q.y, length(q)*sin(2*w.y)/2);
}
pair a = (0, 0), b = (1, 2pi);
surface S = surface(P, a, b, 8, 64);
colorer(S, Spectral, new real(triple q) { return (q.z + 0.7)/1.4; });
draw(S);
maillage(P, a, b, 4, 8, lisse = false, nv_pts = 64);
axes(1.9, 1.9, 1.1);
