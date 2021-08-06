clear all; close all; clc
load('parametrs.mat');
load('me_ahoj.mat');
%  soundsc(speech, Fs);
%  pause(1.2)

Corr %Zobrszí signál a jeho korelační funkci, a vypočítá základní hlasiv. kmit.
ZCR %vykresli puvodni signal a pod nim pocet pruchodu nulou/128 prvku
Segmentation %Rozdělí signál na segmenty, zobr. v grafu
Hamming %Na rozděleny signál uplatní hamming. okno, zobr. v grafu (volat az po Segmentation.m)

%Co dále? Kepstrální koef, Mel-kep coef, ...