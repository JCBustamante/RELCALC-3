// Un paraboloïde hyperbolique (annexe C)
real a = 1.2, b = 1.8, rmax = 1.5;
triple P(pair w) { return (a*w.x*cos(w.y), b*w.x*sin(w.y), w.x^2*cos(2*w.y)); }   // w = (r, theta)
surface Surf = surface(P, (0, 0), (rmax, 2pi), 8, 24, Spline);
colorer(Surf, YlOrBr, new real(triple q) { return 0.5 + 0.25*q.z/rmax^2; });
draw(Surf);

real xmax = a*rmax, ymax = b*rmax, zmax = rmax^2;
// Trace z = 0 : deux droites qui se croisent au col
trace(new triple(real r) { return (a*r*cos(pi/4), b*r*sin(pi/4), 0); }, -rmax, rmax, rouge);
trace(new triple(real r) { return (a*r*cos(-pi/4), b*r*sin(-pi/4), 0); }, -rmax, rmax, rouge);
// Sections verticales (paraboles de concavités opposées)
trace(new triple(real t) { return (t, 0, (t/a)^2); }, -xmax, xmax, vert);
trace(new triple(real t) { return (0, t, -(t/b)^2); }, -ymax, ymax, bleu);
// Sections décalées
real x0 = xmax/2, y0 = ymax/2;
real ty = b*sqrt(rmax^2 - (x0/a)^2);
real tx = a*sqrt(rmax^2 - (y0/b)^2);
trace(new triple(real t) { return (x0, t, (x0/a)^2 - (t/b)^2); }, -ty, ty, bleu);
trace(new triple(real t) { return (t, y0, (t/a)^2 - (y0/b)^2); }, -tx, tx, vert);

axes(xmax + 0.6, ymax + 0.6, zmax + 0.6);
