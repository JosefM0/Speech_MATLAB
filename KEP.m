%kepstralní analýza

clear all; close all; clc
load('parametrs.mat');  % načte parametry záznamu ze souboru (Fs)
% load('me_ahoj.mat');    % načte záznam ze souboru
load('me_a.mat');    % načte záznam ze souboru
% soundsc(speech, Fs); % prehraje načtený záznam
% pause(1.2)
figure(700), hold on

ow = 320; %velikost 1/2 segmentu odpovídající doby 20 ms
lSeg = 2*ow;    %velikost celého segmentu (segment je 40ms)
nSeg = 2*(floor(length(speech)/lSeg))-1; %pocet polovin segmentu
for k=1:nSeg
    seg = speech(1+(k-1)*ow:(ow+k*ow)); %rozdělení signálu na segmenty     
    seg = seg.*hamming(lSeg); %okénkovani hammingovou funkcí
    seg = abs(fft(seg)); %vypocet amplitud FFT
    seg = log(seg); %vypocet logaritmu
    seg = ifft(seg); %pomocí inverzní FFT získáme kepsrum
    plot(1000*[1:size(seg)]/Fs, seg) %vykreslí řečový signál
    keps(k,1:lSeg) = seg; %uložení všech kepster pro každý segment do jedné matice
    
    %% Výpošet přenosové funkce hlasového ústrojí (spektrální obálky)

    %odstranění rychle měnících se složek lineární filtrací:
    filtr = 2; %(ms) tato hodnota musí být menží než základní perioda hlasivkového tónu
    filtr = filtr*(Fs/1000); %přepočet parametru filtrace z čas. intererv. na počet vzorků
    kep2 = zeros(1,lSeg); %vytvoří nulové pole o délce segmentu
    kep2(1:filtr-1) = seg(1:filtr-1)*2;   %oddělí část kepstra tvořenou buzením (avybere část tvořenou parametry hlasivkového ústrojí)
    kep2(1) = seg(1);
    kep2(filtr) = seg(filtr);
    obal = real(fft(kep2));    %převede filtr. kepstrum zpět do frekvenční oblasti
    pl1=real(20*log10(obal(1:lSeg/2)));
    act = real(fft(seg)); %převede kepstrum do frekvenční oblasti   
    obals(k,1:lSeg/2) = pl1; %uložení všech spekt. obálek pro každý segment do jedné matice
    kepsf(k,1:lSeg/2) = pl1;

end
xlim([0 20])
ylim([-0.5 2])
xlabel('t (ms)')
ylabel('amplituda(dB)')
title('Kepstra jednotlivých segmentů:')

span=[1:Fs/lSeg:Fs/2];
figure(800)
surf(obals)
title('Časový průběh změn tvaru spektrálních obálek slova "Ahoj"')

% Zobrazení spektrální obálky segmentu kn:
kn = 30;
seg = keps(kn, 1:lSeg)';
figure(900)
pl1=20*log10(obal(1:lSeg/2));
pl2=20*log10(act(1:lSeg/2));
span=[1:Fs/lSeg:Fs/2]; 
plot(span,pl1,'k-.',span,pl2,'b'); %Vykreslení spectální obálky z vybraného segmentu kn:
xlabel('F (Hz)');
ylabel('amplituda(dB)')
title('Spektrální obálka')

