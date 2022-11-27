function [F0] = F_F0(X,Fs)
%F_F0 pomocí autokorelační funkce vypočte a vrátí frekvenci hlasivkového
% tónu F0[Hz]
% 
% 
% [F0] = F_F0(X,Fs)
% 
% X     -vstupní matice kde jednotlivé řádky jsou segmenty signálu
% Fs    -použitý vzorkovací kmitočet
% F0    -sloupcový vektor s vypočítaným F0 pro každý segment


for k=1:size(X,1)
x = X(k,:);

[cor,tau]=xcorr(x);   %vypočte kolerační fci

%Vypocet zakladniho hlasivkoveho tonu z korelační funkce:
[M, i] = max(cor); %M je max. hodnota, i je pak cislo vzorku pro tau = 0 (maximum kor. fce je v nule)
[M, i] = max(cor((i+16) : length(cor) )); %hleda lokální maximum od kmitoctu < 1kHz (vyšší hlasivkový tón lidé nemívají); paltí pro Fs 16k ???
T0 = (i+15)/Fs; %zakladni hlasivkovy ton
F0_tmp(k)= 1/T0; %zakladni hlasivkovy ton
end
F0=F0_tmp';

end

