// Un paraboloïde elliptique (annexe C)
real a = 1.2, b = 1.8, rmax = 1.5;
triple P(pair w) { return (a*w.x*cos(w.y), b*w.x*sin(w.y), w.x^2); }   // w = (r, theta)
surface Surf = surface(P, (0, 0), (rmax, 2pi), 10, 32, Spline);
colorer(Surf, YlOrBr, new real(triple q) { return 0.35 + 0.3*q.z/rmax^2; });
draw(Surf);

real xmax = a*rmax, ymax = b*rmax, zmax = rmax^2;
// Trace horizontale (ellipse)
real r0 = rmax/1.3;
trace(new triple(real t) { return (a*r0*cos(t), b*r0*sin(t), r0^2); }, 0, 2pi, rouge);
// Sections verticales (paraboles) dans les plans y = 0 et x = 0
trace(new triple(real t) { return (t, 0, (t/a)^2); }, -xmax, xmax, vert);
trace(new triple(real t) { return (0, t, (t/b)^2); }, -ymax, ymax, bleu);
// Sections décalées, passant par un même point de l'ellipse
real th0 = pi/4;
real x0 = a*r0*cos(th0), y0 = b*r0*sin(th0);
real ty = b*sqrt(rmax^2 - (x0/a)^2);
real tx = a*sqrt(rmax^2 - (y0/b)^2);
trace(new triple(real t) { return (x0, t, (x0/a)^2 + (t/b)^2); }, -ty, ty, bleu);
trace(new triple(real t) { return (t, y0, (t/a)^2 + (y0/b)^2); }, -tx, tx, vert);

axes(xmax + 0.6, ymax + 0.6, zmax + 0.6);
