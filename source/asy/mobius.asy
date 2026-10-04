// Le ruban de Möbius et son vecteur normal (section 4.7) : en faisant le tour
// du ruban, le vecteur normal revient à son point de départ dans le sens opposé
currentprojection = orthographic(4, 3, 4, zoom = 0.9);
size(7cm, 0);
real R = 2;
triple P(pair w) {   // w = (s, t)
  real s = w.x, t = w.y;
  return ((R + s*cos(t/2))*cos(t), (R + s*cos(t/2))*sin(t), s*sin(t/2));
}
// Colormap « coolwarm » (matplotlib), simplifiée
pen[] coolwarm = {rgb(59/255, 76/255, 192/255), rgb(221/255, 221/255, 221/255), rgb(180/255, 4/255, 38/255)};
surface S = surface(P, (-1, 0), (1, 2pi), 4, 48, Spline);
colorer(S, coolwarm, new real(triple q) { return (1 + q.y/sqrt(q.x^2 + q.y^2))/2; });
draw(S);
// Le bord (une seule courbe fermée)
draw(graph(new triple(real t) { return P((-1, t)); }, 0, 4pi, 120, operator ..), black + 1.2pt);
// Vecteurs normaux le long de la ligne médiane s = 0
real L = 0.6;
for (real t = 0; t < 2pi; t += 0.3) {
  triple a = P((0, t));
  triple n = (-cos(t)*sin(t/2), -sin(t)*sin(t/2), cos(t/2));
  fleche(a, a + L*n, black, 4);
}
