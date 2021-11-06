clear all; close all; clc
load('parametrs.mat');  % načte parametry záznamu ze souboru (Fs)
load('me_ahoj.mat');    % načte záznam ze souboru
%soundsc(speech, Fs); % prehraje načtený záznam
%pause(1.2)

Corr %Zobrazí signál a jeho korelační funkci, a vypočítá základní hlasiv. kmit.
ZCR %vykresli puvodni signal a pod nim pocet pruchodu nulou/128 prvku
Segmentation %Rozdělí signál na segmenty, zobr. v grafu (ukázka zpracování signálu)
Hamming %Na rozděleny signál uplatní hamming. okno, zobr. v grafu (ukázka zpracování signálu)
ENE%vykresli puvodni signal a pod nim kratkodobou energii
INTEN %vykresli puvodni signal a pod nim kratkodobou intenzitu


%Co dále? Kepstrální koef, Mel-kep coef, ...

%Record %program pro nahrávání nových záznamů