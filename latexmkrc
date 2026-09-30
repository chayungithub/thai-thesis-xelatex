# ตั้งค่า latexmk ให้คอมไพล์ด้วย XeLaTeX + Biber
# ใช้งาน:  latexmk             ได้ build/main.pdf    ล้างไฟล์ชั่วคราว:  latexmk -c
$pdf_mode = 5;          # 5 = xelatex
$xelatex  = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$bibtex_use = 2;        # เรียก biber อัตโนมัติเมื่อจำเป็น
@default_files = ('main.tex');
$clean_ext = 'bbl run.xml xdv synctex.gz';
$out_dir = 'build';     # เก็บไฟล์ชั่วคราวและ main.pdf ไว้ในโฟลเดอร์ build/
