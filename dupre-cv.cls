\ProvidesClass{friggeri-bib}
\NeedsTeXFormat{LaTeX2e}

\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Packages & Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{anyfontsize}
\usepackage{array}
\usepackage[english]{babel}
\usepackage{color}
\usepackage{fontspec}
\usepackage{fancyhdr,lastpage}
\usepackage{hyperref}
\usepackage{lipsum}
\usepackage{paralist}
\usepackage[nodisplayskipstretch]{setspace}
\usepackage{tabularx}
\usepackage{vwcol}
\usepackage[dvipsnames]{xcolor}
\setmainfont[
   ItalicFont     = *-Italic,
   BoldFont       = *-Bold,
   BoldItalicFont = *-Bold Italic]{TeX Gyre Heros}
\definecolor{darkblue}{HTML}{003399}
\definecolor{sectiongray}{HTML}{6a6e75}
\definecolor{gray}{HTML}{4a484c}
\definecolor{lightgray}{HTML}{4e5158}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% STRUCTURE
%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Put section titles on left
\reversemarginpar

%% Set margins-- this has to be done after /reversemarginpar
\usepackage[paper=letterpaper, includefoot, % Put page number below margin
           marginparwidth=30mm, % Length of section titles
           marginparsep=2.5mm,    % Space between titles and text
           margin=1in,           % 1in margins
           includemp]{geometry}

%% Get rid of indenting throughout entire document
\setlength{\parindent}{0in}

%% Set color of links in document
\hypersetup{colorlinks,breaklinks,
            linkcolor=darkblue,urlcolor=darkblue,
            anchorcolor=darkblue,citecolor=darkblue,
            }

%% Number pages in CV
\pagestyle{fancy}
\fancyhf{}\renewcommand{\headrulewidth}{0pt}
\fancyfootoffset{\marginparsep+\marginparwidth}
\newlength{\footpageshift}
\setlength{\footpageshift}
          {0.5\textwidth+0.5\marginparsep+0.5\marginparwidth-2in}
\lfoot{\hspace{\footpageshift}%
       \parbox{4in}{\, \hfill %
                    \arabic{page} of \protect\pageref*{LastPage}
                    \hfill \,}}

%% An itemize-style list with little space between items
\newenvironment{innerlist}[1][\enskip\textbullet]%
        {\begin{compactitem}[#1]}{\end{compactitem}}

%% An itemize-style list with lots of space between items
\newenvironment{outerlist}[1][\enskip\textbullet]%
        {\begin{itemize}[#1]}{\end{itemize}%
         \vspace{-.6\baselineskip}}

% Create command for section headers
\renewcommand{\section}[2]%
        {\pagebreak[2]\vspace{1.25\baselineskip}%
         \phantomsection\addcontentsline{toc}{section}{#1}%
         \leavevmode\marginpar{\flushleft \

         \color{sectiongray} #1}#2}

% Create new column types for tables
% Uncomment this to vertically center the rows:
% \renewcommand{\tabularxcolumn}[1]{m{#1}}
\renewcommand{\arraystretch}{1.85}
\newcolumntype{l}{>{\raggedright\let\newline\\\arraybackslash}X}
\newcolumntype{c}{>{\centering\let\newline\\\arraybackslash\hspace{0pt}\hsize=.5\hsize}X}
\newcolumntype{r}{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}\hsize=.5\hsize}X}


%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[style=verbose,
                maxnames=99,
                sorting=chronological]{biblatex}

\newbibmacro{string+doi}[1]{%
  \iffieldundef{doi}{#1}
    {\href{http://dx.doi.org/\thefield{doi}}{#1}%
  }%
  \setunit{\par}
}

\DeclareSortingScheme{chronological}{
  \sort[direction=descending]{\field{year}}
  \sort[direction=descending]{\field{month}}
}

\newcommand{\printbibsection}[2]{
  \begin{refsection}
    \nocite{*}
    \printbibliography[sorting=chronological,
                       type={#1},
                       title={#2},
                       heading=none]
  \end{refsection}
}

\defbibenvironment{bibliography}
  \noindent
  {\enumerate}
  {\endenumerate}
  {\item[]}

%%%%%%%%%%%%%%%%%
% Personalize   %
%%%%%%%%%%%%%%%%%

\newcommand{\makeauthorbold}[1]{%
    \expandafter\ifstrequal\expandafter{\namepartfamily}{#1}%
    {\addfontfeature{Color=black}{\namepartgiveni\space}\namepartfamily}%
    {\addfontfeature{Color=lightgray}{\namepartgiveni\space}\namepartfamily}
}

\DeclareNameFormat{author}{%
  \Small
  \makeauthorbold{DuPre}
  \ifthenelse{\value{listcount}<\value{liststop}}
    {\addcomma\space}
    {\adddot}%
}

%%%%%%%%%%%%%%%%%
% Article Types %
%%%%%%%%%%%%%%%%%

\DeclareFieldFormat[article]{title}%
    {\usebibmacro{string+doi}{#1}}
\DeclareFieldFormat[proceedings]{title}{#1\par}
% \DeclareFieldFormat[inbook]{title}{#1\par}
% \DeclareFieldFormat[inproceedings]{title}{#1\par}

\DeclareBibliographyDriver{article}{%
	\printfield{title}
  \newblock%
	\vspace{2.5pt}%
  \printnames{author}%
  \par%
  \newblock%
	\vspace{.5pt}%
  {%
    \small\addfontfeature{Color=black}\itshape%
    \usebibmacro{journal+issuetitle}%
    \setunit{\space}%
    \printfield{pages}%
    \newunit%
		.
  }
  \par\vspace{0.95\baselineskip}
}

\DeclareBibliographyDriver{proceedings}{%
  \printfield{title}%
  \newblock%
	\vspace{2.5pt}%
  \printnames{author}%
  \par%
  \newblock%
	\vspace{.5pt}%
  {%
    \footnotesize\addfontfeature{Color=black}\itshape%
    \printlist{organization}%
    \setunit{\space}%
    \newunit%
    \usebibmacro{journal+issuetitle}%
    \setunit*{\addcomma\space}%
    \newunit%
		.
  }
  \par\vspace{0.95\baselineskip}
}
