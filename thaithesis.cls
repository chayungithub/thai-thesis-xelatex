%% =====================================================================
%%  thaithesis.cls  --  Thai thesis class for XeLaTeX
%%                      แม่แบบวิทยานิพนธ์ภาษาไทยสำหรับ XeLaTeX
%%
%%  Copyright (c) 2026 Chayun Kongtongvattana (ชยันต์ คงทองวัฒนา)
%%  https://github.com/chayungithub/thai-thesis-xelatex
%%  Released under the MIT License (see LICENSE).
%%  Please keep this notice in all copies and modified versions.
%%
%%  - ฟอนต์ TH Sarabun New 16 pt (หรือ Laksaman จาก TeX Live ถ้าไม่มี)
%%  - ขอบกระดาษ A4: บน 1.5", ซ้าย 1.5", ขวา 1", ล่าง 1"
%%  - เลขหน้าส่วนนำเป็นอักษรไทย (ก ข ค ...) ส่วนเนื้อหาเป็นเลขอารบิก
%%  - ตัดคำภาษาไทยอัตโนมัติด้วย ICU (\XeTeXlinebreaklocale "th")
%%
%%  ตัวเลือก (class options):
%%    systemfont         ข้ามไฟล์ใน fonts/ แล้วใช้ฟอนต์ที่ติดตั้งในเครื่อง
%%    pagebottom         วางเลขหน้ากึ่งกลางด้านล่าง (ค่าเริ่มต้น: มุมขวาบน)
%%    chapterpagenumber  แสดงเลขหน้าในหน้าแรกของแต่ละบทด้วย
%% =====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thaithesis}[2026/09/30 v1.0.0 Thai thesis template for XeLaTeX (C. Kongtongvattana)]

% ---------------------------------------------------------------------
% ตัวเลือกของคลาส
% ---------------------------------------------------------------------
\newif\ifthaithesis@sysfont      \thaithesis@sysfontfalse
\newif\ifthaithesis@pagebottom   \thaithesis@pagebottomfalse
\newif\ifthaithesis@chapnum      \thaithesis@chapnumfalse
\newif\ifthaithesis@showopening  \thaithesis@showopeningtrue

\DeclareOption{systemfont}{\thaithesis@sysfonttrue}
\DeclareOption{pagebottom}{\thaithesis@pagebottomtrue}
\DeclareOption{chapterpagenumber}{\thaithesis@chapnumtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[a4paper,oneside,12pt]{report}

\RequirePackage{iftex}
\RequireXeTeX   % ต้องคอมไพล์ด้วย XeLaTeX เท่านั้น

% ---------------------------------------------------------------------
% ขนาดตัวอักษร (TH Sarabun New ตัวเล็ก จึงใช้ 16 pt เป็นขนาดปกติ)
% ระยะบรรทัด = 1.3 เท่าของขนาดตัวอักษร (ใกล้เคียง "ระยะพิมพ์เดี่ยว" ใน Word)
% ---------------------------------------------------------------------
\renewcommand\normalsize{%
  \@setfontsize\normalsize{16}{20.8}%
  \abovedisplayskip 8\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\renewcommand\small{\@setfontsize\small{14}{18.2}}
\renewcommand\footnotesize{\@setfontsize\footnotesize{14}{18.2}}
\renewcommand\scriptsize{\@setfontsize\scriptsize{12}{15.6}}
\renewcommand\tiny{\@setfontsize\tiny{10}{13}}
\renewcommand\large{\@setfontsize\large{18}{23.4}}
\renewcommand\Large{\@setfontsize\Large{20}{26}}
\renewcommand\LARGE{\@setfontsize\LARGE{24}{31.2}}
\renewcommand\huge{\@setfontsize\huge{28}{36.4}}
\renewcommand\Huge{\@setfontsize\Huge{32}{41.6}}
\normalsize
\setlength\topskip{16\p@}
\setlength\parskip{\z@}
\raggedbottom

% ---------------------------------------------------------------------
% ขอบกระดาษ (แก้ได้ใน main.tex ด้วย \geometry{...})
% ---------------------------------------------------------------------
\RequirePackage[a4paper,
  top=1.5in, bottom=1in, left=1.5in, right=1in,
  headheight=21pt, headsep=0.5in, footskip=0.5in]{geometry}

% ย่อหน้า
\newlength\thesisindent
\setlength\thesisindent{0.5in}
\setlength\parindent{\thesisindent}
\RequirePackage{indentfirst}

% ---------------------------------------------------------------------
% ฟอนต์
% ---------------------------------------------------------------------
\RequirePackage{amsmath}
\RequirePackage{fontspec}
\RequirePackage[mathrm=sym, mathit=sym, mathsf=sym, mathbf=sym, mathtt=sym]{unicode-math}

% ลำดับการเลือกฟอนต์ภาษาไทย (font selection order)
%   1) ไฟล์ fonts/THSarabunNew.ttf (+ -Bold, -Italic, -BoldItalic) ในโปรเจกต์
%   2) TH Sarabun New ที่ติดตั้งในเครื่อง
%   3) TH SarabunPSK ที่ติดตั้งในเครื่อง
%   4) Laksaman -- ฟอนต์ที่พัฒนาต่อจาก TH Sarabun New ซึ่งมากับ
%      TeX Live / MacTeX / Overleaf อยู่แล้ว (ย่อขนาดให้เท่ากับ TH Sarabun New)
\newcommand\thaithesis@fontpath{fonts/}
\newcommand\thaithesis@setthai[2]{% #1 = ชื่อฟอนต์, #2 = ตัวเลือกเพิ่มเติม
  \setmainfont{#1}[Script=Thai, WordSpace={1,2,1}, #2]%
  \setsansfont{#1}[Script=Thai, WordSpace={1,2,1}, #2]%
  \typeout{thaithesis: Thai font = #1}}
\newcommand\thaithesis@usefont@local{%
  \thaithesis@setthai{THSarabunNew}{Path=\thaithesis@fontpath, Extension=.ttf,
    UprightFont=*, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic}}
\newcommand\thaithesis@usefont@installed{%
  \IfFontExistsTF{TH Sarabun New}
    {\thaithesis@setthai{TH Sarabun New}{}}
    {\IfFontExistsTF{TH SarabunPSK}
      {\thaithesis@setthai{TH SarabunPSK}{}}
      {\thaithesis@setthai{Laksaman}{Extension=.otf, Scale=0.6655,
         UprightFont=*, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic}%
       \ClassWarningNoLine{thaithesis}{TH Sarabun New was not found, so the
         TH Sarabun-compatible font Laksaman (from TeX Live) is used.\MessageBreak
         For the official font, install TH Sarabun New or copy its .ttf\MessageBreak
         files into the fonts/ folder}}}}
\ifthaithesis@sysfont
  \thaithesis@usefont@installed
\else
  \IfFileExists{\thaithesis@fontpath THSarabunNew.ttf}
    {\thaithesis@usefont@local}
    {\thaithesis@usefont@installed}
\fi
% ฟอนต์โค้ด (Latin Modern Mono มากับ MacTeX) ปรับขนาดให้เข้ากับ TH Sarabun
\setmonofont{lmmono10-regular.otf}[
  Scale=MatchLowercase,
  BoldFont=lmmonolt10-bold.otf,
  ItalicFont=lmmono10-italic.otf,
  BoldItalicFont=lmmonolt10-boldoblique.otf]
% ฟอนต์สมการ ย่อลงให้พอดีกับตัวอักษรไทย
\setmathfont{latinmodern-math.otf}[Scale=0.78]
% สัญลักษณ์ที่ใช้บ่อยซึ่ง unicode-math ไม่มีชื่อเดิม
\AtBeginDocument{%
  \providecommand\square{\mdlgwhtsquare}%
  \providecommand\Box{\mdlgwhtsquare}%
  \renewcommand\boldsymbol[1]{\symbfit{#1}}%
  \def\checkmark{\ding{51}}}

% ตัดคำภาษาไทยอัตโนมัติ (ICU dictionary)
\XeTeXlinebreaklocale "th"
\XeTeXlinebreakskip = 0pt plus 0.5pt
\frenchspacing
\tolerance=1000
\emergencystretch=3em
\clubpenalty=10000
\widowpenalty=10000

% ---------------------------------------------------------------------
% ชื่อเรียกต่าง ๆ ภาษาไทย
% ---------------------------------------------------------------------
\renewcommand\chaptername{บทที่}
\renewcommand\appendixname{ภาคผนวก}
\renewcommand\contentsname{สารบัญ}
\renewcommand\listfigurename{สารบัญภาพ}
\renewcommand\listtablename{สารบัญตาราง}
\renewcommand\figurename{ภาพที่}
\renewcommand\tablename{ตารางที่}
\renewcommand\bibname{บรรณานุกรม}
\renewcommand\abstractname{บทคัดย่อ}
\renewcommand\indexname{ดัชนี}
\newcommand\pagelabelname{หน้า}
\newcommand\abbreviationsname{คำอธิบายสัญลักษณ์และคำย่อ}
\newcommand\acknowledgementsname{กิตติกรรมประกาศ}
\newcommand\biographyname{ประวัติผู้เขียน}
\newcommand\thesisbibname{บรรณานุกรม}   % หรือ \renewcommand\thesisbibname{รายการอ้างอิง}

% ---------------------------------------------------------------------
% เลขหน้าแบบอักษรไทย ก ข ค ... (ไม่ใช้ ฃ ฅ)
% ---------------------------------------------------------------------
\def\@thaialph#1{\ifcase#1\or ก\or ข\or ค\or ง\or จ\or ฉ\or ช\or ซ\or
  ฌ\or ญ\or ฎ\or ฏ\or ฐ\or ฑ\or ฒ\or ณ\or ด\or ต\or ถ\or ท\or ธ\or น\or
  บ\or ป\or ผ\or ฝ\or พ\or ฟ\or ภ\or ม\or ย\or ร\or ล\or ว\or ศ\or ษ\or
  ส\or ห\or ฬ\or อ\or ฮ\else\@ctrerr\fi}
\newcommand\thaialph[1]{\expandafter\@thaialph\csname c@#1\endcsname}

% ---------------------------------------------------------------------
% หัว/ท้ายกระดาษ
% ---------------------------------------------------------------------
\RequirePackage{fancyhdr}
\renewcommand\headrulewidth{\z@}
\renewcommand\footrulewidth{\z@}
\newcommand\thaithesis@pagenumber{%
  \ifthaithesis@pagebottom\fancyfoot[C]{\thepage}\else\fancyhead[R]{\thepage}\fi}
\fancypagestyle{thesis}{\fancyhf{}\thaithesis@pagenumber}
% หน้าแรกของบท: ส่วนนำแสดงเลขหน้า ส่วนเนื้อหาไม่แสดง (ตามตัวเลือก)
\fancypagestyle{plain}{\fancyhf{}%
  \ifthaithesis@showopening\thaithesis@pagenumber\fi}
\pagestyle{thesis}

\newcommand\frontmatter{%
  \clearpage
  \pagenumbering{thaialph}%
  \thaithesis@showopeningtrue}
\newcommand\mainmatter{%
  \clearpage
  \pagenumbering{arabic}%
  \ifthaithesis@chapnum\thaithesis@showopeningtrue
  \else\thaithesis@showopeningfalse\fi}
\newcommand\backmatter{\clearpage}

% ---------------------------------------------------------------------
% หัวข้อบทและหัวข้อย่อย
% ---------------------------------------------------------------------
\RequirePackage{titlesec}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

% บทที่ 1  (กึ่งกลาง 20 pt ตัวหนา) / ชื่อบท (กึ่งกลาง 20 pt ตัวหนา)
\titleformat{\chapter}[display]
  {\centering\bfseries\Large}{\chaptertitlename\ \thechapter}{0pt}{\Large}
\titleformat{name=\chapter,numberless}[block]
  {\centering\bfseries\Large}{}{0pt}{}
% ค่า -\baselineskip ทำให้หัวบทเริ่มที่ขอบบนพอดี (เพิ่มค่าได้ถ้าต้องการเว้นมากขึ้น เช่น 0.5in)
\titlespacing{\chapter}{0pt}{-\baselineskip}{\baselineskip}

% 1.1 หัวข้อหลัก (ชิดซ้าย 18 pt ตัวหนา)
\titleformat{\section}{\bfseries\large}{\thesection}{0.6em}{}
\titlespacing{\section}{0pt}{\baselineskip}{0pt}
% 1.1.1 หัวข้อย่อย (ย่อหน้า 16 pt ตัวหนา)
\titleformat{\subsection}{\bfseries\normalsize}{\thesubsection}{0.6em}{}
\titlespacing{\subsection}{\thesisindent}{0.5\baselineskip}{0pt}
% 1.1.1.1 หัวข้อย่อยระดับ 3
\titleformat{\subsubsection}{\bfseries\normalsize}{\thesubsubsection}{0.6em}{}
\titlespacing{\subsubsection}{2\thesisindent}{0pt}{0pt}

% ---------------------------------------------------------------------
% คำบรรยายภาพและตาราง
%   ภาพที่ 1.1  ... (ใต้ภาพ กึ่งกลาง)
%   ตารางที่ 1.1  ... (เหนือตาราง ชิดซ้าย)
% ---------------------------------------------------------------------
\RequirePackage{graphicx}
\graphicspath{{figures/}}
\RequirePackage{caption}
\DeclareCaptionLabelSeparator{thai}{\hspace{0.6em}}
\captionsetup{labelfont=bf, labelsep=thai, font=normalsize}
\captionsetup[figure]{position=bottom, skip=6pt}
\captionsetup[table]{position=top, justification=raggedright,
                     singlelinecheck=false, skip=4pt}
\RequirePackage{float}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{longtable}
\setlength\LTcapwidth{\linewidth}
\setlength\LTpre{0.5\baselineskip}
\setlength\LTpost{0.5\baselineskip}
\RequirePackage{multirow}
\RequirePackage{enumitem}
\setlist{itemsep=0pt, parsep=0pt, topsep=0pt, partopsep=0pt}
\setlist[itemize,enumerate]{leftmargin=\dimexpr\thesisindent+1.4em\relax}
\RequirePackage{xcolor}
\RequirePackage{pifont}
\RequirePackage{etoolbox}

% ---------------------------------------------------------------------
% สารบัญ / สารบัญตาราง / สารบัญภาพ
% ---------------------------------------------------------------------
\RequirePackage[titles]{tocloft}
\renewcommand\cftchappresnum{\chaptername\ }
\setlength\cftchapnumwidth{3.2em}
\renewcommand\cftchapfont{\normalfont}
\renewcommand\cftchappagefont{\normalfont}
\renewcommand\cftchapleader{\cftdotfill{\cftdotsep}}
\setlength\cftbeforechapskip{2pt}
\setlength\cftsecindent{3.2em}
\setlength\cftsecnumwidth{2.2em}
\setlength\cftsubsecindent{5.4em}
\setlength\cftsubsecnumwidth{2.8em}
\setlength\cftfigindent{0pt}
\setlength\cftfignumwidth{3.2em}
\setlength\cfttabindent{0pt}
\setlength\cfttabnumwidth{3.2em}
\setlength\cftbeforefigskip{0pt}
\setlength\cftbeforetabskip{0pt}

% หัวคอลัมน์ "หน้า" ชิดขวา
\newcommand\thaithesis@listheader[1]{%
  \par\noindent\textbf{#1}\hfill\textbf{\pagelabelname}\par\nobreak}

% บทที่ไม่มีเลข + ใส่ในสารบัญ
%   \unnumberedchapter{ชื่อบนหน้า}           (ใช้ชื่อเดียวกันในสารบัญ)
%   \unnumberedchapter[ชื่อในสารบัญ]{ชื่อบนหน้า}
\newcommand\unnumberedchapter[2][]{%
  \clearpage\phantomsection
  \ifblank{#1}{\addcontentsline{toc}{chapter}{#2}}
              {\addcontentsline{toc}{chapter}{#1}}%
  \chapter*{#2}}

\renewcommand\tableofcontents{%
  \chapter*{\contentsname}%
  \thaithesis@listheader{}%
  \@starttoc{toc}}
\renewcommand\listoftables{%
  \unnumberedchapter{\listtablename}%
  \thaithesis@listheader{\tablename}%
  \@starttoc{lot}}
\renewcommand\listoffigures{%
  \unnumberedchapter{\listfigurename}%
  \thaithesis@listheader{\figurename}%
  \@starttoc{lof}}

% ---------------------------------------------------------------------
% ภาคผนวก (ภาคผนวก ก, ข, ค ...)
% ---------------------------------------------------------------------
\renewcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@thaialph\c@chapter}%
  \addtocontents{toc}{%
    \protect\renewcommand{\protect\cftchappresnum}{\protect\appendixname\protect\space}%
    \protect\setlength{\protect\cftchapnumwidth}{5em}}}
% หน้าคั่น "ภาคผนวก"
\newcommand\appendixpage{%
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{\appendixname}%
  \thispagestyle{plain}%
  \null\vfill
  \begin{center}\bfseries\Large\appendixname\end{center}%
  \vfill\null
  \clearpage}

% ---------------------------------------------------------------------
% ข้อมูลวิทยานิพนธ์ (กำหนดใน main.tex)
% ---------------------------------------------------------------------
\def\thaithesis@newfield#1#2{%
  \expandafter\def\csname thaithesis@#1\endcsname{#2}%
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \expandafter\def\csname thaithesis@#1\endcsname{##1}}%
  % ตัวเรียกใช้ในเนื้อหา เช่น \theauthorth, \theinstituteth
  \expandafter\def\csname the#1\endcsname{\csname thaithesis@#1\endcsname}}
\thaithesis@newfield{thesistypeth}{วิทยานิพนธ์}
\thaithesis@newfield{thesistypeen}{Thesis}
\thaithesis@newfield{titleth}{}
\thaithesis@newfield{titleen}{}
\thaithesis@newfield{authorth}{}
\thaithesis@newfield{authoren}{}
\thaithesis@newfield{degreeth}{}
\thaithesis@newfield{degreeen}{}
\thaithesis@newfield{programth}{}
\thaithesis@newfield{programen}{}
\thaithesis@newfield{facultyth}{}
\thaithesis@newfield{facultyen}{}
\thaithesis@newfield{instituteth}{}
\thaithesis@newfield{instituteen}{}
\thaithesis@newfield{advisorth}{}
\thaithesis@newfield{advisoren}{}
\thaithesis@newfield{coadvisorth}{}
\thaithesis@newfield{coadvisoren}{}
\thaithesis@newfield{deanth}{}
\thaithesis@newfield{keywordsth}{}
\thaithesis@newfield{keywordsen}{}
\def\thaithesis@yearth{}
\def\thaithesis@yearen{}
% \academicyear{ปี พ.ศ.}{ปี ค.ศ.}
\newcommand\academicyear[2]{\def\thaithesis@yearth{#1}\def\thaithesis@yearen{#2}}

% ตราสถาบัน: \logo[ความสูง]{ไฟล์ไม่ต้องใส่นามสกุล}
\def\thaithesis@logofile{}
\def\thaithesis@logoheight{3.5cm}
\newcommand\logo[2][3.5cm]{\def\thaithesis@logoheight{#1}\def\thaithesis@logofile{#2}}
\newcommand\thaithesis@printlogo{%
  \ifx\thaithesis@logofile\@empty\else
    \def\thaithesis@found{}%
    \@for\thaithesis@ext:={.pdf,.png,.jpg,.jpeg,}\do{%
      \ifx\thaithesis@found\@empty
        \IfFileExists{\thaithesis@logofile\thaithesis@ext}%
          {\edef\thaithesis@found{\thaithesis@logofile\thaithesis@ext}}{}%
      \fi}%
    \ifx\thaithesis@found\@empty
      \fbox{\parbox[c][\thaithesis@logoheight][c]{\thaithesis@logoheight}%
        {\centering\small ตราสถาบัน\\(วางไฟล์\\\texttt{\detokenize\expandafter{\thaithesis@logofile}.png})}}%
    \else
      \includegraphics[height=\thaithesis@logoheight]{\thaithesis@found}%
    \fi
    \par
  \fi}

% กรรมการสอบ: \committee{ตำแหน่ง}{ชื่อ}
\def\thaithesis@committee{}
\newcommand\committee[2]{%
  \g@addto@macro\thaithesis@committee{\thaithesis@signature{#1}{#2}}}

% ---------------------------------------------------------------------
% องค์ประกอบช่วยจัดหน้า
% ---------------------------------------------------------------------
% บรรทัดข้อมูลแบบ "หัวข้อ    รายละเอียด" (ข้ามถ้าไม่มีข้อมูล)
\newlength\thaithesis@labelwidth
\setlength\thaithesis@labelwidth{3.8cm}
\newcommand\thaithesis@inforow[2]{%
  \ifx#2\@empty\else
    \par\noindent\hangindent=\thaithesis@labelwidth\hangafter=1
    \makebox[\thaithesis@labelwidth][l]{\textbf{#1}}#2\par
  \fi}
% ลายเซ็น
\newcommand\thaithesis@signature[2]{%
  \par\vspace{1.3\baselineskip}\noindent\hspace*{0.25\linewidth}%
  \begin{tabular}[t]{@{}p{5.5cm}@{\hspace{0.5em}}%
      >{\raggedright\arraybackslash}p{\dimexpr0.75\linewidth-5.5cm-0.5em\relax}@{}}
    \dotfill & #1\\
    \makebox[5.5cm][c]{(#2)} &
  \end{tabular}\par}

\newcommand\thaithesis@coverblock{%
  \thaithesis@thesistypeth นี้เป็นส่วนหนึ่งของการศึกษาตามหลักสูตร\par
  ปริญญา\thaithesis@degreeth\par
  สาขาวิชา\thaithesis@programth\par
  \thaithesis@facultyth\ \thaithesis@instituteth\par
  ปีการศึกษา \thaithesis@yearth\par}

% ---------------------------------------------------------------------
% ปกนอก / ปกในภาษาไทย / ปกในภาษาอังกฤษ / หน้าอนุมัติ
% ---------------------------------------------------------------------
\newcommand\makecover{%
  \clearpage\thispagestyle{empty}%
  \begingroup\centering
  \thaithesis@printlogo
  \vspace{2\baselineskip}%
  {\Large\bfseries\thaithesis@titleth\par}%
  \vfill
  {\large\bfseries\thaithesis@authorth\par}%
  \vfill
  {\large\bfseries\thaithesis@coverblock}%
  \endgroup
  \clearpage}

\newcommand\maketitleth{%
  \clearpage\thispagestyle{empty}%
  \begingroup\centering
  \vspace*{2\baselineskip}%
  {\Large\bfseries\thaithesis@titleth\par}%
  \vfill
  {\large\bfseries\thaithesis@authorth\par}%
  \vfill
  {\large\bfseries\thaithesis@coverblock
   ลิขสิทธิ์ของ\thaithesis@instituteth\par}%
  \endgroup
  \clearpage}

\newcommand\maketitleen{%
  \clearpage\thispagestyle{empty}%
  \begingroup\centering
  \vspace*{2\baselineskip}%
  {\Large\bfseries\MakeUppercase{\thaithesis@titleen}\par}%
  \vfill
  {\large\bfseries\MakeUppercase{\thaithesis@authoren}\par}%
  \vfill
  {\large\bfseries\MakeUppercase{%
    A \thaithesis@thesistypeen\ submitted in partial fulfillment of the requirements\\
    for the degree of \thaithesis@degreeen\\
    Program in \thaithesis@programen\\
    \thaithesis@facultyen\\
    \thaithesis@instituteen\\
    Academic Year \thaithesis@yearen\\
    Copyright of \thaithesis@instituteen}\par}%
  \endgroup
  \clearpage}

\newcommand\makeapproval{%
  \clearpage\thispagestyle{empty}%
  \thaithesis@inforow{หัวข้อ\thaithesis@thesistypeth}{\thaithesis@titleth}%
  \thaithesis@inforow{ชื่อผู้เขียน}{\thaithesis@authorth}%
  \thaithesis@inforow{อาจารย์ที่ปรึกษา}{\thaithesis@advisorth}%
  \thaithesis@inforow{อาจารย์ที่ปรึกษาร่วม}{\thaithesis@coadvisorth}%
  \thaithesis@inforow{หลักสูตร}{\thaithesis@degreeth}%
  \thaithesis@inforow{สาขาวิชา}{\thaithesis@programth}%
  \thaithesis@inforow{ปีการศึกษา}{\thaithesis@yearth}%
  \vspace{1.5\baselineskip}%
  \par\thaithesis@facultyth\ \thaithesis@instituteth\ อนุมัติให้นับ%
  \thaithesis@thesistypeth ฉบับนี้เป็นส่วนหนึ่งของการศึกษาตามหลักสูตร%
  ปริญญา\thaithesis@degreeth\par
  \thaithesis@signature{คณบดี\thaithesis@facultyth}{\thaithesis@deanth}%
  \vspace{1.5\baselineskip}%
  \par\noindent\textbf{คณะกรรมการสอบ\thaithesis@thesistypeth}\par
  \thaithesis@committee
  \clearpage}

% ---------------------------------------------------------------------
% บทคัดย่อ / Abstract / กิตติกรรมประกาศ / คำย่อ / ประวัติผู้เขียน
% ---------------------------------------------------------------------
\newenvironment{abstractth}{%
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{บทคัดย่อภาษาไทย}%
  \thispagestyle{plain}%
  \thaithesis@inforow{หัวข้อ\thaithesis@thesistypeth}{\thaithesis@titleth}%
  \thaithesis@inforow{ชื่อผู้เขียน}{\thaithesis@authorth}%
  \thaithesis@inforow{อาจารย์ที่ปรึกษา}{\thaithesis@advisorth}%
  \thaithesis@inforow{อาจารย์ที่ปรึกษาร่วม}{\thaithesis@coadvisorth}%
  \thaithesis@inforow{หลักสูตร}{\thaithesis@degreeth}%
  \thaithesis@inforow{สาขาวิชา}{\thaithesis@programth}%
  \thaithesis@inforow{ปีการศึกษา}{\thaithesis@yearth}%
  \vspace{\baselineskip}%
  \begin{center}\bfseries\large\abstractname\end{center}%
  \vspace{0.3\baselineskip}\par}
 {\par\vspace{\baselineskip}%
  \ifx\thaithesis@keywordsth\@empty\else
    \noindent\textbf{คำสำคัญ:}\ \thaithesis@keywordsth\par
  \fi}

\newenvironment{abstracten}{%
  \clearpage\phantomsection
  \addcontentsline{toc}{chapter}{บทคัดย่อภาษาอังกฤษ}%
  \thispagestyle{plain}%
  \thaithesis@inforow{\thaithesis@thesistypeen\ Title}{\thaithesis@titleen}%
  \thaithesis@inforow{Author}{\thaithesis@authoren}%
  \thaithesis@inforow{\thaithesis@thesistypeen\ Advisor}{\thaithesis@advisoren}%
  \thaithesis@inforow{Co-advisor}{\thaithesis@coadvisoren}%
  \thaithesis@inforow{Degree}{\thaithesis@degreeen}%
  \thaithesis@inforow{Program}{\thaithesis@programen}%
  \thaithesis@inforow{Academic Year}{\thaithesis@yearen}%
  \vspace{\baselineskip}%
  \begin{center}\bfseries\large ABSTRACT\end{center}%
  \vspace{0.3\baselineskip}\par}
 {\par\vspace{\baselineskip}%
  \ifx\thaithesis@keywordsen\@empty\else
    \noindent\textbf{Keywords:}\ \thaithesis@keywordsen\par
  \fi}

\newenvironment{acknowledgements}{%
  \unnumberedchapter{\acknowledgementsname}}
 {\par\vspace{1.5\baselineskip}%
  \noindent\hfill\thaithesis@authorth\par}

% คำย่อ: \abbr{คำย่อ}{ความหมาย}
\newenvironment{abbreviations}{%
  \unnumberedchapter{\abbreviationsname}%
  \newcommand\abbr[2]{##1 & ##2\\}%
  \begin{longtable}{@{}p{4cm}@{}p{\dimexpr\linewidth-4cm\relax}@{}}
    \textbf{สัญลักษณ์/คำย่อ} & \textbf{ความหมาย}\\[2pt]
    \endhead}
 {\end{longtable}}

% ประวัติผู้เขียน: \bioitem{หัวข้อ}{รายละเอียด}
\newenvironment{biography}{%
  \unnumberedchapter{\biographyname}%
  \newcommand\bioitem[2]{%
    \def\thaithesis@tmp{##2}%
    \thaithesis@inforow{##1}{\thaithesis@tmp}\vspace{0.3\baselineskip}}%
  \setlength\thaithesis@labelwidth{4.5cm}}
 {\par}

% ---------------------------------------------------------------------
% บรรณานุกรม (ใช้กับ biblatex: \printbibliography[heading=thesis])
% ---------------------------------------------------------------------
\AtEndPreamble{%
  \@ifpackageloaded{biblatex}{%
    \DefineBibliographyStrings{english}{%
      bibliography={\thesisbibname}, references={\thesisbibname}}%
    \defbibheading{thesis}[\thesisbibname]{\unnumberedchapter{#1}}%
  }{}}

% ---------------------------------------------------------------------
% hyperref (โหลดท้ายสุด)
% ---------------------------------------------------------------------
\RequirePackage[hidelinks, bookmarksnumbered, pdfpagelabels]{hyperref}
\pdfstringdefDisableCommands{\def\\{ }}
\urlstyle{same}   % URL ใช้ฟอนต์เดียวกับเนื้อหา
\AtBeginDocument{%
  \pagenumbering{roman}% หน้าปก (ไม่แสดงเลขหน้า)
  \hypersetup{
    pdftitle={\thaithesis@titleth},
    pdfauthor={\thaithesis@authorth},
    pdfsubject={\thaithesis@thesistypeth\ \thaithesis@instituteth},
    pdfkeywords={\thaithesis@keywordsth},
    pdfcreator={XeLaTeX with thaithesis.cls by Chayun Kongtongvattana}}}

\endinput
