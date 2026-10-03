// Un cône elliptique (annexe C)
real a = 1, b = 2.5, c = 1.5, vmax = 1.3;
triple P(pair w) { return (a*w.y*cos(w.x), b*w.y*sin(w.x), c*w.y); }
surface Surf = surface(P, (0, -vmax), (2pi, vmax), 32, 12, Spline);
colorer(Surf, YlOrBr, new real(triple q) { return 0.5 + 0.25*q.z/(c*vmax); });
draw(Surf);

// Traces horizontales (ellipses)
real v0 = vmax/2;
trace(new triple(real t) { return (a*vmax*cos(t), b*vmax*sin(t), c*vmax); }, 0, 2pi, rouge);
trace(new triple(real t) { return (a*v0*cos(t), b*v0*sin(t), c*v0); }, 0, 2pi, rouge);
trace(new triple(real t) { return (-a*v0*cos(t), -b*v0*sin(t), -c*v0); }, 0, 2pi, rouge);
// Génératrices dans les plans y = 0 et x = 0
trace(new triple(real t) { return (a*t, 0, c*t); }, -vmax, vmax, vert);
trace(new triple(real t) { return (0, b*t, c*t); }, -vmax, vmax, bleu);
// Sections verticales décalées (hyperboles), passant par un même point du cône
real u0 = pi/4;
real x0 = a*v0*cos(u0), y0 = b*v0*sin(u0);
real ty = b*sqrt(vmax^2 - (x0/a)^2);
real tx = a*sqrt(vmax^2 - (y0/b)^2);
trace(new triple(real t) { return (x0, t, c*sqrt((x0/a)^2 + (t/b)^2)); }, -ty, ty, bleu);
trace(new triple(real t) { return (x0, t, -c*sqrt((x0/a)^2 + (t/b)^2)); }, -ty, ty, bleu);
trace(new triple(real t) { return (t, y0, c*sqrt((y0/b)^2 + (t/a)^2)); }, -tx, tx, vert);
trace(new triple(real t) { return (t, y0, -c*sqrt((y0/b)^2 + (t/a)^2)); }, -tx, tx, vert);

axes(a*vmax + 0.6, b*vmax + 0.6, c*vmax + 0.6);
