// Réglages communs aux figures 3D Asymptote du livre
// (inclus en tête de chaque figure par <xi:include parse="text" .../>)
import three;
import graph3;
settings.render = 8;   // résolution du rendu 3D en PDF (sans effet sur le WebGL)
defaultpen(fontsize(11pt));
currentlight = nolight; // couleurs fidèles ; le relief vient du dégradé et des traces

// Palette du livre
pen bleu   = rgb(70/255, 130/255, 180/255);   // steelblue
pen rouge  = rgb(178/255, 34/255, 34/255);    // firebrick
pen vert   = rgb(46/255, 139/255, 87/255);    // seagreen
pen orange = rgb(1, 165/255, 0);              // orange (régions)

// Colormaps matplotlib (du bas vers le haut)
pen[] Spectral = {rgb("9e0142"), rgb("d53e4f"), rgb("f46d43"), rgb("fdae61"),
                  rgb("fee08b"), rgb("ffffbf"), rgb("e6f598"), rgb("abdda4"),
                  rgb("66c2a5"), rgb("3288bd"), rgb("5e4fa2")};
pen[] YlOrBr = {rgb("ffffe5"), rgb("fff7bc"), rgb("fee391"), rgb("fec44f"),
                rgb("fe9929"), rgb("ec7014"), rgb("cc4c02"), rgb("993404"),
                rgb("662506")};

// Couleur de la colormap C à la position t de [0,1]
pen couleur(pen[] C, real t) {
  t = min(max(t, 0), 1);
  real x = t*(C.length - 1);
  int i = min(floor(x), C.length - 2);
  return interp(C[i], C[i + 1], x - i);
}

// Colore chaque sommet de la surface s selon t(sommet), comme le
// color=(macouleur, colormap) de Sage ; op = opacité
void colorer(surface s, pen[] C, real t(triple), real op = 1) {
  for (int i = 0; i < s.s.length; ++i) {
    triple[] c = s.s[i].corners();
    pen[] p = new pen[4];
    for (int k = 0; k < 4; ++k) p[k] = couleur(C, t(c[k])) + opacity(op);
    s.s[i].colors = p;
  }
}

// Trace (courbe sur la surface)
void trace(triple f(real), real a, real b, pen p) {
  draw(graph(f, a, b, 120, operator ..), p + 0.8pt);
}

// Axes x, y, z depuis l'origine, avec étiquettes
void axes(real X, real Y, real Z, string tx = "$x$", string ty = "$y$", string tz = "$z$") {
  draw(Label(tx, EndPoint), O -- (X, 0, 0), black + 0.6pt, Arrow3(5));
  draw(Label(ty, EndPoint), O -- (0, Y, 0), black + 0.6pt, Arrow3(5));
  draw(Label(tz, EndPoint), O -- (0, 0, Z), black + 0.6pt, Arrow3(5));
}

size(6cm, 0);
currentprojection = orthographic(5, 3, 2.5);
