// Un cylindre dont la base est un cardioïde (annexe C)
real r(real t) { return 1 + cos(t); }
triple P(pair w) { return (r(w.x)*cos(w.x), r(w.x)*sin(w.x), w.y); }
surface Surf = surface(P, (0, -1), (2pi, 1), 24, 4, Spline);
colorer(Surf, Spectral, new real(triple q) { return (q.z + 1)/2; });
draw(Surf);
maillage(P, (0, -1), (2pi, 1), 24, 4);
axes(2.5, 1.9, 1.7);
