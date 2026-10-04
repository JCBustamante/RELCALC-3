// Réglages communs aux figures 3D Asymptote du livre
// (inclus en tête de chaque figure par <xi:include parse="text" .../>)
import three;
import graph3;
settings.render = 8;   // résolution du rendu 3D en PDF (sans effet sur le WebGL)
defaultpen(fontsize(14pt));
currentlight = nolight; // couleurs fidèles ; le relief vient du dégradé et des traces

// Palette du livre
pen bleu   = rgb(70/255, 130/255, 180/255);   // steelblue
pen rouge  = rgb(178/255, 34/255, 34/255);    // firebrick
pen vert   = rgb(46/255, 139/255, 87/255);    // seagreen
pen orange = rgb(1, 165/255, 0);              // orange (régions)
// Couleurs supplémentaires, pour distinguer les faces d'un solide
pen violet = rgb(147/255, 112/255, 219/255);  // mediumpurple
pen dore   = rgb(218/255, 165/255, 32/255);   // goldenrod
pen arete  = gray(0.25);                      // arêtes des solides

// Matériau d'une face (couleur unie, translucide, sans reflet), à employer
// avec un éclairage (currentlight) défini dans la figure
material face(pen p, real op = 0.7) {
  return material(p + opacity(op), emissivepen = 0.45*p, specularpen = black);
}

// Colormaps matplotlib (du bas vers le haut)
pen[] Spectral = {rgb("9e0142"), rgb("d53e4f"), rgb("f46d43"), rgb("fdae61"),
                  rgb("fee08b"), rgb("ffffbf"), rgb("e6f598"), rgb("abdda4"),
                  rgb("66c2a5"), rgb("3288bd"), rgb("5e4fa2")};
// Colormap séquentielle (pour une norme, une intensité...)
pen[] Viridis = {rgb("440154"), rgb("482878"), rgb("3e4989"), rgb("31688e"),
                 rgb("26828e"), rgb("1f9e89"), rgb("35b779"), rgb("6ece58"),
                 rgb("b5de2b"), rgb("fde725")};
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

// Maillage léger d'une surface paramétrée P sur [a.x, b.x] x [a.y, b.y] :
// nu lignes à u constant et nv lignes à v constant (bords compris) ;
// lisse = false : segments droits (surface très raide par endroits) ;
// nv_pts : nombre de points le long des lignes à u constant
void maillage(triple P(pair), pair a, pair b, int nu, int nv, pen p = gray(0.3) + 0.25pt,
              bool lisse = true, int nv_pts = 24) {
  interpolate3 j = lisse ? operator .. : operator --;
  for (int i = 0; i <= nu; ++i) {
    real u = a.x + i*(b.x - a.x)/nu;
    draw(graph(new triple(real v) { return P((u, v)); }, a.y, b.y, nv_pts, j), p);
  }
  for (int j = 0; j <= nv; ++j) {
    real v = a.y + j*(b.y - a.y)/nv;
    draw(graph(new triple(real u) { return P((u, v)); }, a.x, b.x, 16, j), p);
  }
}

// Éclairage standard pour les surfaces de couleur unie (matériau face())
light lumiere = light(gray(0.7), specularfactor = 0.15, (4, 3, 6), (-4, -2, 3));

// Vecteur (normal, tangent...) de a vers b
void fleche(triple a, triple b, pen p, real taille = 5) {
  draw(a -- b, p + 1pt, Arrow3(taille));
}

// Coordonnées « polaires carrées » : pour l'angle t, le point de rayon
// relatif s (0 <= s <= 1) sur le segment qui va de l'origine au bord du
// carré [-c, c]^2. Utile pour une fonction singulière à l'origine qu'on veut
// tracer sur un domaine carré (prendre un nombre d'angles multiple de 8,
// pour que les coins du carré soient des sommets du maillage).
pair carre(real s, real t, real c = 1) {
  return s*c/max(abs(cos(t)), abs(sin(t)))*(cos(t), sin(t));
}

// Axes x, y, z depuis l'origine, avec étiquettes
void axes(real X, real Y, real Z, string tx = "$x$", string ty = "$y$", string tz = "$z$") {
  draw(Label(tx, EndPoint), O -- (X, 0, 0), black + 0.6pt, Arrow3(5));
  draw(Label(ty, EndPoint), O -- (0, Y, 0), black + 0.6pt, Arrow3(5));
  draw(Label(tz, EndPoint), O -- (0, 0, Z), black + 0.6pt, Arrow3(5));
}

size(6cm, 0);
currentprojection = orthographic(5, 3, 2.5);
