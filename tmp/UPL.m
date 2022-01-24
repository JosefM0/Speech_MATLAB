A=[-2 -1;2 -0.5];
B=[1;1];
I=eye(2);
syms s;
X0=[3;1];

Xsu=inv(s*I-A)*(X0+3/s);
Xtu=ilaplace(Xsu)