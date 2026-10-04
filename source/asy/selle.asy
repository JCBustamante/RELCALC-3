// La selle z = x^2 - y^2, avec ses traces en x = 0 (bleu) et y = 0 (rouge)
// (section 2.8)
currentprojection = orthographic(5, 3.5, 3, zoom = 0.9);
real k = 0.6;   // compression verticale de la figure (z affiché = 0.6 f(x,y))
real f(real x, real y) { return x^2 - y^2; }
triple P(pair w) { return (w.x, w.y, k*f(w.x, w.y)); }
pair a = (-2, -2), b = (2, 2);
surface S = surface(P, a, b, 12, 12, Spline);
colorer(S, Spectral, new real(triple q) { return (q.z/k + 4)/8; });
draw(S);
maillage(P, a, b, 8, 8);
// Traces en y = 0 (rouge) et en x = 0 (bleu)
draw(graph(new triple(real x) { return P((x, 0)); }, -2, 2, 40, operator ..), rouge + 1.5pt);
draw(graph(new triple(real y) { return P((0, y)); }, -2, 2, 40, operator ..), bleu + 1.5pt);
dot(O, black + 5pt);
axes(2.6, 2.6, k*4.6);
