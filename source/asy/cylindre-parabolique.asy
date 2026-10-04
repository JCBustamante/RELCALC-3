// Le cylindre parabolique z = x^2 (annexe C)
triple P(pair w) { return (w.x, w.y, w.x^2); }
surface Surf = surface(P, (-2, -2), (2, 2), 12, 12, Spline);
colorer(Surf, Spectral, new real(triple q) { return q.z/4; });
draw(Surf);
maillage(P, (-2, -2), (2, 2), 12, 4);
axes(2.5, 2.5, 4.8);
