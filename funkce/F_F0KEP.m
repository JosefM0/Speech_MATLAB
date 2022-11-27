function [F0] = F_F0KEP(X, Fs)
%F_F0KEP pomocí kepstrální analýzy vypočte a vrátí frekvenci hlasivkového
% tónu F0[Hz]
% 
% 
% [F0] = F_F0KEP(X, Fs)
% 
% X     -vstupní matice kde jednotlivé řádky jsou segmenty signálu
% Fs    -použitý vzorkovací kmitočet
% F0    -sloupcový vektor s vypočítaným F0 pro každý segment

for k=1:size(X,1)
    seg = X(k,:);
    
    seg = abs(fft(seg)); %vypocet amplitud FFT
    seg = log(seg); %vypocet logaritmu
    seg = ifft(seg); %pomocí inverzní FFT získáme kepsrum

    %odstranění pomalu měnících se složek lineární filtrací:   
    filtr = 52;
    kep1 = -ones(1,length(seg)); %inicializuje pole o délce segmentu
    kep1(filtr+1:length(seg)/2) = seg(filtr+1:length(seg)/2)*2;   %oddělí část kepstra tvořenou buzením (avybere část tvořenou parametry hlasivkového ústrojí)
    kep1(filtr) = seg(filtr);
     
    [M,i]=max(kep1);
    F0_tmp(k) = Fs/i;

end
F0=F0_tmp';

end
