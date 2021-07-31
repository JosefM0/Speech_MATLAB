clc; clear all; close all
load('parametrs.mat')
load('zena_ahoj.mat')
% figure(1); plot(speech);

segment = speech(16000:27000);
% figure(2); plot(segment)

figure(2); subplot(2,1,1);
plot([1:size(segment)]/Fs, segment)
axis([0 0.65 -0.1 0.1]);

[cor,tau]=xcorr(segment);
subplot(2,1,2);
plot(tau/Fs,cor);
axis([0 0.65 -1 3]);

%Vypocet zakladniho hlasivkoveho tonu:
[M, i] = max(cor); %M je max. hodnota, i je cislo vzorku
T0= max(cor((i+16) : length(cor) )) %hleda od kmitoctu nizzsich 1kHz
F0 = 1/T0
% 
% 
% cor((length(tau)+1)/2) %hodnota corelacni funkce pro tau=0
% maxk(cor,10) %hledani max. zacina od tau=0.05s (20Hz)  
% 
% 
% figure(1111)
% plot(tau,cor);