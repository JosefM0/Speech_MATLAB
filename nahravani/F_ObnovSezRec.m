function [SpId, SpList] = F_ObnovSezRec()
%Funkce vytvoří seznam řeníků dle knihy řečníků na disku a vrátí
%ID posledního řečníka
%  
% 
% [SpId,SpList] = F_ObnovSezRec()
% 
% SpId       - Vrátí ID číslo posledního řečniká v knize řečníků
% SpList     - Vrátí pole stringů s ID a popisem všech řečníků v knize

cesta = strcat(pwd,'\nahravani\speakers');   %vytvoří cestu ke složce se složkami řečníků
[pocet b] = (size(dir(cesta)));   %spočítá kolik již je nahrávek ve složce
pocet = pocet-2; %odečte systémové složky [..] a [.]
StringTmpA = ' ';
for i = 1:pocet
    Temp0 = strcat(cesta,'\',string(i),'\inf.txt'); %vytvoří cestu k souboru s informacemi o řečníkovi
    fId = fopen(Temp0,'r');  
    StringTmpA = [StringTmpA;{fscanf(fId,'%c')}];
    fclose(fId);
end

SpId = split(StringTmpA(end),':');
SpId=SpId{1};
SpId=str2num(SpId);
SpList = StringTmpA(2:end);
end

