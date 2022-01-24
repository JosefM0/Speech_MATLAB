clear all, clc, close all
A=[-1 0;1 -0.5];
B=[2;2];
C=[3 -4];
D=[0];
X0=[3;1];
syms s;
I=eye(2);

Fis=inv(s*I-A);
Xs=Fis*X0;
xt=ilaplace(Xs)