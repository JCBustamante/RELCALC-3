// Une surface z = f(x,y), quelques traces horizontales (sur la surface)
// et les courbes de niveau correspondantes (dans le plan z = 0) (section 2.1)
import contour;
currentprojection = orthographic(5, 3.5, 3);
currentlight = light(gray(0.7), specularfactor = 0.15, (4, 3, 6), (-4, -2, 3));
size(7cm, 0);

real g(real x, real y) {
  return 2 + 2*(1 - x)^2*exp(-x^2 - (y + 1)^2)
           + 2*abs(x/5 - x^3 - y^5)*exp(-x^2 - y^2)
           + exp(-(x + 1)^2 - y^2);
}
real r = 2;
real k = 0.6;   // compression verticale de la figure (z affiché = 0.6 f(x,y))

// La surface (sans lissage : abs() la rend anguleuse par endroits)
surface S = surface(new real(pair p) { return k*g(p.x, p.y); }, (-r, -r), (r, r), 24, 24);
draw(S, surfacepen = material(orange + opacity(0.45), emissivepen = 0.25*white,
                              specularpen = black));

// Le plan z = 0
draw(surface((-r, -r, 0) -- (r, -r, 0) -- (r, r, 0) -- (-r, r, 0) -- cycle),
     surfacepen = material(bleu + opacity(0.15), emissivepen = 0.4*white, specularpen = black));

// Niveaux : traces (à la hauteur z = k) et courbes de niveau (dans z = 0)
real[] niveaux = sequence(new real(int i) { return 2.5 + 0.5*i; }, 9);   // 2.5, 3, ..., 6.5
guide[][] cn = contour(g, (-r, -r), (r, r), niveaux, 40);
for (int i = 0; i < cn.length; ++i)
  for (int j = 0; j < cn[i].length; ++j) {
    path p0 = cn[i][j];
    // simplification (poids du WebGL) : une courbe lisse par un point sur trois
    guide g;
    for (int m = 0; m < length(p0); m += 3) g = g .. point(p0, m);
    path p = cyclic(p0) ? (g .. cycle) : (g .. point(p0, length(p0)));
    draw(path3(p), bleu + 0.6pt);                               // courbe de niveau
    draw(shift(0, 0, k*niveaux[i])*path3(p), rouge + 0.6pt);      // trace horizontale
  }

axes(2.4, 3, k*7.2);
