// Le cône z = sqrt(x^2 + y^2), non différentiable à l'origine (section 2.4)
currentprojection = orthographic(5, 3.5, 2.5, zoom = 0.85);
triple P(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), w.x); }   // w = (r, t)
pair a = (0, 0), b = (1, 2pi);
surface S = surface(P, a, b, 6, 32, Spline);
colorer(S, Spectral, new real(triple q) { return q.z; });
draw(S);
maillage(P, a, b, 4, 12);
axes(1.4, 1.4, 1.3);
