\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ashletter}[2026/04/15 General letter class with configurable institutional header]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions\relax
\LoadClass[letterpaper]{letter}

\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\RequirePackage{array}
\RequirePackage{xcolor}
\RequirePackage{soul}
\RequirePackage{tabularx}
\RequirePackage[hyphens]{url}
\RequirePackage{calc}

\DeclareGraphicsExtensions{.eps}
\setul{}{2pt}
\urlstyle{same}

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}
\definecolor{maroon}{rgb}{0.5, 0.0, 0.0}

% Default header metadata. These defaults are SBU-specific, but the API is generic.
\newcommand{\HeaderTitle}{College of Arts and Sciences}
\newcommand{\HeaderDepartment}{Department of Physics and Astronomy}
\newcommand{\HeaderInstitution}{Stony Brook University}
\newcommand{\HeaderAddress}{Stony Brook, NY 11794}
\newcommand{\HeaderName}{Aishwarya Kumar}
\newcommand{\HeaderRole}{Assistant Professor of Physics \& Astronomy}
\newcommand{\HeaderPhone}{8144418969}
\newcommand{\HeaderEmail}{aishwarya.kumar@stonybrook.edu}
\newcommand{\HeaderWebsite}{https://sites.google.com/stonybrook.edu/kumarlab}
\newcommand{\HeaderLogoFile}{SBU stack_2clr_rgb_300ppi.png}
\newcommand{\HeaderLogoHeight}{0.8in}
\newcommand{\HeaderLogoVSpace}{0in}
\newcommand{\HeaderTextVShift}{-0.48in}
\newlength{\HeaderLeftWidth}
\newlength{\HeaderRightWidth}
\newlength{\HeaderComputedLeftWidth}
\newlength{\HeaderComputedRightWidth}
\newlength{\HeaderAvailableRightWidth}
\newlength{\HeaderLogoRightPad}
\newlength{\HeaderDividerGap}
\newlength{\HeaderTextIndent}
\newlength{\HeaderRuleShorten}
\newlength{\HeaderRightXShift}
\newlength{\HeaderRightYShift}
\newlength{\HeaderRightBlockHeight}
\newsavebox{\HeaderLogoBox}
\newsavebox{\HeaderRightMeasureBox}
\newsavebox{\HeaderRightAssemblyBox}

\setlength{\HeaderLeftWidth}{0pt}
\setlength{\HeaderRightWidth}{0pt}
\setlength{\HeaderLogoRightPad}{0.18in}
\setlength{\HeaderDividerGap}{0.125in}
\setlength{\HeaderTextIndent}{0.08in}
\setlength{\HeaderRuleShorten}{0.12in}
\setlength{\HeaderRightXShift}{0pt}
\setlength{\HeaderRightYShift}{0pt}
\setlength{\HeaderRightBlockHeight}{1.0in}

% Vertical rhythm controls.
\newlength{\HeaderBottomGap}
\newlength{\HeaderTopOffset}
\newlength{\RecipientGap}
\newlength{\SubjectGap}
\newlength{\ClosingGap}
\newlength{\SignatureVSpace}

\setlength{\HeaderTopOffset}{0pt}
\setlength{\HeaderBottomGap}{0.8\baselineskip}
\setlength{\RecipientGap}{0.8\baselineskip}
\setlength{\SubjectGap}{0.8\baselineskip}
\setlength{\ClosingGap}{1.2\baselineskip}
\setlength{\SignatureVSpace}{0.1in}

\newcommand{\setheadertitle}[1]{\renewcommand{\HeaderTitle}{#1}}
\newcommand{\setheaderdepartment}[1]{\renewcommand{\HeaderDepartment}{#1}}
\newcommand{\setheaderinstitution}[1]{\renewcommand{\HeaderInstitution}{#1}}
\newcommand{\setheaderaddress}[1]{\renewcommand{\HeaderAddress}{#1}}
\newcommand{\setheadername}[1]{\renewcommand{\HeaderName}{#1}}
\newcommand{\setheaderrole}[1]{\renewcommand{\HeaderRole}{#1}}
\newcommand{\setheaderphone}[1]{\renewcommand{\HeaderPhone}{#1}}
\newcommand{\setheaderemail}[1]{\renewcommand{\HeaderEmail}{#1}}
\newcommand{\setheaderwebsite}[1]{\renewcommand{\HeaderWebsite}{#1}}
\newcommand{\setheaderlogofile}[1]{\renewcommand{\HeaderLogoFile}{#1}}
\newcommand{\setheaderlogoheight}[1]{\renewcommand{\HeaderLogoHeight}{#1}}
\newcommand{\setheaderleftwidth}[1]{\setlength{\HeaderLeftWidth}{#1}}
\newcommand{\setheaderrightwidth}[1]{\setlength{\HeaderRightWidth}{#1}}
\newcommand{\setheaderlogorightpad}[1]{\setlength{\HeaderLogoRightPad}{#1}}
\newcommand{\setheaderdividergap}[1]{\setlength{\HeaderDividerGap}{#1}}
\newcommand{\setheadertextindent}[1]{\setlength{\HeaderTextIndent}{#1}}
\newcommand{\setheaderruleshorten}[1]{\setlength{\HeaderRuleShorten}{#1}}
\newcommand{\setheaderrightxshift}[1]{\setlength{\HeaderRightXShift}{#1}}
\newcommand{\setheaderrightyshift}[1]{\setlength{\HeaderRightYShift}{#1}}
\newcommand{\setheaderrightblockheight}[1]{\setlength{\HeaderRightBlockHeight}{#1}}
\newcommand{\setheadertextvshift}[1]{\renewcommand{\HeaderTextVShift}{#1}}
\newcommand{\setheadertopoffset}[1]{\setlength{\HeaderTopOffset}{#1}}
\newcommand{\setheaderbottomgap}[1]{\setlength{\HeaderBottomGap}{#1}}
\newcommand{\setrecipientgap}[1]{\setlength{\RecipientGap}{#1}}
\newcommand{\setsubjectgap}[1]{\setlength{\SubjectGap}{#1}}
\newcommand{\setclosinggap}[1]{\setlength{\ClosingGap}{#1}}
\newcommand{\setsignaturevspace}[1]{\setlength{\SignatureVSpace}{#1}}
\newcommand{\HeaderEmailLine}{\textcolor{blue}{\expandafter\url\expandafter{\HeaderEmail}}}
\newcommand{\HeaderWebsiteLine}{\textcolor{blue}{\expandafter\url\expandafter{\HeaderWebsite}}}
\newcommand{\HeaderTextBlockContents}{%
  {\bfseries\normalsize\color{maroon}\HeaderTitle}\\
  \small
  \HeaderDepartment\\
  \HeaderInstitution\\
  \HeaderAddress\\

  \HeaderName\\
  \HeaderRole\\
  \HeaderPhone\\
  \HeaderEmailLine\\
  \HeaderWebsiteLine\\
}
\newcommand{\HeaderRightAssembly}{%
  \begin{tabular}[t]{@{}c@{\hspace{\HeaderDividerGap}}p{\HeaderComputedRightWidth}@{}}
    \vrule &
    \parbox[t][\HeaderRightBlockHeight][t]{\HeaderComputedRightWidth}{%
      \vspace*{\dimexpr\HeaderRightYShift+\HeaderTextVShift\relax}%
      \hspace*{\HeaderTextIndent}%
      \begin{minipage}[t]{\dimexpr\HeaderComputedRightWidth-\HeaderTextIndent\relax}
      \underline{\makebox[\dimexpr\HeaderComputedRightWidth-\HeaderTextIndent-\HeaderRuleShorten\relax][l]{\bfseries\normalsize\color{maroon}\HeaderTitle}}\\
      \small
      \HeaderDepartment\\
      \HeaderInstitution\\
      \HeaderAddress\\

      \HeaderName\\
      \HeaderRole\\
      \HeaderPhone\\
      \HeaderEmailLine\\
      \HeaderWebsiteLine\\
      \end{minipage}%
    }%
  \end{tabular}%
}

\newcommand{\LetterHeaderBlock}{%
  \sbox{\HeaderLogoBox}{\includegraphics[height=\HeaderLogoHeight]{\HeaderLogoFile}}%
  \sbox{\HeaderRightMeasureBox}{%
    \begin{tabular}{@{}l@{}}
      \HeaderTextBlockContents
    \end{tabular}%
  }%
  \ifdim\HeaderLeftWidth=0pt
    \setlength{\HeaderComputedLeftWidth}{\wd\HeaderLogoBox}%
    \addtolength{\HeaderComputedLeftWidth}{\HeaderLogoRightPad}%
  \else
    \setlength{\HeaderComputedLeftWidth}{\HeaderLeftWidth}%
  \fi
  \setlength{\HeaderAvailableRightWidth}{\textwidth}%
  \addtolength{\HeaderAvailableRightWidth}{-\HeaderComputedLeftWidth}%
  \addtolength{\HeaderAvailableRightWidth}{-\HeaderDividerGap}%
  \addtolength{\HeaderAvailableRightWidth}{-\arrayrulewidth}%
  \ifdim\HeaderRightWidth=0pt
    \setlength{\HeaderComputedRightWidth}{\wd\HeaderRightMeasureBox}%
    \addtolength{\HeaderComputedRightWidth}{\HeaderTextIndent}%
  \fi
  \ifdim\HeaderRightWidth>0pt
    \setlength{\HeaderComputedRightWidth}{\HeaderRightWidth}%
  \fi
  \ifdim\HeaderComputedRightWidth>\HeaderAvailableRightWidth
    \setlength{\HeaderComputedRightWidth}{\HeaderAvailableRightWidth}%
  \fi
  \sbox{\HeaderRightAssemblyBox}{\HeaderRightAssembly}%
  \noindent
  \parbox[t]{\textwidth}{%
    \makebox[0pt][l]{%
      \parbox[t]{\HeaderComputedLeftWidth}{\raggedright
        {\vspace{\HeaderLogoVSpace}\usebox{\HeaderLogoBox}}%
      }%
    }%
    \makebox[0pt][l]{%
      \hspace*{\dimexpr\textwidth-\wd\HeaderRightAssemblyBox+\HeaderRightXShift\relax}%
      \usebox{\HeaderRightAssemblyBox}%
    }%
  }\par
}

\newcommand{\RecipientBlock}{%
  \ifx\@empty\toname
    \ifx\@empty\toaddress
    \else
      {\raggedright
        \begin{tabular}{@{}l@{}}\ignorespaces
        \toaddress
        \end{tabular}\par}%
      \vspace{\RecipientGap}%
    \fi
  \else
    {\raggedright
      \begin{tabular}{@{}l@{}}\ignorespaces
      \toname
      \ifx\@empty\toaddress\else\\ \toaddress\fi
      \end{tabular}\par}%
    \vspace{\RecipientGap}%
  \fi
}

\newcommand{\SubjectBlock}{%
  \ifthenelse{\equal{\@subject}{}}{}{%
    {\raggedright \@subject\par}%
    \vspace{\SubjectGap}%
  }%
}

\pagestyle{empty}

\renewcommand{\opening}[1]{%
  \thispagestyle{empty}%
  % The base letter class adds stretchable top glue on page 1 via \@texttop.
  % That makes the header drift downward when the first page is short.
  \let\@texttop\relax
  \vspace*{\HeaderTopOffset}%
  \LetterHeaderBlock
  \vspace{\HeaderBottomGap}%
  {\raggedleft\@date\par}%
  \vspace{\RecipientGap}%
  \RecipientBlock
  \SubjectBlock
  #1\par\nobreak
}

\renewcommand{\closing}[1]{%
  \par\nobreak\vspace{\ClosingGap}%
  \stopbreaks
  \noindent
  \hspace*{0.0\textwidth}\parbox{0.4\textwidth}{\raggedright
  \ignorespaces #1\\[4\medskipamount]%
  \fromsig
  \strut}%
  \par
}

\newcommand{\Signer}[2]{%
  \begin{tabular}[t]{@{}l@{}}
  \includegraphics[scale=.3]{#1}\\
  \texttt{#2}
  \end{tabular}%
}

\newcommand{\SignatureRow}[1]{%
  \vspace*{\SignatureVSpace}%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}#1}
}

\newcommand{\EndSignatureRow}{%
  \end{tabular*}%
}

% Backwards-compatible aliases for older drafts.
\let\SBUHeaderTitle\HeaderTitle
\let\SBUHeaderDepartment\HeaderDepartment
\let\SBUHeaderInstitution\HeaderInstitution
\let\SBUHeaderAddress\HeaderAddress
\let\SBUHeaderName\HeaderName
\let\SBUHeaderRole\HeaderRole
\let\SBUHeaderPhone\HeaderPhone
\let\SBUHeaderEmail\HeaderEmail
\let\SBUHeaderWebsite\HeaderWebsite
\let\SBUHeaderLogoFile\HeaderLogoFile
\let\SBUHeaderLogoHeight\HeaderLogoHeight
\let\SBUHeaderLogoVSpace\HeaderLogoVSpace
\let\SBUHeaderTextVShift\HeaderTextVShift
\let\SBUHeaderLeftWidth\HeaderLeftWidth
\let\SBUHeaderDividerGap\HeaderDividerGap
\let\SBUHeaderTextIndent\HeaderTextIndent
\let\SBUHeaderRuleShorten\HeaderRuleShorten
\let\SBUHeaderTopOffset\HeaderTopOffset
\let\SBUHeaderBottomGap\HeaderBottomGap
\let\SBURecipientGap\RecipientGap
\let\SBUSubjectGap\SubjectGap
\let\SBUClosingGap\ClosingGap
\let\SBUSignatureVSpace\SignatureVSpace
\let\SBUHeaderBlock\LetterHeaderBlock
\let\SBURecipientBlock\RecipientBlock
\let\SBUSubjectBlock\SubjectBlock
\let\SBUSigner\Signer
\let\SBUSignatureRow\SignatureRow
\let\EndSBUSignatureRow\EndSignatureRow
