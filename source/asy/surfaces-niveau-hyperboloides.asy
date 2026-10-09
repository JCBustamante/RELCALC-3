// Quelques surfaces de niveau de f(x,y,z) = x^2 + y^2 - z^2 (section 2.1) :
// k = -4 (hyperboloïde à deux nappes), k = 0 (cône), k = 4 (hyperboloïde à une
// nappe). Le cône et l'hyperboloïde à une nappe sont entaillés pour laisser
// voir l'intérieur.
// Les entailles sont centrées sur la direction t = pi/6 (et non sur l'axe des x,
// qui tomberait dans l'entaille) ; le point de vue est placé en face.
currentprojection = orthographic(5.2, 3, 2.5, zoom = 0.9);
currentlight = light(gray(0.7), specularfactor = 0.15, (5, 2, 6), (-4, -2, 3));
size(8cm, 0);
material mat(pen p, real op) {
  return material(p + opacity(op), emissivepen = 0.25*white, specularpen = black);
}

// k = -4 : x^2 + y^2 - z^2 = -4, deux nappes ; (s, t) polaires
triple H2h(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), sqrt(w.x^2 + 4)); }
triple H2b(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), -sqrt(w.x^2 + 4)); }
draw(surface(H2h, (0, 0), (3, 2pi), 6, 24, Spline), surfacepen = mat(orange, 0.9));
draw(surface(H2b, (0, 0), (3, 2pi), 6, 24, Spline), surfacepen = mat(orange, 0.9));
maillage(H2h, (0, 0), (3, 2pi), 3, 8, orange*0.6 + 0.2pt);
maillage(H2b, (0, 0), (3, 2pi), 3, 8, orange*0.6 + 0.2pt);

// k = 0 : le cône x^2 + y^2 = z^2, entaillé autour de la direction t = pi/6
triple Ch(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), w.x); }
triple Cb(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), -w.x); }
pair c0 = (0, pi/3), c1 = (3.6, 2pi);
draw(surface(Ch, c0, c1, 6, 20, Spline), surfacepen = mat(vert, 0.6));
draw(surface(Cb, c0, c1, 6, 20, Spline), surfacepen = mat(vert, 0.6));
maillage(Ch, c0, c1, 3, 6, vert*0.6 + 0.2pt);
maillage(Cb, c0, c1, 3, 6, vert*0.6 + 0.2pt);

// k = 4 : x^2 + y^2 - z^2 = 4, une nappe, entaillée plus largement
triple H1(pair w) { return (2*cos(w.y)*cosh(w.x), 2*sin(w.y)*cosh(w.x), 2*sinh(w.x)); }
pair h0 = (-1.3, 5pi/12), h1 = (1.3, 23pi/12);
draw(surface(H1, h0, h1, 8, 20, Spline), surfacepen = mat(bleu, 0.4));
maillage(H1, h0, h1, 4, 6, bleu*0.7 + 0.2pt);

axes(4.6, 4.6, 5.3);
