function [cesta,nazevsoub] = VyberSoubor()

%Funkce slouží k výběru souboru, vrátí cestu, a název souboru

[nazevsoub, cesta] = uigetfile(...
{'*.wav', 'Zvukové soubory wav';'*.*',...
'Všechny soubory'},...
  'Výběr souboru', 'nahravani\speakers');


if isequal(nazevsoub,0) || isequal(cesta,0) %volba zrušena
    disp('.... storno');
    return;
end;

end
