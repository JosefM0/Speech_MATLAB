function [INTEN] = F_Inten(X)
% F_Inten(X) Vráti krátkodobou intenzitu
% 
% 
% function [INTEN] = F_Inten(X)
% 
% X     -vstupní matice kde jednotlivé řádky jsou segmenty signálu
% INTEN   -sloupcový vektor s vypočítanou krátkodobou energií pro každý segment

INTEN = zeros(size(X,1),1);
for k=1:size(X,1)
    x = X(k,:);

    inten = 0;
    for i=1:length(x)-1
        inten = inten + abs(x(i));  %výpočet energie
    end
    INTEN(k) = inten; 
    
%     graf(1+(k-1)*size(X,2):k*size(X,2)) = ener;
end

% figure
% plot(graf)
% xlabel('n (-)')
% ylabel('E[n]')
% title('Krátkodobá energie (velikost segmentu je 128 vzorků):')

end

