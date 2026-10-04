// La région de l'exercice 5 de la section 3.4 : premier octant, limitée par
// les plans x = 0, y = 0, z = 0, y + z = 2 et le cylindre parabolique x = 4 - y^2
currentprojection = orthographic(5, 3, 2.5, zoom = 0.85);
currentlight = light(gray(0.7), specularfactor = 0.15, (4, 3, 6), (-4, -2, 3));
triple Base(pair w) { return (w.x*(4 - w.y^2), w.y, 0); }          // w = (s, t)
triple Haut(pair w) { return (w.x*(4 - w.y^2), w.y, 2 - w.y); }
triple Cyl(pair w)  { return (4 - w.y^2, w.y, w.x*(2 - w.y)); }
triple FaceX(pair w) { return (0, w.y, w.x*(2 - w.y)); }            // face x = 0
triple FaceY(pair w) { return (4*w.x, 0, 2*w.y); }                  // face y = 0
pair a = (0, 0), b = (1, 2);
draw(surface(Base, a, b, 4, 12, Spline), surfacepen = face(orange, 0.85));
draw(surface(Haut, a, b, 4, 12, Spline), surfacepen = face(bleu, 0.4));
draw(surface(Cyl, a, b, 4, 12, Spline), surfacepen = face(vert));
draw(surface(FaceX, a, b, 4, 12, Spline), surfacepen = face(violet));
draw(surface(FaceY, (0, 0), (1, 1), 2, 2), surfacepen = face(dore));
// Arêtes
pen pa = arete + 0.8pt;
draw(graph(new triple(real t) { return (4 - t^2, t, 0); }, 0, 2, 40, operator ..), pa);
draw(graph(new triple(real t) { return (4 - t^2, t, 2 - t); }, 0, 2, 40, operator ..), pa);
draw((0, 0, 2) -- (0, 2, 0), pa);
draw((0, 0, 2) -- (4, 0, 2), pa);
draw((4, 0, 0) -- (4, 0, 2), pa);
axes(4.7, 2.6, 2.6);
