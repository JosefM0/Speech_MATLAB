clear all; close all; clc
load('parametrs.mat');  % načte parametry záznamu ze souboru (Fs)
load('me_ahoj.mat');    % načte záznam ze souboru
%soundsc(speech, Fs); % prehraje načtený záznam
%pause(1.2)

Corr %Zobrazí signál a jeho korelační funkci, a vypočítá základní hlasiv. kmit.
ZCR %vykresli puvodni signal a pod nim pocet pruchodu nulou/128 prvku
Segmentation %Rozdělí signál na segmenty, zobr. v grafu (ukázka zpracování signálu pro teoretickou část)
Hamming %Na rozděleny signál uplatní hamming. okno, zobr. v grafu (Nejprve nutne provest Segmentation.m)
ENE %vykresli puvodni signal a pod nim kratkodobou energii
INTEN %vykresli puvodni signal a pod nim kratkodobou intenzitu
Spectrum %vykreslí spektrum slova 'ahoj' a všech samohlásek (ukázka zpracování signálu pro teoretickou část)
KEP %kepstralni analyza, vykreslí kepstrum

%dale linearni prediktivni analzu?


%Record %program pro nahrávání nových záznamů