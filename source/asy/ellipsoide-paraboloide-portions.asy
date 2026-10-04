// Les quatre portions (selon les signes de x et de y) de l'intersection de
// l'ellipsoïde x^2 + y^2/2 + z^2/3 = 1 et du paraboloïde z = x^2 + 2y^2 (section 1.5)
currentprojection = orthographic(5, 3, 2.2);
currentlight = light(gray(0.7), specularfactor = 0.15, (4, 3, 6), (-4, -2, 3));

// Moitié supérieure de l'ellipsoïde, (phi, theta)
triple E(pair w) {
  return (sin(w.x)*cos(w.y), sqrt(2)*sin(w.x)*sin(w.y), sqrt(3)*cos(w.x));
}
surface Ell = surface(E, (0, 0), (pi/2, 2pi), 12, 24, Spline);
draw(Ell, surfacepen = material(orange + opacity(0.5), emissivepen = 0.25*white, specularpen = black));

// Paraboloïde, (r, theta), jusqu'à z = 2
triple Q(pair w) { return (w.x*cos(w.y), w.x*sin(w.y)/sqrt(2), w.x^2); }
surface Par = surface(Q, (0, 0), (sqrt(2), 2pi), 10, 24, Spline);
draw(Par, surfacepen = material(bleu + opacity(0.35), emissivepen = 0.25*white, specularpen = black));

// Courbe d'intersection paramétrée par theta (voir ellipsoide-paraboloide.asy) ;
// chaque quart de tour de theta correspond à un couple de signes de x et de y
triple C(real t) {
  real k = cos(t)^2 + sin(t)^2/4;
  real u = 1.5*(-k + sqrt(k^2 + 4/3));
  real rho = sqrt(u);
  return (rho*cos(t), rho*sin(t)/sqrt(2), u);
}
pen[] coul = {rouge, bleu, vert, black};
for (int i = 0; i < 4; ++i)
  draw(graph(C, i*pi/2, (i + 1)*pi/2, 60, operator ..), coul[i] + 2.5pt);

axes(1.6, 1.8, 3.1);
