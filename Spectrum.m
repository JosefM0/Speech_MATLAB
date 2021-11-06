%Spektrum samohlkásek

%clc; clear all; close all;
%load('parametrs.mat');

load('me_ahoj.mat');
L = length(speech);  %delka signalu
speech_spec = fft(speech); %vypocet fourier. transformace
P2 = abs(speech_spec/L); %vypocet dvojstraneho spektra
P1 = P2(1:L/2+1); %vypocet jednostraneho spektra (dle napovedy)
P1(2:end-1) = 2*P1(2:end-1); %vypocet jednostraneho spektra (dle napovedy)
f = Fs*(0:(L/2))/L;
figure(100); subplot(6,1,1); plot(f,P1);
xlabel('f (Hz)')
ylabel('|P1(f)|)')
title('Jednostranné amplidudové spektrum slova "ahoj":')
xlim([0 4000]);

load('me_a.mat');
speech_spec = fft(speech);
subplot(6,1,2); plot(abs(speech_spec));
xlabel('k (-)')
ylabel('Z(k)')
title('Samohláska "a":')
xlim([0 4000]);

load('me_e.mat');
subplot(6,1,3)
speech_spec = fft(speech);
plot(abs(speech_spec));
xlabel('k (-)')
ylabel('Z(k)')
title('Samohláska "e":')
xlim([0 4000]);

load('me_i.mat');
subplot(6,1,4)
speech_spec = fft(speech);
plot(abs(speech_spec));
xlabel('k (-)')
ylabel('Z(k)')
title('Samohláska "i":')
xlim([0 4000]);

load('me_o.mat');
subplot(6,1,5)
speech_spec = fft(speech);
plot(abs(speech_spec));
xlabel('k (-)')
ylabel('Z(k)')
title('Samohláska "o":')
xlim([0 4000]);

load('me_u.mat');
subplot(6,1,6)
speech_spec = fft(speech);
plot(abs(speech_spec));
xlabel('k (-)')
ylabel('Z(k)')
title('Samohláska "u":')
xlim([0 4000]);
