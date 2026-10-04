// Un hyperboloïde à deux nappes (annexe C)
real a = 1.5, b = 2.5, c = 1, vmax = 1.1;
real vcap = 1.2*vmax;   // les nappes sont tronquées à v = vcap
triple Ph(pair w) { return (a*sinh(w.y)*cos(w.x), b*sinh(w.y)*sin(w.x), c*cosh(w.y)); }
triple Pb(pair w) { return (a*sinh(w.y)*cos(w.x), b*sinh(w.y)*sin(w.x), -c*cosh(w.y)); }
real t(triple q) { return 0.4 + 0.1*acosh(abs(q.z)/c)/vmax; }
surface Haut = surface(Ph, (0, 0), (2pi, vcap), 24, 8, Spline);
surface Bas  = surface(Pb, (0, 0), (2pi, vcap), 24, 8, Spline);
colorer(Haut, YlOrBr, t);
colorer(Bas, YlOrBr, t);
draw(Haut);
draw(Bas);

// Traces horizontales (ellipses) au sommet de chaque nappe
trace(new triple(real t) { return (a*sinh(vmax)*cos(t), b*sinh(vmax)*sin(t), c*cosh(vmax)); }, 0, 2pi, rouge);
trace(new triple(real t) { return (a*sinh(vmax)*cos(t), b*sinh(vmax)*sin(t), -c*cosh(vmax)); }, 0, 2pi, rouge);
// Sections verticales (hyperboles) dans les plans y = 0 et x = 0
trace(new triple(real t) { return (a*sinh(t), 0, c*cosh(t)); }, -vcap, vcap, vert);
trace(new triple(real t) { return (a*sinh(t), 0, -c*cosh(t)); }, -vcap, vcap, vert);
trace(new triple(real t) { return (0, b*sinh(t), c*cosh(t)); }, -vcap, vcap, bleu);
trace(new triple(real t) { return (0, b*sinh(t), -c*cosh(t)); }, -vcap, vcap, bleu);
// Les mêmes, décalées en x = x0 et y = y0, arrêtées au bord des nappes
real x0 = a/2, y0 = b/2;
real ty = b*sqrt(sinh(vcap)^2 - (x0/a)^2);
real tx = a*sqrt(sinh(vcap)^2 - (y0/b)^2);
trace(new triple(real t) { return (x0, t, c*sqrt(1 + (x0/a)^2 + (t/b)^2)); }, -ty, ty, bleu);
trace(new triple(real t) { return (x0, t, -c*sqrt(1 + (x0/a)^2 + (t/b)^2)); }, -ty, ty, bleu);
trace(new triple(real t) { return (t, y0, c*sqrt(1 + (y0/b)^2 + (t/a)^2)); }, -tx, tx, vert);
trace(new triple(real t) { return (t, y0, -c*sqrt(1 + (y0/b)^2 + (t/a)^2)); }, -tx, tx, vert);

axes(a*sinh(vmax) + 0.6, b*sinh(vmax) + 0.6, 1.2*c*cosh(vmax) + 0.6);
