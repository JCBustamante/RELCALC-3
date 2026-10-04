// Graphe de f(x,y) = x^(1/3) y^(1/3), point anguleux à l'origine (figure 2.4.6)
import three;
import graph3;
import palette;
settings.render = 8;   // résolution du rendu 3D en PDF (sans effet sur le WebGL)
defaultpen(fontsize(14pt));

size(7cm, 0);
currentprojection = orthographic(5, 3.5, 2.5);

// Textes (à traduire)
string tx = "$x$";
string ty = "$y$";
string tz = "$z$";

// Colormap Spectral (matplotlib), du bas vers le haut
pen[] Spectral = {rgb("9e0142"), rgb("d53e4f"), rgb("f46d43"), rgb("fdae61"),
                  rgb("fee08b"), rgb("ffffbf"), rgb("e6f598"), rgb("abdda4"),
                  rgb("66c2a5"), rgb("3288bd"), rgb("5e4fa2")};

real f(pair p) { return cbrt(p.x)*cbrt(p.y); }

real r = 2;
// maillage non lissé (pas de Spline) : la surface a un point anguleux en (0,0)
surface Surf = surface(f, (-r, -r), (r, r), 24, 24);
Surf.colors(palette(Surf.map(zpart), Gradient(...Spectral)));
// sans éclairage : les couleurs du dégradé restent fidèles
// (l'éclairage par défaut noircit les parois presque verticales)
currentlight = nolight;
draw(Surf);

// maillage léger pour faire ressortir le relief
pen pm = gray(0.25) + 0.3pt;
for (int i = -4; i <= 4; ++i) {
  real c = i*r/4;
  draw(graph(new triple(real t) { return (c, t, f((c, t))); }, -r, r, 24, operator --), pm);
  draw(graph(new triple(real t) { return (t, c, f((t, c))); }, -r, r, 24, operator --), pm);
}

// Axes
real zmax = cbrt(r)^2;
draw(Label(tx, EndPoint), O -- (1.35*r, 0, 0), black + 0.7pt, Arrow3(5));
draw(Label(ty, EndPoint), O -- (0, 1.35*r, 0), black + 0.7pt, Arrow3(5));
draw(Label(tz, EndPoint), O -- (0, 0, 1.5*zmax), black + 0.7pt, Arrow3(5));
