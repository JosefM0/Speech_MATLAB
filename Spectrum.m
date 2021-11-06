%Spektrum samohlkásek

%clc; clear all; close all;
%load('parametrs.mat');

load('me_ahoj.mat');
speech_spec = fft(speech);
figure(100); subplot(6,1,1); plot( abs(speech_spec));
xlabel('k (-)')
ylabel('Z(k)')
title('Spektrální obálka slova "ahoj":')
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
