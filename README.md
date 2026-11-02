# MyOwnCourse — Modèle de cours LaTeX

Ce dossier est un **modèle de cours prêt à remplir**. Il reprend le style
graphique du cours *Spring Boot 4 & Java 25* : page de titre bleu profond,
pages de chapitre, encadrés colorés, blocs de code, tableaux, etc.

Tout le code est affiché en **JetBrains Mono Bold**, police fournie dans le
dossier `fonts/`.

Le contenu est volontairement **vide** : les chapitres 1 et 2 ne contiennent
que des textes de remplacement entre `[crochets]`. Vous n'avez plus qu'à
remplacer ces textes par votre propre cours.

> **Important :** ce template se compile avec **LuaLaTeX**, pas avec
> pdfLaTeX. Utilisez `compile.sh` ou la commande `lualatex main.tex`.

---

## Sommaire

1. [À quoi sert chaque fichier](#1-à-quoi-sert-chaque-fichier)
2. [Prérequis et installation](#2-prérequis-et-installation)
3. [Compiler le cours](#3-compiler-le-cours)
4. [Personnaliser la page de titre](#4-personnaliser-la-page-de-titre)
5. [Ajouter un chapitre 1, 2, 3...](#5-ajouter-un-chapitre-1-2-3)
6. [Remplir un chapitre](#6-remplir-un-chapitre)
7. [Écrire du texte et des descriptions](#7-écrire-du-texte-et-des-descriptions)
8. [Insérer du code](#8-insérer-du-code)
9. [Utiliser les encadrés](#9-utiliser-les-encadrés)
10. [Tableaux, images, mathématiques et liens](#10-tableaux-images-mathématiques-et-liens)
11. [Voir le chapitre de démonstration](#11-voir-le-chapitre-de-démonstration)
12. [Erreurs fréquentes et solutions](#12-erreurs-fréquentes-et-solutions)
13. [Checklist avant de compiler](#13-checklist-avant-de-compiler)
14. [Aide-mémoire rapide](#14-aide-mémoire-rapide)
15. [Nettoyer les fichiers générés](#15-nettoyer-les-fichiers-générés)

---

## 1. À quoi sert chaque fichier ?

```text
MyOwnCourse/
├── main.tex                  ← fichier principal : titre, sommaire, liste des chapitres
├── config.tex                ← TOUT ce que vous personnalisez (titre, auteur, en-tête)
├── preamble.tex              ← moteur de style : NE PAS MODIFIER
├── compile.sh                ← script de compilation
├── test-font.tex             ← document de test de la police
├── test-font.sh              ← script de vérification automatique
├── README.md                 ← ce guide
├── .gitignore                ← fichiers LaTeX à ne pas versionner
├── chapitres/
│   ├── ch1.tex               ← chapitre 1 (à remplir)
│   ├── ch2.tex               ← chapitre 2 (à remplir)
│   ├── modele-chapitre.tex   ← modèle vierge à copier pour un nouveau chapitre
│   └── demo.tex              ← démonstration de toutes les fonctionnalités
├── fonts/
│   ├── JetBrainsMono-Regular.ttf
│   ├── JetBrainsMono-Bold.ttf
│   ├── JetBrainsMono-Italic.ttf
│   ├── JetBrainsMono-BoldItalic.ttf
│   └── OFL.txt               ← licence SIL Open Font License
└── images/
    └── README.md             ← mode d'emploi des images
```

| Fichier | Rôle |
|---|---|
| `main.tex` | Page de titre, table des matières, ordre des chapitres. |
| `config.tex` | Titre du cours, sous-titre, auteur, édition, texte de l'en-tête. |
| `preamble.tex` | Couleurs, polices, encadrés, styles de code. **Ne pas modifier.** |
| `test-font.tex` | Document de test visuel de la police de code. |
| `test-font.sh` | Compile le test et vérifie automatiquement JetBrains Mono Bold. |
| `chapitres/ch1.tex` | Contenu du chapitre 1. |
| `chapitres/ch2.tex` | Contenu du chapitre 2. |
| `chapitres/modele-chapitre.tex` | Squelette à copier pour créer un chapitre 3, 4, etc. |
| `chapitres/demo.tex` | Exemple complet, non inclus par défaut. |
| `fonts/` | Polices JetBrains Mono et licence OFL. |
| `images/` | Dossier où placer vos captures et schémas. |

---

## 2. Prérequis et installation

Il faut :

- **TeX Live** (ou MiKTeX) avec **LuaLaTeX** ;
- la police **Liberation Sans** pour le texte ;
- **JetBrains Mono** pour le code : elle est **déjà fournie** dans le dossier
  `fonts/`, vous n'avez donc rien à installer.

### Vérifier que LuaLaTeX est installé

```bash
lualatex --version
```

Si la commande n'existe pas, installez TeX Live. Sous Ubuntu / Debian :

```bash
sudo apt update
sudo apt install texlive-full fonts-liberation
```

> `texlive-full` est volumineux. Une installation plus légère peut suffire :
>
> ```bash
> sudo apt install texlive-luatex texlive-latex-extra texlive-lang-french \
>                  texlive-fonts-recommended fonts-liberation
> ```

### Vérifier les polices

```bash
fc-list | grep -i "Liberation Sans"
ls fonts/JetBrainsMono-*.ttf
```

Si Liberation Sans manque, le message d'erreur ressemble à :

```text
! Package fontspec Error: The font "Liberation Sans" cannot be found.
```

Dans ce cas, installez `fonts-liberation`, ou modifiez les lignes
`\setmainfont` et `\setsansfont` dans `preamble.tex`.

Si le message concerne **JetBrains Mono**, vérifiez que le dossier `fonts/`
est bien présent à côté de `main.tex`, et compilez depuis le dossier
`MyOwnCourse` (le chemin `Path=fonts/` est relatif à ce dossier).

---

## 3. Compiler le cours

### Méthode simple : le script

```bash
cd MyOwnCourse
chmod +x compile.sh
./compile.sh
```

Le script lance **deux fois** LuaLaTeX. C'est nécessaire pour que la table
des matières et les numéros de page soient corrects.

### Méthode manuelle

```bash
lualatex --interaction=nonstopmode main.tex
lualatex --interaction=nonstopmode main.tex
```

Le résultat est le fichier **`main.pdf`**.

> **Ne pas utiliser `pdflatex`.** Le template utilise `fontspec` et les
> polices système, qui fonctionnent avec LuaLaTeX (ou XeLaTeX).

### Vérifier la police de code

Un test automatique est fourni :

```bash
chmod +x test-font.sh
./test-font.sh
```

Le script :

1. compile `test-font.tex` ;
2. affiche les polices réellement intégrées dans le PDF ;
3. vérifie la présence de `JetBrainsMono-Bold` ;
4. vérifie aussi la variante `JetBrainsMono-BoldItalic` utilisée pour les
   commentaires ;
5. produit le PDF de contrôle **`test-font.pdf`**.

Sortie attendue :

```text
OK : JetBrains Mono Bold est bien utilisée pour le code.
OK : la variante Bold Italic est aussi utilisée pour les commentaires.
PDF de contrôle : test-font.pdf
```

Ouvrez `test-font.pdf` pour contrôler visuellement le rendu : code inline,
bloc Java, bloc Python et test de tous les caractères.

---

## 4. Personnaliser la page de titre

Ouvrez **`config.tex`** et modifiez uniquement les textes :

```latex
\newcommand{\coursTitre}{TITRE DE VOTRE COURS}
\newcommand{\coursSousTitre}{Sous-titre de votre cours}
\newcommand{\coursBandeau}{SUPPORT DE COURS · ÉDITION 2026}
\newcommand{\coursAuteur}{Prénom Nom}
\newcommand{\coursVersion}{Édition 2026}
\newcommand{\coursEntete}{Mon cours — Support de formation}
\newcommand{\coursBandeauChapitre}{SUPPORT DE COURS}
```

| Commande | Où apparaît-elle ? |
|---|---|
| `\coursTitre` | Grand titre blanc sur la page de titre. |
| `\coursSousTitre` | Sous-titre turquoise sous le titre. |
| `\coursBandeau` | Petite ligne au-dessus du titre. |
| `\coursAuteur` | En bas à gauche de la page de titre. |
| `\coursVersion` | En bas à droite de la page de titre. |
| `\coursEntete` | En-tête de toutes les pages (gardez-le court). |
| `\coursBandeauChapitre` | Petite ligne sous « Chapitre 1 » (gardez-la courte). |

> `config.tex` contient aussi `\coursCodeSize`, qui règle la taille du code.
> Voir la section **« Modifier la taille du code »** plus bas.

Exemple concret :

```latex
\newcommand{\coursTitre}{RÉSEAUX INFORMATIQUES}
\newcommand{\coursSousTitre}{De la théorie à la pratique}
\newcommand{\coursBandeau}{LICENCE 3 · ÉDITION 2026}
\newcommand{\coursAuteur}{Alice Martin}
\newcommand{\coursVersion}{Édition 2026}
\newcommand{\coursEntete}{Réseaux — Support de cours}
\newcommand{\coursBandeauChapitre}{RÉSEAUX INFORMATIQUES}
```

---

## 5. Ajouter un chapitre 1, 2, 3...

### Étape 1 — Copier le modèle

Le plus simple est de copier le fichier `chapitres/modele-chapitre.tex` :

```bash
cd MyOwnCourse
cp chapitres/modele-chapitre.tex chapitres/ch3.tex
```

Vous pouvez aussi copier `ch1.tex` :

```bash
cp chapitres/ch1.tex chapitres/ch3.tex
```

### Étape 2 — Modifier le titre du chapitre

Dans `chapitres/ch3.tex`, changez la première ligne :

```latex
\chapitre{3}{Titre du chapitre 3}
```

Le **premier argument** est le numéro affiché. Il doit suivre l'ordre des
chapitres : 1, 2, 3, etc. Le **deuxième argument** est le titre.

### Étape 3 — Renuméroter les sections

Les sections sont numérotées **manuellement**. Pour le chapitre 3, utilisez
`3.1`, `3.1.1`, `3.2`, etc. :

```latex
\soussection{3.1}{Première section du chapitre 3}
\soussoussection{3.1.1}{Première sous-section}
\soussoussection{3.1.2}{Deuxième sous-section}
\soussection{3.2}{Deuxième section du chapitre 3}
```

> Si vous insérez un nouveau chapitre au milieu, pensez à renuméroter les
> chapitres suivants **et** leurs sections.

### Étape 4 — Ajouter le chapitre dans `main.tex`

Ouvrez `main.tex` et ajoutez la ligne dans la section « Chapitres » :

```latex
\input{chapitres/ch1}
\input{chapitres/ch2}
\input{chapitres/ch3}
```

L'ordre des `\input` est l'ordre d'apparition dans le PDF.

### Étape 5 — Compiler deux fois

```bash
./compile.sh
```

### Supprimer ou masquer un chapitre

Pour retirer un chapitre, commentez simplement son `\input` avec `%` :

```latex
\input{chapitres/ch1}
% \input{chapitres/ch2}
\input{chapitres/ch3}
```

Le fichier `ch2.tex` reste sur le disque, mais il n'apparaît plus dans le PDF.

---

## 6. Remplir un chapitre

Un chapitre est un fichier `.tex` qui commence toujours par :

```latex
\chapitre{1}{Titre du chapitre 1}
```

Ensuite, vous ajoutez des sections, des sous-sections, du texte, des
encadrés, des blocs de code, etc.

### Structure minimale d'un chapitre

```latex
\chapitre{1}{Les bases}

\begin{objectifs}
\begin{itemize}
  \item Comprendre le premier concept.
  \item Savoir appliquer le deuxième concept.
\end{itemize}
\end{objectifs}

\soussection{1.1}{Introduction}

Ceci est une description. Un paragraphe normal s'écrit directement,
sans commande spéciale.

\soussoussection{1.1.1}{Premier détail}

Voici le contenu détaillé du premier point.

\soussection{1.2}{Deuxième partie}

Voici la suite du chapitre.

\begin{resume}
Résumé des points essentiels du chapitre.
\end{resume}
```

### Les trois niveaux de titres

| Commande | Résultat | Exemple |
|---|---|---|
| `\chapitre{1}{Titre}` | Page de chapitre avec bandeau bleu | `\chapitre{1}{Introduction}` |
| `\soussection{1.1}{Titre}` | Titre de section turquoise | `\soussection{1.1}{Les bases}` |
| `\soussoussection{1.1.1}{Titre}` | Titre de sous-section bleu | `\soussoussection{1.1.1}{Détail}` |

> **N'utilisez pas** `\chapter{...}`, `\section{...}` ou `\subsection{...}` :
> ces commandes produiraient le style standard de LaTeX, différent du style
> du cours. Utilisez toujours `\chapitre`, `\soussection` et
> `\soussoussection`.

---

## 7. Écrire du texte et des descriptions

### Paragraphes

Une ligne vide sépare deux paragraphes :

```latex
Ceci est le premier paragraphe.

Ceci est le deuxième paragraphe.
```

### Mise en forme

```latex
Texte en \textbf{gras}.
Texte en \textit{italique}.
Texte \underline{souligné}.
Un nom technique : \code{maVariable}.
Un concept important : \motcle{inversion de contrôle}.
```

- `\textbf{...}` : gras.
- `\textit{...}` : italique.
- `\underline{...}` : souligné.
- `\code{...}` : code court en police monospace avec fond gris.
- `\motcle{...}` : terme coloré en turquoise.

### Listes

Liste à puces :

```latex
\begin{itemize}
  \item Premier point.
  \item Deuxième point.
  \item Troisième point.
\end{itemize}
```

Liste numérotée :

```latex
\begin{enumerate}
  \item Première étape.
  \item Deuxième étape.
  \item Troisième étape.
\end{enumerate}
```

Listes imbriquées :

```latex
\begin{itemize}
  \item Premier point.
  \begin{enumerate}
    \item Sous-point un.
    \item Sous-point deux.
  \end{enumerate}
\end{itemize}
```

### Commentaires dans le code LaTeX

Tout ce qui suit un `%` est ignoré jusqu'à la fin de la ligne :

```latex
% Ceci est un commentaire, invisible dans le PDF.
Ceci est du texte visible. % Ce commentaire aussi est invisible.
```

### Caractères spéciaux

En dehors des blocs de code, certains caractères doivent être échappés :

| Caractère | À écrire | Exemple |
|---|---|---|
| `%` | `\%` | `100\%` |
| `_` | `\_` | `mon\_fichier` |
| `&` | `\&` | `A \& B` |
| `#` | `\#` | `\#1` |
| `$` | `\$` | `50 \$` |
| `{` | `\{` | `\{valeur\}` |
| `}` | `\}` | `\{valeur\}` |
| `\` | `\textbackslash{}` | `C:\textbackslash{}Users` |

Pour éviter ces problèmes, utilisez `\code{...}` pour les noms techniques :

```latex
Le fichier \code{src/main/java/Application.java} contient la méthode
\code{main}.
```

> `\code{...}` gère bien `_`, `/`, `@`, les points, etc. Pour un `%` dans
> du code court, écrivez plutôt `\texttt{100\%}`.

---

## 8. Insérer du code

### Bloc de code simple

```latex
\begin{lstlisting}[style=java,caption={Ma classe Java}]
public class Exemple {
    public static void main(String[] args) {
        System.out.println("Bonjour");
    }
}
\end{lstlisting}
```

- `style=java` choisit la coloration syntaxique.
- `caption={...}` est optionnel : il ajoute une légende sous le code.
- Le contenu entre `\begin{lstlisting}` et `\end{lstlisting}` est affiché
  **tel quel**.

### Styles disponibles

| Style | Langage / usage |
|---|---|
| `java` | Java (et annotations Spring) |
| `python` | Python |
| `gradle` | Gradle Groovy (`build.gradle`) |
| `properties` | Fichiers `.properties` |
| `bash` | Commandes shell / terminal |
| `json` | JSON |
| `sql` | SQL |
| `html` | HTML |
| `xml` | XML |
| `c` | C |
| `cpp` | C++ |
| `text` | Texte brut, sans coloration |

Exemples :

```latex
\begin{lstlisting}[style=python,caption={Fonction Python}]
def salutation(nom: str) -> str:
    return f"Bonjour, {nom} !"
\end{lstlisting}

\begin{lstlisting}[style=bash,caption={Compilation}]
lualatex main.tex
lualatex main.tex
\end{lstlisting}

\begin{lstlisting}[style=properties,caption={Configuration}]
serveur.port=8080
serveur.hote=localhost
\end{lstlisting}
```

### Code court dans une phrase

```latex
La méthode \code{main} se trouve dans \code{Application.java}.
```

### Police du code : JetBrains Mono Bold

Tous les blocs `lstlisting` et tout le code inline `\code{...}` utilisent
**JetBrains Mono Bold**. Les fichiers de police sont fournis dans `fonts/`
et sont chargés par `preamble.tex` :

```latex
\setmonofont{JetBrains Mono}[
  Path=fonts/,
  UprightFont=JetBrainsMono-Regular.ttf,
  BoldFont=JetBrainsMono-Bold.ttf,
  ItalicFont=JetBrainsMono-Italic.ttf,
  BoldItalicFont=JetBrainsMono-BoldItalic.ttf,
  Scale=0.95
]
```

Le gras est appliqué :

- dans les blocs de code, par `basicstyle=\ttfamily\bfseries\coursCodeSize` ;
- dans le code inline, par `\bfseries` dans la commande `\code`.

### Modifier la taille du code

La taille est centralisée dans **`config.tex`** :

```latex
% Valeurs possibles : \footnotesize, \small, \normalsize, \large
\newcommand{\coursCodeSize}{\normalsize}
```

Changez simplement la valeur selon le rendu souhaité :

| Valeur | Taille approximative | Usage |
|---|---|---|
| `\footnotesize` | 8 pt | code très compact |
| `\small` | 9 pt | code compact |
| `\normalsize` | 10 pt | **valeur par défaut** |
| `\large` | 12 pt | code plus grand, très lisible |

Par exemple, pour un code plus petit :

```latex
\newcommand{\coursCodeSize}{\small}
```

Pour un code plus grand :

```latex
\newcommand{\coursCodeSize}{\large}
```

Cette commande s'applique **aux blocs de code et au code inline**.

Le facteur `Scale=0.95` de `\setmonofont` ajuste aussi la taille relative de
JetBrains Mono. Passez à `Scale=1.0` pour agrandir encore, ou à `Scale=0.9`
pour réduire légèrement.

Pour revenir à une police de code **non grasse**, remplacez dans
`preamble.tex` :

```latex
basicstyle=\ttfamily\bfseries\coursCodeSize
```

par :

```latex
basicstyle=\ttfamily\coursCodeSize
```

puis retirez `\bfseries` de la définition de `\code` :

```latex
\DeclareRobustCommand{\code}[1]{%
  \texorpdfstring{\colorbox{codebg}{\texttt{\coursCodeSize\color{deepblue!90}\detokenize{#1}}}}{\detokenize{#1}}%
}
```

Pour utiliser une autre police de code, remplacez le bloc `\setmonofont`
ci-dessus par le nom de la police souhaitée.

Pour vérifier automatiquement que la police est bien appliquée, lancez :

```bash
./test-font.sh
```

Le test doit afficher `OK : JetBrains Mono Bold est bien utilisée pour le code.`

### Règles importantes pour les blocs de code

- Dans un `lstlisting`, **pas besoin d'échapper** `%`, `_`, `&`, `#`, `$`.
  Ils sont affichés littéralement.
- Ne mettez pas la ligne `\end{lstlisting}` à l'intérieur du code, sinon
  LaTeX croira que le bloc se termine.
- Les accents fonctionnent avec LuaLaTeX et un fichier encodé en UTF-8.
- L'option `breaklines=true` est déjà active : les lignes trop longues
  sont coupées avec une flèche.
- Pour changer la langue d'un bloc, remplacez simplement `style=java` par
  `style=python`, `style=sql`, etc.

### Ajouter un nouveau langage (optionnel)

Si vous avez besoin d'un langage qui n'existe pas dans la liste, ajoutez
un style dans `preamble.tex`, par exemple pour du Ruby :

```latex
\lstdefinestyle{ruby}{style=coursbase,language=Ruby}
```

Puis utilisez :

```latex
\begin{lstlisting}[style=ruby]
puts "Bonjour"
\end{lstlisting}
```

---

## 9. Utiliser les encadrés

Les encadrés sont des blocs colorés avec un titre. Ils s'utilisent tous de
la même façon :

```latex
\begin{nom-de-l-encadre}
Votre texte ici.
\end{nom-de-l-encadre}
```

### Liste des encadrés

| Environnement | Titre affiché | Utilisation |
|---|---|---|
| `objectifs` | Objectifs du chapitre | Ce que le lecteur va apprendre. |
| `definition` | Définition | Définir un concept. |
| `retenir` | À retenir | L'essentiel à mémoriser. |
| `attention` | Attention | Point dangereux ou erreur à éviter. |
| `piege` | Piège classique | Piège fréquent et comment l'éviter. |
| `conseil` | Conseil | Bonne pratique ou astuce. |
| `choix` | Choix recommandé | Justifier un choix technique. |
| `atelier` | Atelier | Exercice ou activité pratique. |
| `resume` | En résumé | Synthèse de fin de chapitre. |

### Exemples

```latex
\begin{objectifs}
À la fin de ce chapitre, vous saurez :
\begin{itemize}
  \item expliquer le concept ;
  \item appliquer la méthode ;
  \item éviter les erreurs classiques.
\end{itemize}
\end{objectifs}

\begin{definition}
Un \textbf{bean} est un objet Java dont le cycle de vie est géré par le
conteneur.
\end{definition}

\begin{retenir}
Une méthode \textbf{idempotente} produit le même résultat si on l'exécute
plusieurs fois.
\end{retenir}

\begin{attention}
Ne stockez jamais un mot de passe en clair dans un fichier de configuration.
\end{attention}

\begin{piege}
\textbf{Oublier de compiler deux fois.} La table des matières peut être
vide ou obsolète après une seule compilation.
\end{piege}

\begin{conseil}
Exécutez \code{./compile.sh} après chaque modification importante.
\end{conseil}

\begin{choix}
Préférez l'injection par constructeur : elle garantit l'immuabilité et
facilite les tests unitaires.
\end{choix}

\begin{atelier}
Créez un chapitre 3, ajoutez une section et un bloc de code, puis compilez.
\end{atelier}

\begin{resume}
Les encadrés servent à guider la lecture : objectifs, définitions, pièges,
conseils et résumé.
\end{resume}
```

> Les encadrés peuvent contenir du texte, des listes, du code et même des
> tableaux. Ils sont automatiquement coupés entre deux pages si nécessaire.

---

## 10. Tableaux, images, mathématiques et liens

### Tableaux

Le template utilise `booktabs` (lignes propres) et `tabularx` (largeur
automatique) :

```latex
\begin{table}[htbp]
\centering
\small
\begin{tabularx}{\textwidth}{lX}
\toprule
\textbf{Colonne 1} & \textbf{Colonne 2} \\
\midrule
Valeur courte & Description longue qui peut passer à la ligne automatiquement. \\
\code{GET} & Lecture d'une ressource. \\
\code{POST} & Création d'une ressource. \\
\bottomrule
\end{tabularx}
\caption{Mon tableau}
\end{table}
```

Explication des colonnes :

| Lettre | Signification |
|---|---|
| `l` | Colonne alignée à gauche, largeur naturelle. |
| `c` | Colonne centrée. |
| `r` | Colonne alignée à droite. |
| `X` | Colonne qui prend toute la largeur restante et passe à la ligne. |
| `p{4cm}` | Colonne de largeur fixe (4 cm). |

### Images

1. Placez l'image dans le dossier `images/`.
2. Utilisez son chemin **relatif à `main.tex`** :

```latex
\begin{figure}[htbp]
\centering
\includegraphics[width=0.75\linewidth]{images/mon-schema.png}
\caption{Description de l'image}
\label{fig:mon-schema}
\end{figure}
```

Pour faire référence à l'image dans le texte :

```latex
Comme le montre la figure~\ref{fig:mon-schema}, ...
```

- `width=0.75\linewidth` : l'image occupe 75 % de la largeur du texte.
- `width=10cm` : largeur fixe.
- Formats conseillés : **PDF** (schémas vectoriels), **PNG** ou **JPG**
  (captures d'écran).
- Si l'image est introuvable, vérifiez le nom, l'extension et le chemin.

### Mathématiques

Dans une phrase, entre dollars :

```latex
La formule $E = mc^2$ est célèbre.
```

En bloc centré :

```latex
\[
  f(x) = \sum_{i=1}^{n} x_i^2
\]
```

Ou avec un numéro d'équation :

```latex
\begin{equation}
  f(x) = \sum_{i=1}^{n} x_i^2
\end{equation}
```

### Liens

```latex
\url{https://example.com}

\href{https://example.com}{Cliquez ici}
```

Le premier affiche l'adresse brute, le second affiche un texte cliquable.

### Sauts de page

```latex
\newpage
```

ou, pour vider aussi les images et tableaux en attente :

```latex
\clearpage
```

Évitez d'en abuser : LaTeX gère automatiquement les sauts de page.

---

## 11. Voir le chapitre de démonstration

Le fichier `chapitres/demo.tex` contient **tous les exemples** : texte,
listes, neuf encadrés, blocs de code Java/Python/JSON/bash/properties,
tableau, formule mathématique et lien.

Pour l'afficher :

1. Ouvrez `main.tex`.
2. Décommentez la ligne :

```latex
\input{chapitres/demo}
```

3. Compilez :

```bash
./compile.sh
```

Le chapitre 3 de démonstration apparaît à la fin du PDF.

> Ce chapitre porte le numéro 3. Si vous ajoutez déjà un chapitre 3 réel,
> changez le numéro dans `demo.tex` ou supprimez la ligne après consultation.

Pour le masquer à nouveau, remettez un `%` devant la ligne :

```latex
% \input{chapitres/demo}
```

---

## 12. Erreurs fréquentes et solutions

| Message / problème | Cause probable | Solution |
|---|---|---|
| `Undefined control sequence` | Commande mal orthographiée ou inexistante. | Vérifiez l'orthographe ; utilisez les commandes de ce guide. |
| `Missing $ inserted` | Un `_` ou `^` est utilisé hors mode mathématique. | Écrivez `\_` ou utilisez `\code{...}`. |
| `Runaway argument?` | Une accolade `{` ou un `\end{...}` manque. | Vérifiez que chaque `\begin{...}` a son `\end{...}`. |
| `Environment ... undefined` | Nom d'environnement mal orthographié. | Utilisez exactement `attention`, `piege`, `retenir`, etc. |
| `File ... not found` | Image ou fichier inclus introuvable. | Vérifiez le chemin et l'extension. |
| Table des matières vide | Une seule compilation a été faite. | Compilez deux fois (`./compile.sh`). |
| `There were undefined references` | Les références ne sont pas encore stables. | Recompilez une deuxième fois. |
| `The font "Liberation Sans" cannot be found` | Police de texte non installée. | Installez `fonts-liberation`. |
| `The font "JetBrains Mono" cannot be found` | Dossier `fonts/` absent ou compilation depuis un autre dossier. | Vérifiez `fonts/` et compilez depuis `MyOwnCourse`. |
| `! LaTeX Error: Something's wrong--perhaps a missing \item` | `\item` manquant dans une liste. | Ajoutez `\item` devant chaque élément. |
| `Overfull \hbox` | Une ligne dépasse la marge. | Reformulez, ajoutez `\linebreak`, ou ajustez le tableau. |
| Les accents sont mal affichés | Fichier non UTF-8 ou compilation avec pdfLaTeX. | Enregistrez en UTF-8 et compilez avec LuaLaTeX. |
| `%` coupe la fin de la phrase | Le `%` commence un commentaire. | Écrivez `\%` en dehors d'un bloc de code. |
| `&` provoque une erreur | `&` est un séparateur de colonnes. | Écrivez `\&` en dehors d'un tableau. |
| `#` provoque une erreur | `#` est un caractère spécial LaTeX. | Écrivez `\#`. |
| Un bloc de code ne se termine pas | La ligne `\end{lstlisting}` est présente dans le code. | Ne l'écrivez pas dans le contenu du bloc. |

### En cas de doute

1. Lisez la **première erreur** affichée : les suivantes sont souvent des
   conséquences.
2. Regardez le numéro de ligne indiqué.
3. Vérifiez les accolades, les `\begin` / `\end` et les commandes.
4. Comparez avec `chapitres/demo.tex`, qui compile correctement.

---

## 13. Checklist avant de compiler

- [ ] J'ai modifié `config.tex` (titre, sous-titre, auteur, édition).
- [ ] Mon chapitre commence par `\chapitre{numéro}{Titre}`.
- [ ] Les sections utilisent `\soussection{1.1}{...}` et `\soussoussection{1.1.1}{...}`.
- [ ] Les numéros de sections correspondent au numéro du chapitre.
- [ ] Chaque `\begin{...}` a son `\end{...}`.
- [ ] Les blocs `lstlisting` sont fermés.
- [ ] Les images sont présentes dans `images/`.
- [ ] J'ai compilé **deux fois** avec LuaLaTeX.
- [ ] J'ai lancé `./test-font.sh` et le test de police est OK.
- [ ] La table des matières est correcte.
- [ ] Le chapitre de démonstration est commenté si je ne veux pas le garder.
- [ ] Le PDF `main.pdf` s'ouvre et le rendu est propre.

---

## 14. Aide-mémoire rapide

```latex
% ---------- CHAPITRE ----------
\chapitre{1}{Titre du chapitre}
\soussection{1.1}{Titre de section}
\soussoussection{1.1.1}{Titre de sous-section}

% ---------- TEXTE ----------
\textbf{gras}
\textit{italique}
\underline{souligné}
\code{code court}
\motcle{terme important}

% ---------- LISTES ----------
\begin{itemize}
  \item Point.
\end{itemize}

\begin{enumerate}
  \item Étape.
\end{enumerate}

% ---------- CODE ----------
\begin{lstlisting}[style=java,caption={Légende}]
public class Exemple {}
\end{lstlisting}

% ---------- ENCADRÉS ----------
\begin{objectifs} ... \end{objectifs}
\begin{definition} ... \end{definition}
\begin{retenir} ... \end{retenir}
\begin{attention} ... \end{attention}
\begin{piege} ... \end{piege}
\begin{conseil} ... \end{conseil}
\begin{choix} ... \end{choix}
\begin{atelier} ... \end{atelier}
\begin{resume} ... \end{resume}

% ---------- TABLEAU ----------
\begin{table}[htbp]
\centering
\begin{tabularx}{\textwidth}{lX}
\toprule
\textbf{A} & \textbf{B} \\
\midrule
Valeur & Description. \\
\bottomrule
\end{tabularx}
\caption{Légende}
\end{table}

% ---------- IMAGE ----------
\begin{figure}[htbp]
\centering
\includegraphics[width=0.75\linewidth]{images/mon-image.png}
\caption{Légende}
\label{fig:mon-image}
\end{figure}

% ---------- LIEN ----------
\url{https://example.com}
\href{https://example.com}{Texte}

% ---------- SAUT DE PAGE ----------
\newpage
\clearpage
```

---

## 15. Nettoyer les fichiers générés

Après compilation, LaTeX crée des fichiers auxiliaires. Pour les supprimer :

```bash
rm -f main.aux main.log main.out main.toc main.listing
```

Pour tout nettoyer, y compris le PDF :

```bash
rm -f main.aux main.log main.out main.toc main.listing main.pdf
```

Ou, si `latexmk` est installé :

```bash
latexmk -C
```

---

**Bon cours !** Commencez par modifier `config.tex`, puis remplissez
`chapitres/ch1.tex` et `chapitres/ch2.tex`. Pour un nouveau chapitre,
copiez `chapitres/modele-chapitre.tex` et suivez la section 5.
