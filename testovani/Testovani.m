function varargout = Testovani(varargin)
% TESTOVANI MATLAB code for Testovani.fig
%      TESTOVANI, by itself, creates a new TESTOVANI or raises the existing
%      singleton*.
%
%      H = TESTOVANI returns the handle to a new TESTOVANI or the handle to
%      the existing singleton*.
%
%      TESTOVANI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTOVANI.M with the given input arguments.
%
%      TESTOVANI('Property','Value',...) creates a new TESTOVANI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Testovani_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Testovani_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Testovani

% Last Modified by GUIDE v2.5 18-Mar-2022 10:30:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Testovani_OpeningFcn, ...
                   'gui_OutputFcn',  @Testovani_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Testovani is made visible.
function Testovani_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Testovani (see VARARGIN)

% Choose default command line output for Testovani
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Testovani wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Testovani_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.Tabulka_h=hObject;
set(handles.Tabulka_h, 'Data',{});
guidata(hObject, handles);


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
set(handles.Tabulka_h, 'Data',{}); %    vymaže případná stará data v tabulce
%% Následující alogoritnust projde všechyn řečníky a soubory:
SouborStart = 16; % Kterým souborem se má začít (které nebyly použity pro trénování)
OK=0;
NOK=0;
Yverif=0;
YPred=0;
cesta=strcat(pwd,'\nahravani\speakers');   %vytvoří cestu k složce s řečníky
[pocetR tmp] = (size(dir(cesta)));   %spočítá kolik je registrovaných řečníků
pocetR = pocetR - 2 ; %korekce počtu - odečte systémové soubory
for Recnik=1:pocetR
    cesta=strcat(pwd,'\nahravani\speakers\',string(Recnik));   %vytvoří cestu k složce řečníka
    [pocetS tmp] = (size(dir(cesta)));   %spočítá kolik je nahrávek ve složce vybraného řečníka
    pocetS = pocetS - 3; %korekce počtu - odečte systémové soubory
    for Soubor=SouborStart:pocetS
        cestaS = strcat(cesta,'\',string(Soubor),'.wav');  %vytvoří cestu k souboru i.wav,
       
        Y=Identifikuj(cestaS);  %Identifikace řečníka
        [tmp Id]=max(countcats(Y)); %vybere nejčastější predikci identity řečníka
        pravdepodobnost = num2str(round(max(countcats(Y))*100/sum(countcats(Y)),2),4);
        %Zapíše výsledky do tabulky:
        Tab=get(handles.Tabulka_h, 'Data');
        if Id == Recnik   %porovnani vysledku identifikace se skutecnosti
            OK = OK + 1;
            porovnani = 'OK';
        else
            NOK = NOK + 1;
            porovnani = 'NOK';
        end
        Tab(size(Tab,1)+1,1:5)={Recnik,strcat(num2str(Soubor),'.wav'),Id,pravdepodobnost,porovnani}       
        set(handles.Tabulka_h, 'Data',Tab);
        Text=strcat('Řečník č...',num2str(Recnik),', Soubor..',strcat(num2str(Soubor),'.wav'),'->',porovnani);
        set(handles.Zprava_h, 'String',Text);
        drawnow 
        %Kolekce dat pro vytvoření matice záměn všech příznakových vektorů,
        if (Soubor==SouborStart)&&(Recnik==1)   %podmínka nastane při první iteraci
            YPred = Y; %kolekce výsledků predikce identity
            Yverif(1:size(Y,1),1) = Recnik;  %kolekce pravých identit řečníků
        else
            YPred = vertcat(YPred,Y);
            clear YTmp
            YTmp(1:size(Y,1),1) = Recnik;
            Yverif = vertcat(Yverif,YTmp);  %kolekce pravých identit řečníků
        end
        %všech souborů a řečníků:
        
    end
end
presnost = OK*100 /(NOK+OK);
Text=strcat('Systém správně identifikoval...',num2str(presnost,4),' % souborů.');
set(handles.Zprava_h, 'String',Text);


%% vykreslení matice záměn:
figure
Yverif=categorical(Yverif)
C = confusionmat(Yverif,YPred);
cm = confusionchart(Yverif,YPred, ...
    'Title','Matice záměn', ...
    'XLabel','Odhadnutá identita řečníka', ...
    'YLabel','Pravá identita řečníka', ...
    'RowSummary','row-normalized');

%%
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Zprava_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Zprava (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.Zprava_h=hObject;
set(handles.Zprava_h, 'String','Systém správně identifikoval XX,XX % souborů.');
guidata(hObject, handles);
