// Un ellipsoïde (annexe C)
real a = 1, b = 2.5, c = 1.5;
triple P(pair w) {   // w = (u, v)
  return (a*cos(w.x)*sin(w.y), b*sin(w.x)*sin(w.y), c*cos(w.y));
}
surface Surf = surface(P, (0, 0), (2pi, pi), 32, 16, Spline);
colorer(Surf, YlOrBr, new real(triple q) { return 0.5 + 0.25*q.z/c; });
draw(Surf);

// Traces dans les plans de coordonnées, puis décalées
trace(new triple(real t) { return (a*cos(t), b*sin(t), 0); }, 0, 2pi, rouge);
trace(new triple(real t) { return (a*cos(t), 0, c*sin(t)); }, 0, 2pi, vert);
trace(new triple(real t) { return (0, b*cos(t), c*sin(t)); }, 0, 2pi, bleu);
real s = sqrt(3)/2;
trace(new triple(real t) { return (a*s*cos(t), b*s*sin(t), c/2); }, 0, 2pi, rouge);
trace(new triple(real t) { return (a*s*cos(t), b/2, c*s*sin(t)); }, 0, 2pi, vert);
trace(new triple(real t) { return (a/2, b*s*cos(t), c*s*sin(t)); }, 0, 2pi, bleu);

axes(a + 0.6, b + 0.6, c + 0.6);
