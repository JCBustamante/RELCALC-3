// Un hyperboloïde à une nappe (annexe C)
real a = 1, b = 2.5, c = 1.5, vmax = 1.1;
real zmax = c*sinh(vmax);
triple P(pair w) {   // w = (u, v)
  return (a*cosh(w.y)*cos(w.x), b*cosh(w.y)*sin(w.x), c*sinh(w.y));
}
surface Surf = surface(P, (0, -vmax), (2pi, vmax), 24, 8, Spline);
colorer(Surf, YlOrBr, new real(triple q) { return 0.5 + 0.25*q.z/zmax; });
draw(Surf);

// Traces horizontales (ellipses) et sections verticales (hyperboles)
real v2 = vmax/2;
trace(new triple(real t) { return (a*cos(t), b*sin(t), 0); }, 0, 2pi, rouge);
trace(new triple(real t) { return (a*cosh(v2)*cos(t), b*cosh(v2)*sin(t), c*sinh(v2)); }, 0, 2pi, rouge);
trace(new triple(real t) { return (a*cosh(t), 0, c*sinh(t)); }, -vmax, vmax, vert);
trace(new triple(real t) { return (-a*cosh(t), 0, c*sinh(t)); }, -vmax, vmax, vert);
trace(new triple(real t) { return (0, b*cosh(t), c*sinh(t)); }, -vmax, vmax, bleu);
trace(new triple(real t) { return (0, -b*cosh(t), c*sinh(t)); }, -vmax, vmax, bleu);

axes(a*cosh(vmax) + 0.6, b*cosh(vmax) + 0.6, zmax + 0.6);
