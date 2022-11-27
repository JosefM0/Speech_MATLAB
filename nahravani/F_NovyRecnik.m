function [ID] = F_NovyRecnik(popis)
%F_NovyRecnik Vytvoří složku a uloží info pro nového řečníka 
% 
% 
% [ID] = F_NovyRecnik(popis)
% 
% ID       - vrátí ID číslo řečníka
% popis    - popis rečníka, který se uloží do složky to inf.txt

cesta=strcat(pwd,'\nahravani\speakers');   %vytvoří cestu ke složce se složkami řečníků
[pocet b] = (size(dir(cesta)));   %spočítá kolik již je nahrávek ve složce
cesta=strcat(pwd,'\nahravani\speakers\',string(pocet-1));   %vytvoří cestu k složce řečníka
mkdir(cesta);
cesta=strcat(cesta,'\inf.txt'); %vytvoří cestu k souboru s informacemi o řečníkovi
fid = fopen(cesta, 'wt');
fprintf( fid, strcat(string(pocet-1),':',popis));
fclose(fid);

display(strcat('Byl vytvořen nový řečník: ...',string(pocet-1),'...',popis))

ID = pocet-1;

end

