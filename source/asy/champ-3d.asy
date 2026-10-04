// Le champ F(x,y,z) = y i + j + (z^2 - 1) k (section 4.1), sur le pavé
// [-1.5, 1.5] x [-1.5, 1.5] x [-2, 2] (z jusqu'à 2 : plus de variété de normes), inspiré de plot_vector_field3d de Sage : longueurs
// proportionnelles aux normes (la plus longue flèche mesure 90 % de
// l'espacement de la grille) ; couleur selon la norme, de la plus petite
// (violet foncé) à la plus grande (jaune), avec la colormap séquentielle viridis
currentprojection = orthographic(5, 3.5, 2.5, zoom = 0.9);
size(7cm, 0);
triple F(triple p) { return (p.y, 1, p.z^2 - 1); }
int n = 5;
real pas = 3/(n - 1), pasz = 4/(n - 1);
triple[] pts;
for (int i = 0; i < n; ++i) for (int j = 0; j < n; ++j) for (int k = 0; k < n; ++k)
  pts.push((-1.5 + pas*i, -1.5 + pas*j, -2 + pasz*k));
real nmin = infinity, nmax = 0;
for (triple p : pts) { nmin = min(nmin, abs(F(p))); nmax = max(nmax, abs(F(p))); }
for (triple p : pts) {
  triple v = F(p);
  draw(p -- p + 0.9*pas*v/nmax, couleur(Viridis, (abs(v) - nmin)/(nmax - nmin)) + 0.8pt, Arrow3(5));
}
axes(2.2, 2.4, 2.8);
