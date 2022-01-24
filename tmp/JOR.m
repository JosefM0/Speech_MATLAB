clear all, close all, clc
G=tf([5 1],[1 17 80 100]);
[r,p,k] = residue([5 1],[1 17 80 100])

[residua,poly,k]=residue([5 1],[1 17 80 100])
JORA=diag(poly)
JORB=ones(size(poly,1),1)
JORC=residua'
if isempty(k)
    JORD=0
else
    JORD=k
end
