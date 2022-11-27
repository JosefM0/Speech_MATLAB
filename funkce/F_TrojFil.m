function [F] = F_TrojFil(X,M,K,Fs)
% vytvoří banku trojúhelníkových filtrů rozložených přes celé frekvenční pásmo
% od nuly do Nyquistovy frekvence v melovské frekvenční škále a aplikuje jí
% na vstupní matici kde řádky jsou amplitudové spektra jednt. mikrosegmentů
% signálu
% 
% [F] = F_TrojFil(X,M,K,Fs)
% 
% % vstupy:
% X     -Vstupní signál ke řádky jsou ampl. spektra jednotlivých
% mikrosegmentů
% M     - počet trojúhelníkových filtrů 
% K     - velikost frekvenční odezvy každého filtru (např. počet prvku fft)/2 +1)
% Fs    -vzorkovací kmitočet (Hz)
% 
% výstupy:
% F     - výstupní matice kde každý řádek jsou výstupní hodnoty filtrů pro
% dany mikrosegment svstupního signálu. matice má tedy M sloupců.
%

fhz=linspace(0,Fs/2,K); %Výpočet hodnot frekv. osy. Frekvenční rozsah je 0 až Fs/2 Hz,  klmitočty jsou lineární rozložené. Zajímájí mě kmitočty pouze do 1/2 Fs (Nyquist. kritérium). 
fmel =  1127*log(1+fhz/700);  %přepočet frekv. osy do melovské škály 

deltam = max(fmel)/(M+1);  %krok sředních kmitočtů filtrů
bm =[0:M+1].*deltam;  %středové kmitočty trojúhleníkových filtrů v mel. škále
%% vytvoření banky filtrů
% U = zeros(M,K);   %U je banka M filtrů, kde každý řádek je jeden filtr od 1 po M řádků
for i=1:M
    for j=1:K
        if (fmel(j) >= bm(i)) && (fmel(j) < bm(i+1))    %první přímková čast trojúhelníku /
        	Umel(i,j) = (1 / ( bm(i+1) - bm(i) ) ) * ( fmel(j) - bm(i) ); 
        elseif (fmel(j) >= bm(i+1)) && (fmel(j) < bm(i+2))  %druhá přímková čast trojúhelníku \
            Umel(i,j) = (1 / ( bm(i+1) - bm(i+2) ) ) * ( fmel(j) - bm(i+2) );
        else      %odezva mimo filtr je nulová
            Umel(i,j) = 0;
        end
    end
end

Uhz = 700*exp(Umel/1127)-700;   %přepočet banky filtrů z mel. zpátky do Hz.    


%% průchod signálu bankou filtrů
Ftmp = zeros(size(X,1),M);  %inicializace pole
for k=1:size(X,1)
    x = X(k,1:K); %x je k-tý mikrosegment s ampl spekt, ořezaný po nyquist. frekv. 
    for m = 1:M
        u = Uhz(m,:);
        Ftmp(k,m) = sum( x.*u );
    end
end

F=Ftmp;
end


