\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{puthesis}
         [2008/05/02 v1.4 Princeton University Thesis class]
\RequirePackage{setspace}
\newcounter{subyear}
\setcounter{subyear}{\number\year}
\def\submitted#1{\gdef\@submitted{#1}}
\def\@submittedyear{\ifnum\month>10 \stepcounter{subyear}\thesubyear
  \else\thesubyear\fi}
\def\@submittedmonth{\ifnum\month>10 January\else\ifnum\month>5 November
  \else June\fi\fi}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}}
\def\@copyrightyear{\number\year}
\def\adviser#1{\gdef\@adviser{#1}}
\def\contrib#1{\gdef\@contrib{#1}}
\def\abstractport#1{\gdef\@abstractport{#1}}
\long\def\@abstract{\@latex@error{No \noexpand\abstract given}\@ehc}
\newcommand*{\frontmatter}{
  % \pagenumbering{roman}
  % \setcounter{page}{2}
  }
\newcommand*{\mainmatter}{\pagenumbering{arabic}}
\newcommand*{\makelot}{}
\newcommand*{\makelof}{}
\newcommand*{\makelos}{}
\newcommand*{\maketoc}{
  % Add ToC to the pdfbookmarks as a section, but not to the ToC itself.
  % only if we have the hyperref command that is necessary
  \ifdefined\pdfbookmark
     \phantomsection
     \pdfbookmark[1]{\contentsname}{xxx}
  \else
  \fi
  \tableofcontents
  %\clearpage
}
%% Setup a command to add extra space only if in singlespacing mode
\newcommand*{\extravspace}[1]{\vspace{0in}}

%% Setup a command to set spacing for body text; also used to restore spacing after long tables in document
\newcommand*{\bodyspacing}{
  \onehalfspacing
}

%% Setup a command to set spacing for long tables, to be used manually in document
\newcommand*{\tablespacing}{
  \singlespacing
}

%% Command inserted into the document immediately after \begin{document} to place all frontmatter
%%   This was formerly named 'begincmd' and called below in \AtBeginDocument{}
%%   However, that is not compatible with package 'hyperref'. \tableofcontents needs
%%   to be declared from within the document itself. 
\newcommand*{\makefrontmatter}{
\bodyspacing
\frontmatter
\makecopyrightpage
\makededication
\blankpage
\makeacknowledgments
\makeabstractport\makeabstract\makecontrib
\maketoc
\makelot\clearpage\makelof\clearpage\makelos
\clearpage\mainmatter
}
\def\@submitted{\@submittedmonth~\@submittedyear}
%\def\@dept{Psychology}
%\def\@deptpref{Champalimaud Neuroscience Programme}
\def\departmentprefix#1{\gdef\@deptpref{#1}}
\def\department#1{\gdef\@dept{#1}}
\long\def\acknowledgments#1{\gdef\@acknowledgments{#1}}
\def\dedication#1{\gdef\@dedication{#1}}
\newcommand{\maketitlepage}{{
  \thispagestyle{empty}
  \sc
  \vspace*{0in}
  \begin{center}
    \LARGE \@title
  \end{center}
  \vspace{.6in}
  \extravspace{.6in}
  \begin{center}
    \@author
  \end{center}
  \vspace{.6in}
  \extravspace{.6in}
  \begin{center}
    A Dissertation \\
    Presented to the Faculty \\
    of Universidade Nova de Lisboa \\
    in Candidacy for the Degree \\
    of Doctor of Philosophy
  \end{center}
  \vspace{.3in}
  \extravspace{.3in}
  \begin{center}
%    Recommended for Acceptance \\
 %   by the \@deptpref \\
%    \@dept \\
    \@adviser
  \end{center}
  \vspace{.3in}
  \extravspace{.3in}
  \begin{center}
    \@submitted
  \end{center}
  \clearpage
  }}
\newcommand*{\makecopyrightpage}{
  \thispagestyle{empty}
  \vspace*{0in}
  \begin{center}
 %   \copyright\ Copyright by \@author, \@copyrightyear. \\
 %   All rights reserved.
  \end{center}
  \clearpage}
\newcommand*{\makeabstract}{
  \newpage
  \ifdefined\phantomsection
    % makes hyperref recognize this section properly for pdf links
    \phantomsection
  \else
  \fi
  \addcontentsline{toc}{section}{\textbf{Abstract}}
  \begin{center}
  \Large \textbf{Abstract}
  \end{center}
  \@abstract
  \clearpage}
\newcommand*{\makeabstractport}{
  \newpage
  \ifdefined\phantomsection
    % makes hyperref recognize this section properly for pdf links
    \phantomsection
  \else
  \fi
  \addcontentsline{toc}{section}{\textbf{T\'{i}tulo e Resumo}}
%  \begin{center}
%  \Large \textbf{T\'{i}tulo e Resumo}
%  \end{center}
  \@abstractport
  \clearpage}
\newcommand*{\makecontrib}{
  \newpage
  \ifdefined\phantomsection
    % makes hyperref recognize this section properly for pdf links
    \phantomsection
  \else
  \fi
  \addcontentsline{toc}{section}{\textbf{Financial Support}}
  \begin{center}
  \Large \textbf{Financial Support}
  \end{center}
  \@contrib
  \clearpage}
\newcommand*{\makeacknowledgments}{
  \newpage
  \ifdefined\phantomsection
    % makes hyperref recognize this section properly for pdf links
    \phantomsection
  \else
  \fi
  \addcontentsline{toc}{section}{\textbf{Acknowledgements}}
  \begin{center}
  \Large \textbf{Acknowledgments}
  \end{center}
  \@acknowledgments
  \clearpage}
\def\makededication{
  \ifx\@dedication\undefined
  \else
    \thispagestyle{empty}
    \vspace*{1.5in}
    \begin{flushright}
      \@dedication
    \end{flushright}
    \clearpage
  \fi
  \ifdefined\phantomsection
    % makes hyperref recognize this section properly for pdf links
    \phantomsection
  \else
  \fi
   %\addcontentsline{toc}{section}{\textbf{Contents}}
  }
\DeclareOption{los}{
  \renewcommand*{\makelos}{
    \RequirePackage{losymbol}
    \section*{List of Symbols\@mkboth {LIST OF SYMBOLS}{LIST OF SYMBOLS}}
    \@starttoc{los}
  \ifdefined\phantomsection
    % makes hyperref recognize this section properly for pdf links
    \phantomsection
  \else
  \fi
    \addcontentsline{toc}{section}{List of Symbols}
  }
}
\DeclareOption{singlespace}{
  \renewcommand*{\bodyspacing}{
  \singlespacing
  }
  %% Add extra space only if in singlespacing mode
  \renewcommand*{\extravspace}[1]{\vspace{#1}}
}
%% Doublespacing is the default for the thesis -- need not be declared.
\DeclareOption{doublespacing}{
  \renewcommand*{\bodyspacing}{
  \onehalfspacing
  }
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
%% Not necessary to specify the point size - we inherit it from above
%% \LoadClass[12pt]{report}
\LoadClass{report}
\setlength{\oddsidemargin}{.5in}   %{.4375in}
\setlength{\evensidemargin}{.5in} %{.4375in}
\setlength{\topmargin}{-.5in}  %{-.5625in}
\setlength{\footskip}{.25in} % to put page number 3/4" from the bottom of the page (1/4" from bottom of body text)
\setlength{\textheight}{9in}
\setlength{\textwidth}{6in}

%%% Alter LaTeX defaults to try to eliminate all widows and orphans
\clubpenalty=10000
\widowpenalty=10000

%%% try to avoid overfull lines by limiting how far it is okay to exceed the margins
%%% http://www.tex.ac.uk/cgi-bin/texfaq2html?label=overfull
\setlength{\emergencystretch}{2em}


\long\def\abstract#1{\gdef\@abstract{#1}}
%% 'begincmd' no longer used -- insert \makefrontmatter in the document instead. See above. 
%\AtBeginDocument{\begincmd}

\endinput
%% 
%% End of file `puthesis.cls'.
