// La surface S (portion du cône z = sqrt(x^2 + y^2) entre z = 1 et z = 2),
// les disques qui la ferment et le vecteur normal n (section 4.9)
currentprojection = orthographic(5, 3, 2, zoom = 0.85);
currentlight = lumiere;
triple C(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), w.x); }   // w = (r, t)
draw(surface(C, (1, 0), (2, 2pi), 4, 32, Spline), surfacepen = face(bleu, 0.85));
draw(surface(C, (0, 0), (1, 2pi), 4, 32, Spline), surfacepen = face(bleu, 0.2));
draw(surface(C, (2, 0), (2.5, 2pi), 2, 32, Spline), surfacepen = face(bleu, 0.2));
triple D1(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), 1); }
triple D2(pair w) { return (w.x*cos(w.y), w.x*sin(w.y), 2); }
draw(surface(D1, (0, 0), (1, 2pi), 2, 32, Spline), surfacepen = face(rouge, 0.5));
draw(surface(D2, (0, 0), (2, 2pi), 4, 32, Spline), surfacepen = face(rouge, 0.5));
fleche((1, 1, sqrt(2)), (1.5, 1.5, sqrt(2)/2), black, 9);
label("$\vec{n}$", (1.7, 1.7, 0.7), black);
axes(2.7, 2.7, 3.1);
