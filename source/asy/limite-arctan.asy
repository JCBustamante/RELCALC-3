// Graphe de g(x,y) = arctan((x + y)/(x - y)) (section 2.2), sur le carré
// [-1, 1]^2 (même domaine que le diagramme de courbes de niveau). En polaires,
// g = t + pi/4 à un multiple de pi près, à valeurs dans ]-pi/2, pi/2[ :
// deux rampes, avec une déchirure le long de la droite y = x.
currentprojection = orthographic(5, 3.5, 3, zoom = 0.7);
real k = 0.7;   // compression verticale de la figure (z affiché = 0.7 g(x,y))
real e = 0.01;
real t(triple q) { return (q.z/k + pi/2)/pi; }
triple A(pair w) {   // -3pi/4 < t < pi/4 ; w = (s, t) en « polaires carrées »
  pair q = carre(w.x, w.y);
  return (q.x, q.y, k*(w.y + pi/4));
}
triple B(pair w) {   //  pi/4 < t < 5pi/4
  pair q = carre(w.x, w.y);
  return (q.x, q.y, k*(w.y - 3pi/4));
}
pair a0 = (0, -3pi/4 + e), a1 = (1, pi/4 - e);
pair b0 = (0, pi/4 + e), b1 = (1, 5pi/4 - e);
surface SA = surface(A, a0, a1, 4, 24);
surface SB = surface(B, b0, b1, 4, 24);
colorer(SA, Spectral, t);
colorer(SB, Spectral, t);
draw(SA);
draw(SB);
maillage(A, a0, a1, 4, 4, lisse = false, nv_pts = 24);
maillage(B, b0, b1, 4, 4, lisse = false, nv_pts = 24);
axes(1.5, 1.5, 1.6);
