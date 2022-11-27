function [Xout] = F_Selekce(Xin, k, prah)
%F_Selekce Vyslektuje (odmaže) řádky vstupní mátice Xin, jejiž k-tá hodnota bude
%vyhovovat podmínce v proměnné fce (podmínka je pouze "větší než", tato proměnná je rezervovaná pro budoucí úpravu fce).
% 
% 
% [Xout] = F_Selekce(Xin, k, prah)
% 
% Xin    -vstupní matice kde v jednotlivých řádcích jsou data s příznaky
% ENE   -sloupcový vektor s vypočítanou krátkodobou energií pro každý segment
% k     -číslo prvku který se bude zkoumat
% prah  -prahová hodnota
% fce   -podmínka selekce(nepoužito-reserva) (Možnosti: '>','<','=')
% 
% Xout  -selektovaná matice

%určí počet vyhovujících řádků vstupní matice:
N=0;
for i=1:size(Xin,1)
    x = Xin(i,:);
    if x(k)>prah
        N = N + 1;
    end       
end

Xout = zeros(N,size(Xin,2)); %inicializace

%sestaví výstupní matici bez nevyhovujících řádků vstupní matici:
N=1;
for i=1:size(Xin,1)
    x = Xin(i,:);
    if x(k)>prah
        Xout(N,:) = x;
        N = N + 1;
    end       
end

end
% for k=1:size(X_in,1)
%     seg = X_in(k,:);     
%     seg = seg.*hamming(length(seg))'; %okenkování Hammingovou funkcí
%     X_out(k,:) = seg;
% end
