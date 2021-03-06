%                  SWI-Prolog
% Tugas :   a. Membaca file seperti contoh
%           b. Data sampai 5 level keturunan
%              (Kakek/Nenek-Bapak/Ibu-Anak-Cucu-Buyut) dan banyaknya
%              anak minimal 2 anak per pasangan

% pria(orang)
%
pria(sastro).
pria(nono).
pria(agung).
pria(gorbyn).
pria(dion).
pria(favian).
pria(daniel).
pria(agus).
pria(joko).
pria(zizi).

% perempuan(orang)
%
perempuan(sukarni).
perempuan(rini).
perempuan(nari).
perempuan(milla).
perempuan(nina).
perempuan(wanda).
perempuan(alya).
perempuan(lisa).
perempuan(zahro).
perempuan(elektra).
perempuan(avicenna).

% tahunLahir(nama,tahun)
%
tahunLahir(sastro,1944).
tahunLahir(sukarni,1955).
tahunLahir(nono,1965).
tahunLahir(rini,1968).
tahunLahir(agung,1976).
tahunLahir(nari,1977).
tahunLahir(gorbyn,1980).
tahunLahir(milla,1984).
tahunLahir(nina,1986).
tahunLahir(wanda,1987).
tahunLahir(dion,1985).
tahunLahir(alya,1988).
tahunLahir(favian,1990).
tahunLahir(lisa,1992).
tahunLahir(daniel,1993).
tahunLahir(zahro,1994).
tahunLahir(elektra,1998).
tahunLahir(avicenna,2000).
tahunLahir(zizi,2006).

% ortu(ortu,anak)
%
ortu(sastro,nono).
ortu(sastro,rini).
ortu(sastro,agung).
ortu(sastro,nari).
ortu(sukarni,nono).
ortu(sukarni,rini).
ortu(sukarni,agung).
ortu(sukarni,nari).
ortu(nono,milla).
ortu(nono,gorbyn).
ortu(nono,nina).
ortu(rini,milla).
ortu(rini,gorbyn).
ortu(rini,nina).
ortu(nari,wanda).
ortu(nari,dion).
ortu(nari,alya).
ortu(agung,wanda).
ortu(agung,dion).
ortu(agung,alya).
ortu(milla,lisa).
ortu(milla,favian).
ortu(milla,daniel).
ortu(gorbyn,lisa).
ortu(gorbyn,favian).
ortu(gorbyn,daniel).
ortu(wanda,zahro).
ortu(wanda,elektra).
ortu(dion,zahro).
ortu(dion,elektra).
ortu(lisa,avicenna).
ortu(lisa,zizi).
ortu(favian,avicenna).
ortu(favian,zizi).

% menikah(X,Y) - X menikah dengan Y
%
menikah(sukarni,sastro).
menikah(rini,nono).
menikah(nari,agung).
menikah(milla,gorbyn).
menikah(wanda,dion).
menikah(lisa,favian).


% ----------------------
%  Solutions Start Here
% ----------------------


% a. Menentukan hubungan keluarga dari dua orang
%

% kakek(kakek,cucu)
% kakek adalah ortu dari ortu cucu, dan pria
%
kakek(X,Z):-ortu(X,Y), ortu(Y,Z), pria(X).

% nenek(nenek,cucu)
% nenek adalah ortu dari ortu cucu, dan perempuan
%
nenek(X,Z):-ortu(X,Y), ortu(Y,Z), perempuan(X).

% bapak(bapak,anak)
% bapak adalah orang tua anak dan pria
%
bapak(X,Y):-ortu(X,Y), pria(X).

% ibu(ibu,anak)
% ibu adalah orang tua anak dan perempuan
%
ibu(X,Y):-ortu(X,Y), perempuan(X).

% paman(paman,keponakan)
% paman adalah pria, dan merupakan saudara dari ortu keponakan
%
paman(X,Y):-pria(X), ortu(Z,Y), saudara(Z,X).

% bibi(bibi,keponakan)
% bibi adalah perempuan, dan merupakan saudara dari ortu keponakan
%
bibi(X,Y):-perempuan(X), ortu(Z,Y), saudara(Z,X).

% anak(anak,ortu)
% anak adalah anak dari ortu
%
anak(X,Y):-ortu(Y,X).

% kakak(kakak,adik)
% saudara adalah bila memiliki ortu yang sama
% older adalah bila X tahun lahirnya lebih sedikit dari tahun lahir Y
% kakak adalah saudara adik yang lebih tua
%
saudara(X,Y):-ortu(Z,Y), ortu(Z,X), X \== Y.
older(X,Y) :-tahunLahir(X, Y1), tahunLahir(Y, Y2), Y2 > Y1.
kakak(X,Y) :-saudara(X,Y), older(X,Y), \+ menikah(Y,X).

% adik(adik,kakak)
% adik adalah saudara kakak yang lebih muda
%
adik(X,Y) :-saudara(X,Y), older(Y,X), \+menikah(X,Y).

% cucu(cucu,kakek/nenek)
% cucu adalah anak dari ortu yang merupakan anak dari kakek/nenek
%
cucu(X,Z):-ortu(Z,Y),anak(X,Y).

% buyut(buyut,kakek/nenek buyut)
% buyut adalah anak dari cucu kakek / nenek buyut
%
buyut(X,Y):-anak(X,Z),cucu(Z,Y).


% b. Menampilkan semua nenek moyang dan keturunan dari seseorang
%
%   Nenek moyang dan keturunan yang ditampilkan hanyalah yang berdarah
%   kandung. Tekan ";" untuk menampilkan nenek moyang / keturunan
%   selanjutnya
%
keturunan(X,Y) :-ortu(X,Y).
keturunan(X,Y) :-ortu(X,Z), keturunan(Z,Y).
nenekmoyang(X,Y) :-keturunan(Y,X).

% c. Menentukan banyaknya anak atau cucu dari seseorang
%
%    Banyak keturunan seseorang, yaitu banyaknya orang yang berada di
%    level bawahnya namun ber-ortu sama.
%
hitungBanyak([],0).
hitungBanyak([_|Tail], Count) :-hitungBanyak(Tail, TailCount), Count is TailCount + 1.
hitungKeturunan(X,Y) :-findall(Z, keturunan(X,Z), List), remove_duplicates(List,Hasil), hitungBanyak(Hasil, Y).

% d. Menghitung jarak keturunan dari 2 orang (Cucu adalah 2 jarak
% keturunan dari kakek)
% jarak(yang muda, yang tua, hasil).
%
jarak(X,Y,N) :-anak(X,Y), N is 1.
jarak(X,Y,N) :-anak(X,Z), jarak(Z,Y,N2), N is N2+1.

% e. Fitur yang lebih detil dibandingkan 4 fitur di atas
%

% kakakLaki(kakak laki-laki, adik)
% kakakLaki adalah pria saudara adik yang lebih tua / older
%
kakakLaki(X,Y) :-saudara(X,Y), pria(X), older(X,Y).

% kakakPerempuan(kakak perempuan, adik)
% kakakPerempuan adalah perempuan saudara adik yang lebih tua / older
%
kakakPerempuan(X,Y) :-saudara(X,Y), perempuan(X), older(X,Y).

% daftarSaudara(orang,saudaranya)
% saudaranya adalah sejumlah orang yang berada di satu level dengannya
% dan memiliki ortu yang sama
%
daftarSaudara(X,Y) :-findall(Z, saudara(X,Z), List), remove_duplicates(List, Y).

% anakanak(ortu,anaknya)
% anaknya adalah sejumlah orang yang merupakan anaknya
%
anakanak(X,Y) :-findall(Z, ortu(X,Z), Y).

% remove_duplicates(daftar,hasil)
% digunakan untuk menghilangkan entri yang berulang di dalam daftar
%
remove_duplicates([], []).
remove_duplicates([X|Rest], Result) :-member(X, Rest), !, remove_duplicates(Rest, Result).
remove_duplicates([X|Rest], [X|Result]) :-remove_duplicates(Rest, Result).




