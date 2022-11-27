function [IVector] = F_ExtFeatures(path, SpId, Tseg, Tow )
%[iVektor] = F_ExtFeatures(path, SpId, Tseg, Tow ) Vráti vektor s features
%pro každý segment signálu vstupního audio souboru
% 
% 
% [IVector] = F_ExtFeatures(path, SpId, Tseg, Tow )
% 
% path     -cesta k analyzovaného zvokového záznamu (*.wav)
% SpId     -unikátní identifikační číslo řečníka pro daný zvukový záznam
% Tseg     -délka segmentu pro následnou segmentaci (ms)
% Tow      -přektrytí segmentu pro následnou segmentaci (ms)
% 
% iVektor  -Výstupní matice, kde každý řádek obsahuje features pro každý
% mikrosegment: [SpId ENE INTEN ZCR MFCC(0)...MFCC(10), F0_ACF, F0_KEP].
% Kde jednotlivé zkratky znamenají:
% SpId      ...unikátní identifikační číslo řečníka pro daný zvukový záznam
% ENE       ...krátkodobá energie
% INTEN     ...krátkodobá intenzita    
% ZCR       ...počet průchodů nulou
% MFCC(*)   ...melovské kepstrální koeficienty
% F0_ACF    ...základní hlasivkový kmitočet F0 (Hz) získaný pomocí ACF
% F0_KEP    ...F0 (Hz) získaný pomocí kepstrální analýázy


[x,Fs] = audioread(path);
N = round(1E-3*Tseg*Fs);  %velikost segmentu (pocet prvku jednoho segmentu)
L = round(1E-3*Tow*Fs);  %počet prků překrytí (0 až N)

x = F_preem(x); %preemfáze
X = F_segmentace(x, N, L, 'ham');
X = F_hamming(X);  %okénkování Hammingovou funkcí

%% Krátkodobá energie
ENE = F_Ene(X);     %Výpočet krátkodobé energie

%% Krátkodobá intenzita
INTEN = F_Inten(X);     %Výpočet krátkodobé intenzity

%%MFCC
M = 20; %počet trojúhelníkových filtrů pro výpočet MFCC
Mc = 10; %zadej konečný index hledaných mel. koeficientů, obvylke 10 až 13, max. M,
MFCC = F_MFCC(X, Fs, M, Mc);

%% Průchody nulou
ZCR = F_ZCRh(X);

%% F0 pocí krátkodobé ACF
N_acf=6;   % násobek puvodni velikosti segmentu pro ACF, segment pro ACF musí být větší 
X_acf = F_segmentace(x, N_acf*N, N_acf*L, 'ham');
% ENE_acf = F_Ene(X_acf);
F0_acf = F_F0(X_acf,Fs);
for i=1:length(F0_acf)
    F0(1+N_acf*(i-1):N_acf*i,:)= F0_acf(i); %Vytvoří vektor s F0 s opakovanou hodnotou kvůli sloučení s ostatními features, které jsou pro kratší segmenty
end

%% F0 pocí krátkodobé kepstrální analázy
[F0_kep] = F_F0KEP(X, Fs);

%% i-Vektor - sloučení všech získaných features do jednoho vektrou (jeden vektor pro každý segment)
 Nradk = min([length(ENE) length(INTEN) length(MFCC) length(ZCR) length(F0) length(F0_kep)]);
 IVector=zeros(Nradk,1+1+Mc+1+1+1+1+1);
 for k=1:Nradk
    IVector(k,:) = [SpId ENE(k) INTEN(k) ZCR(k) MFCC(k,1:Mc+1) F0(k) F0_kep(k)];
 end
 
end