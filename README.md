# LATEX_COURSE — Modèle de cours LaTeX

Template de cours prêt à remplir, avec :

- une page de titre bleu profond ;
- des pages de chapitre avec bandeau ;
- des encadrés colorés ;
- des blocs de code en **JetBrains Mono Bold** ;
- une table des matières automatique.

Dépôt : **https://github.com/brahimlakhal3/LATEX_COURSE**

---

## Démarrage en 3 étapes

1. Personnalisez **`config.tex`** (titre, auteur, édition).
2. Remplissez **`chapitres/ch1.tex`** et **`chapitres/ch2.tex`**.
3. Compilez :

```bash
cd LATEX_COURSE
chmod +x compile.sh
./compile.sh
```

Le PDF est généré localement : **`main.pdf`**.

> **Règle d'or :** ne modifiez pas `preamble.tex` pour le contenu du cours.
> Ce fichier est le moteur de style. Pour personnaliser, utilisez
> `config.tex` et les fichiers du dossier `chapitres/`.

---

## 1. Configuration simple : `config.tex`

C'est le **seul fichier** à modifier pour la page de titre et les en-têtes.

```latex
\newcommand{\coursTitre}{TITRE DE VOTRE COURS}
\newcommand{\coursSousTitre}{Sous-titre de votre cours}
\newcommand{\coursBandeau}{SUPPORT DE COURS · ÉDITION 2026}
\newcommand{\coursAuteur}{Prénom Nom}
\newcommand{\coursVersion}{Édition 2026}
\newcommand{\coursEntete}{Mon cours — Support de formation}
\newcommand{\coursBandeauChapitre}{SUPPORT DE COURS}
```

| Commande | Rôle |
|---|---|
| `\coursTitre` | Grand titre de la page de couverture. |
| `\coursSousTitre` | Sous-titre sous le grand titre. |
| `\coursBandeau` | Petite ligne au-dessus du titre. |
| `\coursAuteur` | Nom en bas à gauche de la couverture. |
| `\coursVersion` | Édition en bas à droite. |
| `\coursEntete` | En-tête de toutes les pages (gardez-le court). |
| `\coursBandeauChapitre` | Petite ligne sous « Chapitre 1 » (gardez-la courte). |

### Taille du code

La taille est réglée dans `config.tex` :

```latex
% Valeurs : \footnotesize, \small, \normalsize, \large
\newcommand{\coursCodeSize}{\normalsize}
```

| Valeur | Taille approximative |
|---|---|
| `\footnotesize` | 8 pt |
| `\small` | 9 pt |
| `\normalsize` | 10 pt (actuel) |
| `\large` | 12 pt |

Cette valeur s'applique aux blocs de code **et** au code inline.

---

## 2. Modifier le cours

### 2.1 Ajouter un chapitre

Copiez le modèle :

```bash
cp chapitres/modele-chapitre.tex chapitres/ch3.tex
```

Modifiez la première ligne de `ch3.tex` :

```latex
\chapitre{3}{Titre du chapitre 3}
```

Puis ajoutez le chapitre dans **`main.tex`** :

```latex
\input{chapitres/ch1}
\input{chapitres/ch2}
\input{chapitres/ch3}
```

Compilez deux fois (`./compile.sh`).

> Le premier argument de `\chapitre` est le numéro affiché : il doit suivre
> l'ordre des chapitres. Les sections sont numérotées manuellement :
> `3.1`, `3.1.1`, etc.

Pour masquer un chapitre, commentez son `\input` avec `%` :

```latex
% \input{chapitres/ch2}
```

### 2.2 Titres

| Commande | Résultat |
|---|---|
| `\chapitre{1}{Titre}` | Page de chapitre avec bandeau. |
| `\soussection{1.1}{Titre}` | Section turquoise. |
| `\soussoussection{1.1.1}{Titre}` | Sous-section bleue. |

Exemple :

```latex
\chapitre{1}{Les bases}

\soussection{1.1}{Introduction}

Texte de la section.

\soussoussection{1.1.1}{Premier détail}

Texte du détail.
```

> N'utilisez pas `\chapter`, `\section` ou `\subsection` : le style du cours
> serait perdu.

### 2.3 Texte et description

Un paragraphe s'écrit directement, séparé par une ligne vide :

```latex
Ceci est le premier paragraphe.

Ceci est le deuxième paragraphe.
```

Mise en forme :

```latex
\textbf{texte en gras}
\textit{texte en italique}
\underline{texte souligné}
\code{nom_de_variable}
\motcle{terme important}
```

Listes :

```latex
\begin{itemize}
  \item Premier point.
  \item Deuxième point.
\end{itemize}

\begin{enumerate}
  \item Première étape.
  \item Deuxième étape.
\end{enumerate}
```

### 2.4 Code

Bloc de code :

```latex
\begin{lstlisting}[style=java,caption={Mon exemple Java}]
public class Exemple {
    public static void main(String[] args) {
        System.out.println("Bonjour");
    }
}
\end{lstlisting}
```

Styles disponibles :

| Style | Langage |
|---|---|
| `java` | Java |
| `python` | Python |
| `gradle` | Gradle Groovy |
| `properties` | Fichiers `.properties` |
| `bash` | Shell / terminal |
| `json` | JSON |
| `sql` | SQL |
| `html` | HTML |
| `xml` | XML |
| `c` | C |
| `cpp` | C++ |
| `text` | Texte brut |

Code court dans une phrase :

```latex
La méthode \code{main} se trouve dans \code{Application.java}.
```

> Dans un `lstlisting`, `%`, `_`, `&`, `#` et `$` s'écrivent normalement.
> En dehors d'un bloc de code, écrivez `\%`, `\_`, `\&`, `\#`, `\$`.

### 2.5 Encadrés

Tous les encadrés utilisent la même syntaxe :

```latex
\begin{nom-de-l-encadre}
Votre texte ici.
\end{nom-de-l-encadre}
```

| Environnement | Titre affiché |
|---|---|
| `objectifs` | Objectifs du chapitre |
| `definition` | Définition |
| `retenir` | À retenir |
| `attention` | Attention |
| `piege` | Piège classique |
| `conseil` | Conseil |
| `choix` | Choix recommandé |
| `atelier` | Atelier |
| `resume` | En résumé |

Exemples :

```latex
\begin{attention}
Ne stockez jamais un mot de passe en clair.
\end{attention}

\begin{piege}
Oublier de compiler deux fois peut laisser la table des matières vide.
\end{piege}

\begin{conseil}
Compilez après chaque modification importante.
\end{conseil}

\begin{resume}
Résumé des points essentiels du chapitre.
\end{resume}
```

### 2.6 Tableaux, images et liens

Tableau :

```latex
\begin{table}[htbp]
\centering
\small
\begin{tabularx}{\textwidth}{lX}
\toprule
\textbf{Colonne 1} & \textbf{Colonne 2} \\
\midrule
Valeur & Description qui passe à la ligne automatiquement. \\
\bottomrule
\end{tabularx}
\caption{Mon tableau}
\end{table}
```

Image :

```latex
\begin{figure}[htbp]
\centering
\includegraphics[width=0.75\linewidth]{images/mon-image.png}
\caption{Ma légende}
\label{fig:mon-image}
\end{figure}
```

Placez les images dans le dossier **`images/`**.

Lien :

```latex
\url{https://example.com}
\href{https://example.com}{Texte cliquable}
```

Saut de page :

```latex
\newpage
```

---

## 3. Erreurs fréquentes

| Message | Solution |
|---|---|
| `Undefined control sequence` | Commande mal orthographiée ou inexistante. |
| `Missing $ inserted` | Un `_` ou `^` est utilisé hors mode mathématique : écrivez `\_`. |
| `Runaway argument?` | Accolade `{` ou `\end{...}` manquant. |
| `Environment ... undefined` | Nom d'encadré mal orthographié. |
| `File ... not found` | Image ou fichier introuvable : vérifiez le chemin. |
| Table des matières vide | Compilez deux fois avec `./compile.sh`. |
| `The font "Liberation Sans" cannot be found` | Installez `fonts-liberation`. |
| `The font "JetBrains Mono" cannot be found` | Vérifiez le dossier `fonts/` et compilez depuis le dossier du projet. |

---

## 4. Structure du projet

```text
LATEX_COURSE/
├── main.tex                  ← page de titre, sommaire, liste des chapitres
├── config.tex                ← configuration simple du cours
├── preamble.tex              ← moteur de style (ne pas modifier)
├── compile.sh                ← compilation LuaLaTeX
├── README.md
├── chapitres/
│   ├── ch1.tex               ← chapitre 1
│   ├── ch2.tex               ← chapitre 2
│   └── modele-chapitre.tex   ← modèle pour un nouveau chapitre
├── fonts/                    ← JetBrains Mono + licence OFL
└── images/                   ← vos images
```

Les fichiers `.aux`, `.log`, `.toc` et les PDF générés ne sont pas versionnés.
Ils sont créés localement par la compilation.

---

## Aide-mémoire

```latex
% CHAPITRE
\chapitre{1}{Titre}
\soussection{1.1}{Titre}
\soussoussection{1.1.1}{Titre}

% TEXTE
\textbf{gras}
\textit{italique}
\code{code court}
\motcle{terme important}

% CODE
\begin{lstlisting}[style=java,caption={Légende}]
public class Exemple {}
\end{lstlisting}

% ENCADRÉS
\begin{objectifs} ... \end{objectifs}
\begin{definition} ... \end{definition}
\begin{retenir} ... \end{retenir}
\begin{attention} ... \end{attention}
\begin{piege} ... \end{piege}
\begin{conseil} ... \end{conseil}
\begin{choix} ... \end{choix}
\begin{atelier} ... \end{atelier}
\begin{resume} ... \end{resume}

% IMAGE
\begin{figure}[htbp]
\centering
\includegraphics[width=0.75\linewidth]{images/mon-image.png}
\caption{Légende}
\end{figure}

% LIEN
\url{https://example.com}
```

---

## Prérequis

- **LuaLaTeX** (TeX Live ou MiKTeX) ;
- la police **Liberation Sans** pour le texte ;
- **JetBrains Mono** est déjà fournie dans `fonts/`.

Sous Ubuntu / Debian :

```bash
sudo apt install texlive-luatex texlive-latex-extra texlive-lang-french \
                 texlive-fonts-recommended fonts-liberation
```

Compilation :

```bash
./compile.sh
```

---

**Bon cours !** Commencez par `config.tex`, puis remplissez les chapitres.
Pour un nouveau chapitre, copiez `chapitres/modele-chapitre.tex`.
