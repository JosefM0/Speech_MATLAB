function [segs] = F_segmentace(x, N, L, fce)
% Rozdělí signál (řádkový vektor) na jednotlivé segmenty a vrátí matici kde
% každý řádek odpovída jednomu segmentu, ve sloupcích budou jejich hodnoty
% 
% [segs] = F_segmentace(x, N, L, fce)
% 
% x     -vstupní vektor signálu
% N     - velikost segmentu (pocet prvku jednoho segmentu)
% L     -počet prků překrytí (0 až N)
% fce   -funkce okénkování (ham -Hamminngovo okénko, non - pravoúhlé okénko)
%
% segs  - výstupní matice

%%  urření počtu segmentů
a_tmp = length(x) - N;   %počet prvků vektoru x bez celého prvního segmentu
b_tmp = N-L;  %zbývající část segmentu po překrytí
nSeg = floor(a_tmp/b_tmp)+1; %celkový počet segmentů

%% segmentace + okénkování
for k=1:nSeg
    seg = x(1+(k-1)*(N-L):(1+(k-1)*(N-L))+N-1); %vyjmutí segmentu
    if fce == ['ham']
        seg = seg.*hamming(N); %okenkování Hammingovou funkcí
    else
    end

    segs_tmp(k,1:N) = seg; %Uložení všech segmentů do jedné matice
end

segs=segs_tmp;
end
