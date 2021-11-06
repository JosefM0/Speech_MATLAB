%Pruchody nulou, ZCR zero crossing rating

%SEGMENTACE BEZ PREKRYTI
wz = 160; %velikost segmentu 160 vzorků, to odpovídá čas. intervlu 10 ms při Fs = 16 kHz
poc = floor(length(speech)/wz); %počet segmentů segmentovaného signmálu
for k=1:poc  %cyklus postupně vybíra segmenty
    seg = speech(1+(k-1)*wz:k*wz);  %vyjme aktualni segment z celkoveho signalu

    zc = 0;
    for i=1:length(seg)-1   %cyklus postupně projde každý vzorek daného segmentu
        if seg(i)*seg(i+1) > 0  %pokud mezi dvěmi souslednými vzorky nedojde průchodů nulou, budou mít jejich součin kladné znaménko
            zc = zc+0;
        else
            zc = zc+1;  %pokud signal prošel nulou, součin sousedních vzorků je záporný
        end
    end
    zcr = zc/length(seg);   %zprůměrování počtu průchodů nulou na celý segment
    ZCRs(k) = zcr;  %uložení výsledků pro každý segment k
    
    graf(1+(k-1)*wz:k*wz) = zcr; %vytvoření 
end
figure(20)
subplot(2, 1, 1)
plot(speech)
xlabel('n (-)')
ylabel('w[n]')
title('Řečový signál (vzorkovací kmitočet je 16 kHz):')

subplot(2, 1, 2)
plot(graf)
xlabel('n (-)')
ylabel('ZCR[n]')
title('Průměrný počet průchodů nulou na segment (velikost segmentu je 160 vzorků):')
clear k i zcr wz poc zc graf