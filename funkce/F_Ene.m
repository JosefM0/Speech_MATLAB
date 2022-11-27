function [ENE] = F_Ene(X)
%F_ENE Vráti krátkodobou energii
% 
% 
% [ENE] = F_Ene(X)
% 
% X     -vstupní matice kde jednotlivé řádky jsou segmenty signálu
% ENE   -sloupcový vektor s vypočítanou krátkodobou energií pro každý segment

ENE = zeros(size(X,1),1);
for k=1:size(X,1)
    x = X(k,:);

    ener = 0;
    for i=1:length(x)-1
        ener = ener + (x(i)*x(i));  %výpočet energie
    end
    ENE(k) = ener; 
    
%     graf(1+(k-1)*size(X,2):k*size(X,2)) = ener;
end

% figure
% plot(graf)
% xlabel('n (-)')
% ylabel('E[n]')
% title('Krátkodobá energie (velikost segmentu je 128 vzorků):')

end

