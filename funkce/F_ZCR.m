function [ZCR] = F_ZCR(X)
%F_ZCR Vráti počet průchodů nulou
% 
% 
% [ZCR] = F_ZCR(X)
% 
% X     -vstupní matice kde jednotlivé řádky jsou segmenty signálu
% ZCR   -sloupcový vektor s vypočítaným počtem průchodů nulou


ZCR = zeros(size(X,1),1);
for k=1:size(X,1)
    x = X(k,:);
    zc = 0;
    for i=1:length(x)-1   %cyklus postupně projde každý vzorek daného segmentu
        if x(i)*x(i+1) > 0  %pokud mezi dvěmi souslednými vzorky nedojde průchodů nulou, budou mít jejich součin kladné znaménko
            zc = zc+0;
        else
            zc = zc+1;  %pokud signal prošel nulou, součin sousedních vzorků je záporný
        end
    end
    ZCR(k) = zc; 

    

end
end
