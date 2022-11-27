function [out] = F_preem(in)
%F_PREEM provede preem fázi, normalizaci
% 
% in/out     -vstup/výstupní řádkový vektor
alfa = 0.97;
x=in;
% x = filter([1 - alfa],1,x);
x = x/max(abs(x));
out=x;
end

