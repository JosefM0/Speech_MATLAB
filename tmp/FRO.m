cit=[5 1];
jme=[1 17 80 100];

[A,B,C,D]=tf2ss(cit,jme);

FROA = rot90(A,2);
FROB = flipud(B);
FROC = fliplr(C);
FROD = D

syms x;
FROA*[x]