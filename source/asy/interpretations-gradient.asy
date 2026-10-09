// Les deux rôles du gradient (section 2.6) : pour f(x,y) = 1 + x^2 + 2y^2,
// le gradient de f en (x0,y0), dans le domaine, et le gradient de
// G(x,y,z) = f(x,y) - z, normal au graphe au point correspondant (vers le bas :
// sa partie horizontale est le gradient de f)
currentprojection = orthographic(5, 3, 2.5, zoom = 0.9);
currentlight = lumiere;
size(7cm, 0);
real k = 0.75;   // compression verticale de la figure (z affiché = 0.75 z)

// Textes (à traduire)
string tgf = "$\nabla f$";
string tgG = "$\nabla G$";

real f(real x, real y) { return 1 + x^2 + 2*y^2; }
real x0 = 1/4, y0 = 1/4;
triple P0 = (x0, y0, 0), Q0 = (x0, y0, k*f(x0, y0));
triple gf = (2*x0, 4*y0, 0);           // gradient de f, dans le plan z = 0
triple gG = (2*x0, 4*y0, -k);         // gradient de G = f - z (composante en z comprimée)

// Portion du graphe au-dessus du quart d'ellipse x^2/2 + y^2 <= 1, x, y >= 0 (premier octant)
triple S(pair w) { real x = sqrt(2)*w.x*cos(w.y), y = w.x*sin(w.y); return (x, y, k*f(x, y)); }
triple D(pair w) { return (sqrt(2)*w.x*cos(w.y), w.x*sin(w.y), 0); }
pair a = (0, 0), b = (1, pi/2);
draw(surface(D, a, b, 4, 16, Spline), surfacepen = face(orange, 0.25));
draw(surface(S, a, b, 6, 16, Spline), surfacepen = face(bleu, 0.35));
maillage(S, a, b, 4, 4, bleu*0.7 + 0.2pt);

// Le point du domaine et le point correspondant du graphe
draw(P0 -- Q0, gray(0.4) + dashed + 0.5pt);
fleche(P0, P0 + gf, rouge, 9);
fleche(Q0, Q0 + gG, bleu*0.8, 9);
label(tgf, P0 + gf, S, rouge);
label(tgG, Q0 + 0.5*gG, NE, bleu*0.8);   // au milieu : la pointe est près de celle de grad f
dot(P0, rouge + 4pt);
dot(Q0, bleu*0.8 + 4pt);

axes(1.9, 1.8, k*3.4);
