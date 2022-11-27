function [MFCC] = F_MFCC(X, Fs, M, Mc)
% Vypočítá melovské kepstrální koeficienty ze vstupní matice signáůlu, kde
% každý řádek představuje mikrosegment
% 
% [MFCC] = F_MFCC(X, L, Fs, M, Mc)
% 
% X     -vstupní matice kde jednotlivé řádky jsou segmenty řečového signálu
% Fs    -vzorkovací kmitočet v Hz
% M `   -počet trojúhelníkových filtrů 
% Mc     -počet koef. kolik se má spočítat (vrátí o jened více(+ nultý koef.)) 
%
% MFCC  - výstupní matice s mel-kepstrálními koeficienty, kde na řádku jsou
% MFCC pro daný segment signálu o počtu M+1

N = size(X,2); % N     - velikost segmentu (pocet prvku jednoho segmentu)
Nfft = 2^nextpow2(N); %počet prvků fft analýzy

AMPL = abs(fft(X,Nfft,2));     %vrátí fft každého řádku

K = (Nfft/2)+1;    %počet hodnot pro frekv. odezvu (polovina hodnot z FFT, zbytek se opakuje)
FIL = F_TrojFil(AMPL,M,K,Fs); %vytvoří banku filtrů s melovským rozložením a provede filtraci signálu 
FLOG = log(FIL);

%%DCT: IDFT redukovaná na diskrétní kosinovou transformaci DCT
MFCC = zeros(size(FLOG,1),Mc+1);
for k=1:size(FLOG,1)
     flog = FLOG(k,:); %flog je zpracovaný signál k-tého mikrosegmentu
    for j=0:Mc
        Cm(j+1) = 0; %MFCC, incializace
        for i=1:M
            Cm(j+1) = Cm(j+1) + flog(i)*cos( ((pi*j)/M) * (i-0.5) );  %výpočet mel. koeficientů MFCC
        end
        MFCC(k,j+1)=Cm(j+1);
    end
end



end

