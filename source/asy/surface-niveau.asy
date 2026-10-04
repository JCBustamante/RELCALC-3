// La surface z = f(x,y) de la figure des traces horizontales, colorée
// selon la hauteur (section 2.1)
currentprojection = orthographic(5, 3.5, 3, zoom = 0.9);
size(7cm, 0);

real g(real x, real y) {
  return 2 + 2*(1 - x)^2*exp(-x^2 - (y + 1)^2)
           + 2*abs(x/5 - x^3 - y^5)*exp(-x^2 - y^2)
           + exp(-(x + 1)^2 - y^2);
}
real r = 2;
real k = 0.6;   // compression verticale de la figure (z affiché = 0.6 f(x,y))

// Surface colorée selon f (de 2 à 7, comme le diagramme de courbes de niveau)
surface S = surface(new real(pair p) { return k*g(p.x, p.y); }, (-r, -r), (r, r), 30, 30);
colorer(S, Spectral, new real(triple q) { return (q.z/k - 2)/5; });
draw(S);

// Le plan z = 0
draw(surface((-r, -r, 0) -- (r, -r, 0) -- (r, r, 0) -- (-r, r, 0) -- cycle),
     surfacepen = bleu + opacity(0.15));

axes(2.4, 3, k*7.2);
