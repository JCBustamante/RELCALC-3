// Le plan tangent à la surface z = f(x,y) en P0, engendré par les vecteurs
// vitesse de deux courbes tracées sur la surface et passant par P0 : les
// traces y = y0 (vecteur i + f_x k) et x = x0 (vecteur j + f_y k) (section 2.4)
currentprojection = orthographic(5, 3.2, 2.6, zoom = 0.9);
currentlight = lumiere;
size(7cm, 0);

// Textes (à traduire)
string tP0 = "$P_0$";

// Paraboloïde renversé
real f(real x, real y) { return 2.5 - (x - 1)^2 - 0.5*(y - 1)^2; }
real fx(real x, real y) { return -2*(x - 1); }
real fy(real x, real y) { return -(y - 1); }
real x0 = 1.25, y0 = 1;
triple P0 = (x0, y0, f(x0, y0));
triple u = (1, 0, fx(x0, y0)), v = (0, 1, fy(x0, y0));   // vecteurs vitesse

// La surface
triple S(pair w) { return (w.x, w.y, f(w.x, w.y)); }
pair a = (0.25, 0.25), b = (2.25, 2.25);
draw(surface(S, a, b, 12, 12, Spline), surfacepen = face(bleu, 0.45));
maillage(S, a, b, 6, 6, bleu*0.7 + 0.2pt);

// Les deux courbes (traces) passant par P0
draw(graph(new triple(real t) { return S((t, y0)); }, a.x, b.x, 60, operator ..), rouge + 1.2pt);
draw(graph(new triple(real t) { return S((x0, t)); }, a.y, b.y, 60, operator ..), vert + 1.2pt);

// Le plan tangent, engendré par u et v : P0 + s u + t v, avec s, t entre s0 et s1
real s0 = -0.25, s1 = 1.35;
draw(surface(P0 + s0*u + s0*v -- P0 + s1*u + s0*v -- P0 + s1*u + s1*v -- P0 + s0*u + s1*v -- cycle),
     surfacepen = face(orange, 0.5));

// Les vecteurs vitesse
fleche(P0, P0 + u, rouge, 9);
fleche(P0, P0 + v, vert, 9);
dot(P0, black + 4pt);
label(tP0, P0 + 0.1*unit(cross(u, v)), NW);   // un peu au-dessus du plan, pour rester visible

axes(2.45, 2.45, 3.1);
