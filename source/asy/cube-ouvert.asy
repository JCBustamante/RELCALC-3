// La surface S (en bleu : cinq faces du cube unité) et le champ
// F = xy i + yz j + xz k ; la face manquante, en rouge, n'en fait pas partie
// (section 4.9)
currentprojection = orthographic(5, 3, 2.5, zoom = 0.85);
currentlight = lumiere;
size(7cm, 0);
void carre3(triple a, triple b, triple c, triple d, material m) {
  draw(surface(a -- b -- c -- d -- cycle), surfacepen = m);
}
carre3((0,0,0), (1,0,0), (1,1,0), (0,1,0), face(bleu, 0.7));
carre3((1,1,0), (0,1,0), (0,1,1), (1,1,1), face(bleu, 0.7));
carre3((0,0,0), (1,0,0), (1,0,1), (0,0,1), face(bleu, 0.7));
carre3((0,0,0), (0,1,0), (0,1,1), (0,0,1), face(bleu, 0.7));
carre3((1,0,0), (1,1,0), (1,1,1), (1,0,1), face(bleu, 0.7));
carre3((0,0,1), (1,0,1), (1,1,1), (0,1,1), face(rouge, 0.3));
pen pa = black + 1pt;
draw((0,0,0) -- (1,0,0) -- (1,1,0) -- (0,1,0) -- cycle, pa);
draw((0,0,1) -- (1,0,1) -- (1,1,1) -- (0,1,1) -- cycle, pa);
draw((0,0,0) -- (0,0,1), pa); draw((0,1,0) -- (0,1,1), pa);
draw((1,0,0) -- (1,0,1), pa); draw((1,1,0) -- (1,1,1), pa);
// Le champ, 4 x 4 x 4 flèches
triple F(triple p) { return (p.x*p.y, p.y*p.z, p.x*p.z); }
for (int i = 0; i < 4; ++i) for (int j = 0; j < 4; ++j) for (int k = 0; k < 4; ++k) {
  triple p = (i/3, j/3, k/3);
  if (abs(F(p)) > 1e-6) draw(p -- p + 0.25*F(p), gray(0.35) + 0.7pt, Arrow3(4));
}
axes(1.6, 1.6, 1.6);
