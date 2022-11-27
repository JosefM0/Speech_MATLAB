function [ZCR] = F_ZCRh(X)
%F_ZCR Vráti počet průchodů nulou s hysterezi H
% 
% 
% [ZCR] = F_ZCRh(X)
% 
% X     -vstupní matice kde jednotlivé řádky jsou segmenty signálu
% ZCR   -sloupcový vektor s vypočítaným počtem průchodů nulou

H = 5e-3;
ZCR = zeros(size(X,1),1);
for k=1:size(X,1)
    x = X(k,:);
    if x(1) > 0 %urci smer prechodu pres nulu kvuli hystereze
        Hs = H;
    else
        Hs = -H;
    end
    
    zc = 0;
    for i=1:length(x)-1   %cyklus postupně projde každý vzorek daného segmentu
        if (x(i)+Hs)*(x(i+1)+Hs) > 0  %pokud mezi dvěmi souslednými vzorky nedojde průchodů nulou, budou mít jejich součin kladné znaménko
            zc = zc+0;
        else
            zc = zc+1;  %pokud signal prošel nulou, součin sousedních vzorků je záporný
            Hs = -Hs;
        end
    end
    ZCR(k) = zc; 

    

end
end
 
   