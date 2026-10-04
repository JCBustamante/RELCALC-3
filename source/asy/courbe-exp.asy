// Courbe r(y) = e^y i + y j + (e^y - e^{2y}) k, intersection des surfaces
// x^3 = e^{3y} (c'est-à-dire x = e^y) et x^2 - e^y + z = 0 (section 1.5)
currentprojection = orthographic(5, 2.5, 2);
currentlight = light(gray(0.7), specularfactor = 0.15, (4, 3, 6), (-4, -2, 3));
real ymin = -2, ymax = 0.7;

// x = e^y : cylindre vertical au-dessus de la courbe x = e^y du plan xy
triple A(pair w) { return (exp(w.x), w.x, w.y); }     // w = (y, z)
surface SA = surface(A, (ymin, -2), (ymax, 1.5), 12, 6, Spline);
draw(SA, surfacepen = material(orange + opacity(0.65), emissivepen = 0.25*white, specularpen = black));

// z = e^y - x^2
triple B(pair w) { return (w.x, w.y, exp(w.y) - w.x^2); }   // w = (x, y)
surface SB = surface(B, (-1.5, ymin), (1.5, ymax), 12, 12, Spline);
draw(SB, surfacepen = material(bleu + opacity(0.55), emissivepen = 0.25*white, specularpen = black));

// La courbe
draw(graph(new triple(real y) { return (exp(y), y, exp(y) - exp(2y)); }, ymin, ymax, 120, operator ..),
     rouge + 1.5pt);

axes(2.4, 1.3, 2.4);
