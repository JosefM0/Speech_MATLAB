% clc; clear all; close all
% load('parametrs.mat')
% load('me_ahoj.mat')
% figure(1); plot(speech);

% segment = speech(16000:27000);
segment = speech;
% figure(2); plot(segment)

figure(2); subplot(2,1,1);
plot([1:size(segment)]/Fs, segment)
% axis([0 0.65 -0.1 0.1]);

[cor,tau]=xcorr(segment);
subplot(2,1,2);
plot(tau/Fs,cor);
% axis([0 0.65 -1 3]);

%Vypocet zakladniho hlasivkoveho tonu:
[M, i] = max(cor); %M je max. hodnota, i je pak cislo vzorku pro tau = 0
[M, i] = max(cor((i+16) : length(cor) )); %hleda od kmitoctu < 1kHz
T0 = (i+16)/Fs;
F0 = 1/T0; %zakladni hlasivkovy ton
% 
% 
% cor((length(tau)+1)/2) %hodnota corelacni funkce pro tau=0
% maxk(cor,10) %hledani max. zacina od tau=0.05s (20Hz)  
% 
% 
% figure(1111)
% plot(tau,cor);
disp("Zakladní hlasivkový tón (Hz):")
disp(F0)
clear i cor tau T0 F0