# Corrections mathématiques — branche `correction-linguistique`

Liste des corrections **mathématiques uniquement** (erreurs de fond : signes, indices, coefficients,
formules incohérentes), dans l'ordre des chapitres/sections du manuel. Les numéros de ligne sont ceux
du fichier **sur la branche `correction-linguistique`** (version corrigée) — ouvre le fichier à cette
ligne et compare avec l'ancienne version compilée.

Les formules « Avant »/« Après » sont écrites en LaTeX entre `$...$` pour se rendre proprement dans
le preview Markdown de VSCode (KaTeX, activé par défaut — `markdown.math.enabled`). Les macros du
projet (`\vX`, `\cX`, `\dee{}`, `\pdiff{}{}`, etc.) ont été traduites en LaTeX standard.

Chaque entrée a une ligne **🔍 Chercher :** — un extrait de texte qui apparaît tel quel dans la version
compilée, à utiliser avec Ctrl+F dans le preview (le code LaTeX brut, lui, ne s'y retrouve pas).

Les corrections purement linguistiques (orthographe, grammaire, `<me>`→`<md>`, structure XML) ne sont
**pas** listées ici.

---


---

## Chapitre 4 — Calcul vectoriel

### Sec-Champs-Intro.ptx (commit `c1a6b7a`)
- **Ligne 355** — énoncé d'un exemple, incohérent avec sa propre solution (qui calcule pour $(y^2+1)\mathbf{i}+xy\,\mathbf{j}$).
  - Avant : $\nabla f(x,y) = xy\,\mathbf{i} + (y^2+1)\,\mathbf{j}$
  - Après : $\nabla f(x,y) = (y^2+1)\,\mathbf{i} + xy\,\mathbf{j}$
  - 🔍 Chercher : « Montrer qu'il n'existe pas de fonction f continue telle que »
- **Ligne 446** (exemple `ex-courant-a`) — signe manquant, incohérent avec $\mathbf{F}(x,y)=x\mathbf{i}-y\mathbf{j}$ défini juste avant.
  - Avant : $\mathbf{r}'(t) = \dots = x(t)\mathbf{i} + y(t)\mathbf{j}$
  - Après : $\mathbf{r}'(t) = \dots = x(t)\mathbf{i} - y(t)\mathbf{j}$
  - 🔍 Chercher : « Montrer que la courbe paramétrée par » (juste avant, avec $\mathbf{F}(x,y)=x\mathbf{i}-y\mathbf{j}$)
- **Ligne 477** (exemple `ex-courant-b`) — $\mathbf{j}$ manquant dans le vecteur vitesse final.
  - Avant : $x'(t)\mathbf{i} + y'(t) = -2y(t)\mathbf{i} + x(t)\mathbf{j}$
  - Après : $x'(t)\mathbf{i} + y'(t)\mathbf{j} = -2y(t)\mathbf{i} + x(t)\mathbf{j}$
  - 🔍 Chercher : « Trouver les lignes de courant du champ de vecteurs »
- **Ligne 481** — ratio $dy/dx$ inversé.
  - Avant : $\dfrac{dy}{dx} = \dfrac{dy/dt}{dx/dt} = \dfrac{x'(t)}{y'(t)}$
  - Après : $\dfrac{dy}{dx} = \dfrac{dy/dt}{dx/dt} = \dfrac{y'(t)}{x'(t)}$
  - 🔍 Chercher : même exemple que ci-dessus (« Trouver les lignes de courant... »)
- **Ligne 485** — coquille $dy/dy$ au lieu de $dy/dx$.
  - Avant : $\dfrac{dy}{dy} = \dfrac{x}{-2y}$
  - Après : $\dfrac{dy}{dx} = \dfrac{x}{-2y}$
  - 🔍 Chercher : même exemple que ci-dessus
- **Ligne 523** — paramétrage d'une ligne de courant elliptique, $\mathbf{j}$ manquant en toute fin de ligne.
  - Avant : $\dots = -\sqrt2\,y(u)\,\mathbf{i} + \dfrac{1}{\sqrt2}x(u).$
  - Après : $\dots = -\sqrt2\,y(u)\,\mathbf{i} + \dfrac{1}{\sqrt2}x(u)\,\mathbf{j}.$
  - 🔍 Chercher : « On remarque que ce vecteur n'est pas égal à »

### Prob-sec-Champs-Intro.ptx (commit `c1a6b7a`)
- **Ligne 546** — champ de vitesse radial (problème des abeilles), racine carrée superflue au dénominateur (vérifié par calcul direct : vitesse = rapidité × direction unitaire).
  - Avant : $\mathbf{v}(x,y,z) = -\dfrac{\alpha}{\sqrt{x^2+y^2+z^2}}\,(x,y,z)$
  - Après : $\mathbf{v}(x,y,z) = -\dfrac{\alpha}{x^2+y^2+z^2}\,(x,y,z)$
  - 🔍 Chercher : « Si A est » puis « inversement proportionnel » à B ; ou « Si votre visage est à l'origine »

### Sec-Integrales-ligne.ptx (commit `02ce1bc`)
- **Ligne 150** — intégrale de ligne, facteur $\sqrt2$ manquant en le sortant de l'intégrale.
  - Avant : $\displaystyle\int_0^1 [t+(1-t)]\sqrt2\, dt = \sqrt2\int_0^1 dt$ (facteur perdu entre les deux membres)
  - Après : $\displaystyle\int_0^1 [t+(1-t)]\sqrt2\, dt = \sqrt2\int_0^1 [t+(1-t)]\, dt$
  - 🔍 Chercher : « Nous avons aussi $\mathbf{r}'(t) = \mathbf{i}-\mathbf{j}$ »
- **Ligne 181** — $\mathbf{r}'(t)$ d'une parabole $y=x^2$, variable erronée.
  - Avant : $\mathbf{r}'(t) = 2y\,\mathbf{i} + 2\,\mathbf{j}$
  - Après : $\mathbf{r}'(t) = 2t\,\mathbf{i} + 2\,\mathbf{j}$
  - 🔍 Chercher : « L'équation $y^2=4x$ donne $x=(y/2)^2$ »
- **Lignes 207–208** — courbe 3D $\mathbf{r}_1(t)=(t,t^2,0)$, norme de la vitesse et intégrande recopiées avec le mauvais exposant.
  - Avant : $|\mathbf{r}_1'(t)| = \sqrt{1+t^2}$, intégrande $2t\sqrt{1+4t^3}$
  - Après : $|\mathbf{r}_1'(t)| = \sqrt{1+4t^2}$, intégrande $2t\sqrt{1+4t^2}$
  - 🔍 Chercher : « Afin de calculer l'intégrale voulue, calculons les deux termes indépendamment »
- **Ligne 215** — somme finale de deux intégrales de ligne, erreur arithmétique de signe.
  - Avant : $\dfrac16\left(5^{3/2}-1\right) + \dfrac53 = \dfrac16\left(5^{3/2} - 9\right)$
  - Après : $\dfrac16\left(5^{3/2}-1\right) + \dfrac53 = \dfrac16\left(5^{3/2} + 9\right)$ (le calcul correct donne bien $+9$)
  - 🔍 Chercher : même passage que ci-dessus (fin du calcul)
- **Ligne 673** — flux $\mathbf{F}\cdot\mathbf{n}$ à travers une courbe, second terme utilisait la mauvaise variable de dérivation.
  - Avant : $\mathbf{F}\cdot\mathbf{n} = P\dfrac{dy}{ds} - Q\dfrac{dy}{ds}$
  - Après : $\mathbf{F}\cdot\mathbf{n} = P\dfrac{dy}{ds} - Q\dfrac{dx}{ds}$
  - 🔍 Chercher : « Afin de faire les calculs explicites, rappelons que »
- **Ligne 684** — flux à travers le cercle unité, second terme du produit recopié avec la mauvaise dérivée.
  - Avant : $\displaystyle\int (x(t)-y(t))y'(t) - x(t)y'(t)\, dt$
  - Après : $\displaystyle\int (x(t)-y(t))y'(t) - x(t)x'(t)\, dt$
  - 🔍 Chercher : « Calculer le flux de F à travers (vers l'extérieur) le cercle »

### Prob-sec-Integrales-ligne.ptx (commit `02ce1bc`)
- **Ligne 301** — casse incohérente dans un nom de courbe.
  - Avant : $\displaystyle\int_{c_2} xy\, dy$
  - Après : $\displaystyle\int_{C_2} xy\, dy$
  - 🔍 Chercher : « Let C₁ be the quarter-circle » (solution en anglais)

### Sec-Div-Rot.ptx (commit `fc0d4ab`)
- **Ligne 148** — dérivation du flux vertical (préparation de la définition du rotationnel), deux erreurs incohérentes avec la phrase qui suit (continuité de $\partial Q/\partial x$).
  - Avant : $\left[Q(x_0+\Delta x,y_0) - P(x_0,y_0)\right]\Delta y \approx \dfrac{\partial Q}{\partial y}(x_0,y_0)\Delta x\,\Delta y$
  - Après : $\left[Q(x_0+\Delta x,y_0) - Q(x_0,y_0)\right]\Delta y \approx \dfrac{\partial Q}{\partial x}(x_0,y_0)\Delta x\,\Delta y$
  - 🔍 Chercher : « De la même façon, le flux correspondant aux composantes verticales de la trajectoire est »
- **Ligne 292** (exemple `rot-3d`) — composante $\mathbf{j}$ du déterminant symbolique dérivée par rapport à la mauvaise variable (réponse finale $-4\mathbf{i}-2x\mathbf{j}+\mathbf{k}$ déjà correcte).
  - Avant : $\left(\dfrac{\partial(x^2)}{\partial x} - \dfrac{\partial}{\partial y}(x^2-y)\right)\mathbf{j}$
  - Après : $\left(\dfrac{\partial(x^2)}{\partial x} - \dfrac{\partial}{\partial z}(x^2-y)\right)\mathbf{j}$
  - 🔍 Chercher : « Calculer le rotationnel de F » (juste après le champ $(x^2-y)\mathbf{i}+4z\mathbf{j}+x^2\mathbf{k}$)
- **Ligne 328** — preuve de $\text{rot}(\nabla f)=\mathbf{0}$, signe entre les termes $\mathbf{j}$ et $\mathbf{k}$ du déterminant.
  - Avant : $(\dots)\mathbf{i} + (\dots)\mathbf{j} = (\dots)\mathbf{k}$
  - Après : $(\dots)\mathbf{i} + (\dots)\mathbf{j} + (\dots)\mathbf{k}$
  - 🔍 Chercher : « le théorème donne l'égalité des dérivées partielles croisées »
- **Ligne 584** — preuve du théorème $\text{div}(\text{rot}\,\mathbf{F})=0$, signe inversé dans la formule du rotationnel utilisée (incohérent avec la définition donnée plus haut) ; avec le mauvais signe, les termes de Clairaut s'additionnaient au lieu de s'annuler, rendant la preuve invalide.
  - Avant : $\nabla\cdot(\nabla\times\mathbf{F}) = \dfrac{\partial}{\partial x}(R_y-Q_z) + \dfrac{\partial}{\partial y}(R_x-P_z) + \dfrac{\partial}{\partial z}(Q_x-P_y) = R_{yx} - Q_{zx} + R_{xy} - P_{zy} + \dots$
  - Après : $\nabla\cdot(\nabla\times\mathbf{F}) = \dfrac{\partial}{\partial x}(R_y-Q_z) + \dfrac{\partial}{\partial y}(P_z-R_x) + \dfrac{\partial}{\partial z}(Q_x-P_y) = R_{yx} - Q_{zx} + P_{zy} - R_{xy} + \dots$
  - 🔍 Chercher : « Théorème de Clairault - Schwarz » (ou « avec les notations de l'énoncé, nous avons »)

### Prob-sec-Div-Rot.ptx (commit `fc0d4ab`)
- **Ligne 239** — $\nabla(\mathbf{r}/r)$ : opérateur manquant (c'est une divergence, pas un gradient).
  - Avant : $\nabla\left(\dfrac{\mathbf{r}}{r}\right) = \dfrac{2x^2+2y^2+2z^2}{[x^2+y^2+z^2]^{3/2}}$
  - Après : $\nabla\cdot\left(\dfrac{\mathbf{r}}{r}\right) = \dfrac{2x^2+2y^2+2z^2}{[x^2+y^2+z^2]^{3/2}}$
  - 🔍 Chercher : « the specified divergence is »
- **Ligne 774** — composante $\mathbf{k}$ de $\nabla(r^2)$, variable manquante (copier-coller).
  - Avant : $\nabla(r^2) = 2x\,\mathbf{i} + 2y\,\mathbf{j} + 2\,\mathbf{k}$
  - Après : $\nabla(r^2) = 2x\,\mathbf{i} + 2y\,\mathbf{j} + 2z\,\mathbf{k}$
  - 🔍 Chercher : « Les réponses doivent être exprimées en termes de a, r et $r$. Il ne devrait pas y avoir de x, y ou z »
- **Lignes 816 et 876** — composantes $\mathbf{k}$ de $\nabla r$ et $\nabla(1/r)$, variable manquante (même copier-coller, deux endroits).
  - Avant : $\mathbf{k}\cdot\dfrac{x}{(x^2+y^2+z^2)^{1/2}}$ et $-\mathbf{k}\cdot\dfrac{x}{r^3}$
  - Après : $\mathbf{k}\cdot\dfrac{z}{(x^2+y^2+z^2)^{1/2}}$ et $-\mathbf{k}\cdot\dfrac{z}{r^3}$
  - 🔍 Chercher (816) : « Calculer a, où $\nabla(1/r) = -r^a\mathbf{r}$ »
- **Lignes 993–1112** (exercice sur un champ $\mathbf{F} = \frac{-z}{x^2+z^2}\mathbf{i} + y\,\mathbf{j} + \frac{x}{x^2+z^2}\mathbf{k}$, qui ne dépend jamais de $y$) — 5 dénominateurs recopiés avec $y$ au lieu de $z$, cohérence rétablie tout au long de la dérivation du rotationnel.
  - Avant : dénominateurs en $(x^2+y^2)$ / $(x^2+y^2)^2$
  - Après : dénominateurs en $(x^2+z^2)$ / $(x^2+z^2)^2$
  - 🔍 Chercher : « Déterminer le domaine de F » puis « Est-ce que F est conservatif? »
- **Ligne 1181** — coquille dans le calcul de $\text{rot}(\mathbf{G})$ (vérifié par recalcul direct).
  - Avant : $(g_y+xy)\mathbf{i} - (g_x-xy)\,h\mathbf{j} + (-yz-xz)\mathbf{k}$
  - Après : $(g_y+xy)\mathbf{i} - (g_x-xy)\,\mathbf{j} + (-yz-xz)\mathbf{k}$
  - 🔍 Chercher : « This is true for all (x,y,z) if and only if α=β=-1 »

### Sec-Conservatifs.ptx (commit `da9014f`)
- **Lignes 490 et 504** — exemple `ex-int-cons-3d`, champ $P$ annoncé incohérent avec toute la dérivation qui suit (le rotationnel ne s'annule qu'avec $2xy-z^2$) ; cascade de corrections dans la suite de l'exemple, non montrées individuellement ici.
  - Avant : $\mathbf{F} = (2yz-z^2)\mathbf{i} + (x^2+2z)\mathbf{j} + (2y-2xz)\mathbf{k}$, puis $f_x = P = 2yz-z^2$
  - Après : $\mathbf{F} = (2xy-z^2)\mathbf{i} + (x^2+2z)\mathbf{j} + (2y-2xz)\mathbf{k}$, puis $f_x = P = 2xy-z^2$
  - 🔍 Chercher : « où C est une courbe lisse allant de (0,1,1) à (2,2,4) »
- **Ligne 649** — étiquette d'intégrale incohérente avec la courbe $C_2$ en cours de traitement.
  - Avant : $\displaystyle\int_{C_1} \mathbf{F}\cdot d\mathbf{r} = -\pi$
  - Après : $\displaystyle\int_{C_2} \mathbf{F}\cdot d\mathbf{r} = -\pi$
  - 🔍 Chercher : « Un calcul en tout point semblable à celui fait pour C₁ mène à »

### Prob-sec-Conservatifs.ptx (commit `da9014f`)
- **Ligne 199** — item (e) d'un exercice sur les intégrales de ligne, réponse recalculée et corrigée.
  - Avant : $4$ — Après : $2$
  - 🔍 Chercher : « Faire ceci pour les fonctions et courbes suivantes » puis l'item $f(x,y,z)=(x^2+y^2+z^2)/2$
- **Ligne 268** — point d'arrivée d'une courbe corrompu (virgule et parenthèses mal placées).
  - Avant : « ... une courbe allant de $(0,0,0)$ à $(3,3,1),-3,6)$ »
  - Après : « ... une courbe allant de $(0,0,0)$ à $(0,0,1)$ »
  - 🔍 Chercher : « une courbe allant de (0,0,0) à » (2ᵉ item de la liste, avec $2x\,dx - y^2 dy$)
- **Ligne 274** — champ vectoriel de l'énoncé incohérent avec les réponses déjà données ($-\pi$, $1$).
  - Avant : $\displaystyle\int_C \sin x\cos y\, dx + \cos y\sin x\, dy + dz$
  - Après : $\displaystyle\int_C \sin x\cos y\, dx + \cos x\sin y\, dy + dz$
  - 🔍 Chercher : « une courbe allant de (1,0,0) à (0,1,1) »
- **Ligne 295** — item (b) du même exercice, réponse recalculée et corrigée.
  - Avant : $-2$ — Après : $-6$
  - 🔍 Chercher : même liste que ci-dessus, second item de la réponse
- **Ligne 726** — dérivée mal recopiée (le terme n'a pas la forme d'une dérivée par rapport à $y$ d'une exponentielle en $z$).
  - Avant : $6Bye^{(z^2)} = 6Bye^{(z^2)}$
  - Après : $6Byz^2 = 6Byz^2$
  - 🔍 Chercher : « the field F is conservative only if it passes the screening test » (anglais)
- **Ligne 838** — réponse finale d'un exercice sur les décompositions $\mathbf{F}=\mathbf{G}+\mathbf{H}$, recalculée via la décomposition explicitement fournie.
  - Avant : $\dfrac{\sqrt2}{3}$ — Après : $1+\cos(1)$
  - 🔍 Chercher : « Une décomposition utile » (titre de l'exercice)

### Sec-Green.ptx (commit `92f439b`)
- **Ligne 193** — preuve du théorème de Green (cas rectangulaire), notation incomplète pour la borne inférieure.
  - Avant : $P(x,\varphi_2(x)) - P(x,\varphi_x)\, dx$
  - Après : $P(x,\varphi_2(x)) - P(x,\varphi_1(x))\, dx$
  - 🔍 Chercher : « En effet, il suit de la description de R que »
- **Ligne 544** — exemple du nombre d'enroulement, paramétrage du cercle $C_h$ de rayon $h$ donné avec un rayon 1 (incohérent avec $|\mathbf{r}'|=h$ et le vecteur normal utilisés juste après).
  - Avant : $\mathbf{r}(t) = \cos t\,\mathbf{i} + \sin t\,\mathbf{j}$
  - Après : $\mathbf{r}(t) = h\cos t\,\mathbf{i} + h\sin t\,\mathbf{j}$
  - 🔍 Chercher : « Afin de calculer l'intégrale sur C_h, on utilise le paramétrage »
- **Ligne 620** — aire de l'astroïde, facteur perdu (l'étape suivante réutilise bien le facteur 3, il manquait aussi le second $t$ dans $\sin^2$).
  - Avant : $3\cos^2t\,\sin^2t\left(\cos^2t + \sin^2t\right) = 2\cos^2t\,\sin^2t$
  - Après : $3\cos^2t\,\sin^2t\left(\cos^2t + \sin^2t\right) = 3\cos^2t\,\sin^2t$
  - 🔍 Chercher : « Or, $\mathbf{r}'(t) = -(3\sin t\cos^2t)\mathbf{i} + 3(\cos t\sin^2t)\mathbf{j}$ »

### Prob-sec-Green.ptx (commit `92f439b`)
- **Ligne 973** — différentielle mal recopiée après changement de variable ($dx$→$du$).
  - 🔍 Chercher : « since y=2 on L » (anglais, juste avant le changement de variable)
- **Ligne 1600** — mauvaise formule de Green recopiée.
  - Avant : $\dfrac{\partial F_2}{\partial x} - \dfrac{\partial F_2}{\partial y}$
  - Après : $\dfrac{\partial F_2}{\partial x} - \dfrac{\partial F_1}{\partial y}$
  - 🔍 Chercher : « It is again natural to use Green's theorem. But Green's theorem must be applied to a curve that is closed » (anglais)

### Prob-sec-Surfaces.ptx (commit `f1e4497`)
- **Ligne 218** — équation d'un hyperboloïde, artefact de corruption `\leqslant ft(` (pour `\left(`).
  - Avant : $x^2+y^2-2z^2 = u^2-2\,\text{ft}\!\left(\dfrac{u^2}{2} - \dfrac12\right) = 1$ (bug d'affichage)
  - Après : $x^2+y^2-2z^2 = u^2-2\left(\dfrac{u^2}{2} - \dfrac12\right) = 1$
  - 🔍 Chercher : « (b) Yes. Under this parametrization, x=u sin v, y=-u cos v » (anglais)
- **Ligne 698** — ✅ RÉSOLU/reverté (commit `63d15f6`) : `\j`/`\f` sont des alias volontaires (`\theta`/`\phi`, définis dans `docinfo.ptx`), pas des erreurs — revert vers `\j`. Seul vrai fix conservé : borne $r$→$u$ (variable inexistante dans le paramétrage $\mathbf{r}(u,\theta)$).
- **Ligne 733** — ✅ RÉSOLU/reverté (commit `63d15f6`), même raison : $\mathbf{r}(\theta,\phi)$ reverté en $\mathbf{r}(\j,f)$ (macros `\j`/`\f`).
- **Lignes 550 et 578** — norme d'un vecteur distance, artefact `\leqslant ft(` répété (parenthèses cassées).
  - Après : $\sqrt{\left(\tfrac{1}{\sqrt2}\cos\theta\right)^2+\dots}$
  - 🔍 Chercher (550) : « So, we can parametrize the circle as » (anglais)
  - 🔍 Chercher (578) : « The new position of the point has the same height » (anglais)
- **Lignes 573–586** (exercice de rotation d'un cercle, non-examen) — coefficient du rayon effectif incorrect, et hauteur incohérente avec la phrase qui la définit juste avant.
  - Avant : $x=4+\sqrt2\left(2-\sqrt2\cos\theta\right)\cos\varphi$, $z=4\sin\theta$
  - Après : $x=4+\sqrt2\left(2-\tfrac{1}{\sqrt2}\cos\theta\right)\cos\varphi$, $z=4+\sin\theta$
  - 🔍 Chercher : « The new position of the point has the same height, z=4+sinθ »

### Sec-Integrales-Surface.ptx (commit `9cbc9de`)
- **Ligne 23** — introduction, sphère mal écrite et hémisphère incohérent avec le reste de la section.
  - Avant : $x^2+y^2+z^2=a$ (exposant manquant), portion $z\leq0$
  - Après : $x^2+y^2+z^2=a^2$, portion $z\geq0$
  - 🔍 Chercher : « On se souvient probablement de l'enseignement secondaire que l'aire cherchée est »
- **Lignes 1429 et 1439** — exemple de la boîte de conserve, terme croisé recopié avec le mauvais coefficient (vérifié par calcul direct ; sans incidence sur la réponse finale, le terme s'annule à l'intégration).
  - Avant : $9\cos^2\theta + 3\sin\theta\cos\theta + 9\sin^2\theta + 3z\sin\theta$, simplifié en $9 + \tfrac32\sin(2\theta)+3z\sin\theta$
  - Après : $9\cos^2\theta + 9\sin\theta\cos\theta + 9\sin^2\theta + 3z\sin\theta$, simplifié en $9 + \tfrac92\sin(2\theta)+3z\sin\theta$
  - 🔍 Chercher : « Notons que $\mathbf{n} = (\cos\theta,\sin\theta,0)$ est normal à $\mathcal{S}_c$ et pointe vers l'extérieur »

### Prob-sec-Integrales-Surface.ptx (commit `9cbc9de`)
- **Ligne 344** — exposant mal recopié (coquille de frappe).
  - Avant : $(x^2+y^2+z^2)^{n++1-1/2}$
  - Après : $(x^2+y^2+z^2)^{n+1-1/2}$
  - 🔍 Chercher : « (a) The surface is g(x,y,z)=x²+y²+z²-a²=0 » (anglais)
- **Ligne 444** (et cascades aux lignes 449, 462) — exercice du cône solide (flux, partie c) : signe erroné sur les composantes $\mathbf{i},\mathbf{j}$ du produit vectoriel $\partial\mathbf{r}/\partial r \times \partial\mathbf{r}/\partial\theta$, confirmé par 3 méthodes indépendantes. Sans incidence sur la réponse finale $\pi/3$.
  - Avant : $\partial\mathbf{r}/\partial r \times \partial\mathbf{r}/\partial\theta = -r\cos\theta\,\mathbf{i} - r\sin\theta\,\mathbf{j} + r\,\mathbf{k}$
  - Après : $\partial\mathbf{r}/\partial r \times \partial\mathbf{r}/\partial\theta = r\cos\theta\,\mathbf{i} + r\sin\theta\,\mathbf{j} + r\,\mathbf{k}$
  - 🔍 Chercher : « So we may parametrize the top part of the cone by » (anglais)

### Sec-Stokes.ptx (commit `2fdcee8`)
- **Ligne 1226** — vérification du théorème de Stokes sur un exemple, coefficient perdu (sans incidence sur la réponse finale de l'exemple).
  - Avant : $(\nabla\times\mathbf{F})\cdot\mathbf{n} = \dots = y^2-4yz+2x = y^2-4y^3+2x$
  - Après : $(\nabla\times\mathbf{F})\cdot\mathbf{n} = \dots = 2y^2-4yz+2x = 2y^2-4y^3+2x$
  - 🔍 Chercher : « Le paramétrage donné de C lui impose une orientation. Lorsque vue d'en haut »

### Prob-sec-Stokes.ptx (commit `2fdcee8`)
Pattern de corruption `\int{\cD}` (au lieu de $\iint_{\mathcal{D}}$) à 7 reprises — bug d'affichage seulement, aucune incidence sur les valeurs numériques. Pas de recherche ciblée nécessaire (les formules affectées se trouvent réparties dans plusieurs exercices de flux sur des disques).

### Sec-Divergence.ptx (commit `5b0c4d5`)
- **Ligne 103** — produit scalaire manquant, $\nabla\mathbf{F}$ au lieu de $\nabla\cdot\mathbf{F}$.
  - Avant : $\nabla\mathbf{F} = \text{div}\,\mathbf{F} = P_x+Q_y+R_z = 3x^2+3y^2+3z^2$
  - Après : $\nabla\cdot\mathbf{F} = \text{div}\,\mathbf{F} = P_x+Q_y+R_z = 3x^2+3y^2+3z^2$
  - 🔍 Chercher : « Soit E la boule unité, c'est à dire la région de R³ vérifiant »
- **Ligne 126** — vecteurs unitaires $\mathbf{i},\mathbf{j},\mathbf{k}$ parasites accolés à une divergence (qui est un scalaire).
  - Avant : $\nabla\cdot\mathbf{F} = \text{div}\,\mathbf{F} = P_x\mathbf{i} + Q_y\mathbf{j} + R_z\mathbf{k} = y+2y+0 = 3y$
  - Après : $\nabla\cdot\mathbf{F} = \text{div}\,\mathbf{F} = P_x + Q_y + R_z = y+2y+0 = 3y$
  - 🔍 Chercher : « Soit E la région limitée par le cylindre y=x² et les plans z=0 et y+z=1 »
- **Ligne 136** — erreur de calcul arithmétique dans une intégrale triple.
  - Avant : $= \dfrac{8}{35}$
  - Après : $= \dfrac{24}{35}$
  - 🔍 Chercher : « Le Théorème de la divergence nous permet de ramener le calcul de l'intégrale de flux à une intégrale triple »
- **Ligne 292** — coquille d'indice (le disque utilisé dans cette formule est $D_2$, pas $D_1$).
  - Avant : $\displaystyle\iint_{D_1} \mathbf{F}\cdot d\mathbf{S} = 2\,\text{Aire}(D_2) = 2\pi\cdot2^2 = 8\pi$
  - Après : $\displaystyle\iint_{D_2} \mathbf{F}\cdot d\mathbf{S} = 2\,\text{Aire}(D_2) = 2\pi\cdot2^2 = 8\pi$
  - 🔍 Chercher : « Le vecteur normal pour le disque horizontal D₂ est +k »
- **Ligne 303** — signe manquant rendant l'équation interne incohérente (l'aire est positive, le flux négatif).
  - Avant : $\displaystyle\iint_{D_1} \mathbf{F}\cdot d\mathbf{S} = \text{Aire}(D_1) = -\pi\cdot1^2 = -\pi$
  - Après : $\displaystyle\iint_{D_1} \mathbf{F}\cdot d\mathbf{S} = -\text{Aire}(D_1) = -\pi\cdot1^2 = -\pi$
  - 🔍 Chercher : « De la même façon, le vecteur normal au disque horizontal D₁ est -k »
- **Lignes 576–577** — preuve de l'existence d'un potentiel vecteur, erreur de signe dans une dérivée partielle, se propageant jusqu'au champ final.
  - Avant : $\dfrac{\partial}{\partial x}(-2xz+\varphi) = -2x+\varphi_x$ (faux : la dérivée de $-2xz$ par rapport à $x$ est $-2z$), menant à $\mathbf{F} = (z^2+2xz)\mathbf{i} + (x^2-2xz)\mathbf{j}$
  - Après : $\dfrac{\partial}{\partial x}(-2xz+\varphi) = -2z+\varphi_x$, menant à $\mathbf{F} = (z^2-2xz)\mathbf{i} + (x^2-2xz)\mathbf{j}$
  - 🔍 Chercher : « Finalement, la troisième égalité est satisfaite si et seulement si » ou « Un choix possible est φ(x,y) = x² »

### Prob-sec-Divergence.ptx (commit `5b0c4d5`, fichier le plus gros du projet — 5180 lignes, entièrement relu et vérifié à la main)
- **Ligne 611** — domaine d'intégration, signe $+$ manquant.
  - Avant : $z=1-x^2-y^2$ pour $x^2y^2 \leq 1$
  - Après : $z=1-x^2-y^2$ pour $x^2+y^2 \leq 1$
  - 🔍 Chercher : « Évaluer, par deux méthodes, l'intégrale »
- **Ligne 3698** — produit scalaire, virgule manquante transformant deux composantes en une seule (sans incidence sur le résultat final, qui utilisait déjà la bonne valeur).
  - Avant : $(y,x,3)\cdot(-y-x,1)$
  - Après : $(y,x,3)\cdot(-y,-x,1)$
  - 🔍 Chercher : « The '+' sign gives the upward normal, so the specified upward flux is » (anglais)
- **Ligne 4919** — composante $F_1$ du champ incohérente avec le champ défini dans l'énoncé (vérifié : sans impact sur la réponse finale car la composante $\mathbf{i}$ du vecteur normal était nulle dans ce produit scalaire).
  - Avant : $\mathbf{F} = (2x,\ 2y,\ -2y^2)$
  - Après : $\mathbf{F} = (x^2,\ 2y,\ -2y^2)$
  - 🔍 Chercher : « On S_top, z=y², so F = » (anglais)

---

## Annexes SageMath (chapitre 4)

### App-Sage-Vect-Courbes.ptx (commit `9e1acaa`)
- **Ligne 72** — paramétrage $\mathbf{r}(s)$, variable de la mention de domaine incohérente avec le paramétrage (utilise $s$, pas $t$).
  - Avant : $\dots \qquad t\in\mathbb{R}.$
  - Après : $\dots \qquad s\in\mathbb{R}.$
  - 🔍 Chercher : « Notons cependant que dans les notes, afin de mieux visualiser la courbe, elle est dessinée avec le cône et plan »

(App-Sage-Integral-Vectoriel.ptx, App-Sage-General.ptx : aucune erreur mathématique.)

---

## Hors-chapitres

Aucune erreur mathématique — `docinfo.ptx`, `frontmatter.ptx`, `backmatter.ptx`, `main.ptx` ne contiennent pas de contenu mathématique substantiel.
