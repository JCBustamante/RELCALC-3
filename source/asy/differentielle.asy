// La différentielle df approche la variation Δf de f(x,y)
// (remplacerait images/AC3-images/fig_10_4_tangent_10, figure 2.4.22)
import three;
import graph3;
settings.render = 8;   // résolution du rendu 3D en PDF (sans effet sur le WebGL)
defaultpen(fontsize(7pt));

size(7cm, 0);
currentprojection = orthographic(6, 2.5, 2.8);

// Palette du livre
pen bleu  = rgb(70/255, 130/255, 180/255);   // steelblue
pen rouge = rgb(178/255, 34/255, 34/255);    // firebrick
pen vert  = rgb(46/255, 139/255, 87/255);    // seagreen

// Textes (à traduire)
string tP0 = "$(x_0,y_0)$";
string tP  = "$(x,y)$";
string tDx = "$dx=\Delta x$";
string tDy = "$dy=\Delta y$";
string tdf = "$df$";
string tDf = "$\Delta f$";

// Fonction, point de base et écarts
real x0 = 0.4, y0 = 0.3, Dx = 1.2, Dy = 1.6;
real f(real x, real y) { return 1.5 - 0.12*x^2 - 0.18*y^2 - 0.1*y; }
real fx(real x, real y) { return -0.24*x; }
real fy(real x, real y) { return -0.36*y - 0.1; }
real L(real x, real y) { return f(x0, y0) + fx(x0, y0)*(x - x0) + fy(x0, y0)*(y - y0); }
real x1 = x0 + Dx, y1 = y0 + Dy;
real z0 = f(x0, y0);

// Surface z = f(x,y) et plan tangent, au-dessus du rectangle
surface Surf = surface(new triple(pair u) { return (u.x, u.y, f(u.x, u.y)); },
                    (x0, y0), (x1, y1), 8, 8, Spline);
draw(Surf, surfacepen = bleu + opacity(0.35), meshpen = bleu + 0.15pt, light = nolight);
surface T = surface(new triple(pair u) { return (u.x, u.y, L(u.x, u.y)); },
                    (x0, y0), (x1, y1), 8, 8);
draw(T, surfacepen = rouge + opacity(0.25), meshpen = rouge + 0.15pt, light = nolight);

// Axes
real ax = 2.3;
draw(Label("$x$", EndPoint), O -- (ax, 0, 0), black + 0.5pt, Arrow3(5));
draw(Label("$y$", EndPoint), O -- (0, ax + 0.3, 0), black + 0.5pt, Arrow3(5));
draw(Label("$z$", EndPoint), O -- (0, 0, z0 + 0.35), black + 0.5pt, Arrow3(5));

// Rectangle dans le plan xy, écarts dx et dy
triple A = (x0, y0, 0), B = (x1, y0, 0), C = (x1, y1, 0), D = (x0, y1, 0);
draw(A -- B, black + 0.8pt);
draw(B -- C, black + 0.8pt);
draw(A -- D -- C, gray(0.4) + 0.4pt);
label(tDx, (A + B)/2, SW);
label(tDy, (B + C)/2, S);

// Points de base et d'arrivée
triple P0 = (x0, y0, z0);
triple Pt = (x1, y1, L(x1, y1)), Ps = (x1, y1, f(x1, y1));
draw(A -- P0, gray(0.4) + 0.4pt + dashed);
draw(C -- Ps, gray(0.4) + 0.4pt + dashed);
dot(A, bleu); dot(C, bleu);
dot(P0, rouge); dot(Pt, rouge); dot(Ps, bleu);
label(tP0, A, NE);
label(tP, C, SE);

// Niveau z = f(x0,y0) reporté au-dessus de (x,y)
triple H = (x1, y1, z0);
draw(P0 -- (x1, y0, z0) -- H, gray(0.4) + 0.4pt + dashed);
draw(P0 -- (x0, y1, z0) -- H, gray(0.4) + 0.4pt + dashed);

// df et Δf : doubles flèches à côté du coin (x,y)
triple dec1 = (0, 0.2, 0), dec2 = (0, 0.6, 0);
draw(H + dec1 -- Pt + dec1, vert + 0.6pt, Arrows3(4));
draw(H + dec2 -- Ps + dec2, black + 0.6pt, Arrows3(4));
draw(H -- H + dec2, gray(0.4) + 0.3pt);
draw(Pt -- Pt + dec1, gray(0.4) + 0.3pt);
draw(Ps -- Ps + dec2, gray(0.4) + 0.3pt);
label(tdf, (H + Pt)/2 + dec1, E);
label(tDf, (H + Ps)/2 + dec2, E);
