// Le graphe et les courbes de niveau du paraboloïde z = x^2 + y^2 (section 2.1) :
// surface et disque du plan z = 0 colorés selon la valeur de f
currentprojection = orthographic(5, 3.5, 3, zoom = 0.8);
real h(real r) { return r^2; }   // f en fonction de r = sqrt(x^2 + y^2)

triple P(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), h(w.x)); }   // w = (r, t)
triple D(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), 0); }
real t(triple q) { return h(sqrt(q.x^2 + q.y^2)); }
surface S = surface(P, (0, 0), (1, 2pi), 8, 24, Spline);
surface Disque = surface(D, (0, 0), (1, 2pi), 8, 24, Spline);
colorer(S, Spectral, t);
colorer(Disque, Spectral, t);
draw(S);
draw(Disque);

axes(1.5, 1.5, 1.4);
