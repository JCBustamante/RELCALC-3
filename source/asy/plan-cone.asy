// Le plan z = 1 + y et le cône z^2 = x^2 + y^2 (section 1.5)
currentprojection = orthographic(5, -3, 4);
currentlight = light(gray(0.7), specularfactor = 0.15, (4, -3, 6), (-4, 2, 3));

// Le plan z = 1 + y
triple Pl(pair w) { return (w.x, w.y, 1 + w.y); }
surface SP = surface(Pl, (-2, -1), (2, 1.6), 8, 6);
draw(SP, surfacepen = material(bleu + opacity(0.6), emissivepen = 0.25*white, specularpen = black));
maillage(Pl, (-2, -1), (2, 1.6), 8, 6, bleu + 0.2pt);

// Le cône (nappe supérieure)
triple Co(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), w.x); }   // w = (r, t)
surface SC = surface(Co, (0, 0), (2, 2pi), 8, 24, Spline);
draw(SC, surfacepen = material(orange + opacity(0.75), emissivepen = 0.25*white, specularpen = black));
maillage(Co, (0, 0), (2, 2pi), 8, 24, orange*0.6 + 0.2pt);

// La courbe d'intersection (une parabole)
draw(graph(new triple(real r) { return (r, (r^2 - 1)/2, (r^2 + 1)/2); }, -2, 2, 100, operator ..),
     rouge + 1.5pt);

axes(2.6, 2.3, 3);
