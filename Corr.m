% clc; clear all; close all
% load('parametrs.mat')
% load('me_ahoj.mat')
% figure(1); plot(speech);

% segment = speech(16000:27000);
segment = speech;
% figure(2); plot(segment)

figure(2); subplot(2,1,1);
plot([1:size(segment)]/Fs, segment) %vykreslí řečový signál
% axis([0 0.65 -0.1 0.1]);
xlabel('t (s)')
ylabel('w(t)')
title('Průběh řečového signálu v čase - vyslovení "ahoj":')

[cor,tau]=xcorr(segment);   %vypočte kolerační fci
subplot(2,1,2);
plot(tau/Fs,cor);   %vykreslí kolerační fci do grafu
% axis([0 0.65 -1 3]);
xlabel('tau (-)')
ylabel('X(tau)')
title('Korelační funkce')

%Vypocet zakladniho hlasivkoveho tonu z korelační funkce:
[M, i] = max(cor); %M je max. hodnota, i je pak cislo vzorku pro tau = 0 (maximum kor. fce je v nule)
[M, i] = max(cor((i+16) : length(cor) )); %hleda lokální maximum od kmitoctu < 1kHz (vyšší hlasivkový tón lidé nemívají)
T0 = (i+16)/Fs; %zakladni hlasivkovy ton
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