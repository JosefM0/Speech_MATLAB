function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 28-Mar-2022 15:16:58

% Begin initialization code - DO NOT EDIT
path(path,strcat(pwd,'\nahravani\speakers'));
path(path,strcat(pwd,'\nahravani'));
path(path,strcat(pwd,'\funkce'));
path(path,strcat(pwd,'\data'));
path(path,strcat(pwd,'\testovani'));

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in kniha_pushbutton.
function kniha_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to kniha_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nahravani


% --- Executes on button press in klasifikator_pushbutton.
function klasifikator_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to klasifikator_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PripravData
trening

% --- Executes on button press in Test_pushbutton.
function Test_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Test_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Testovani

% --- Executes on button press in pushbutton_VyberSoubor.
function pushbutton_VyberSoubor_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_VyberSoubor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
[cesta,nazevsoub] = VyberSoubor()
if cesta == 0
   return %pokud neni vzbran soubor, tak konec funkce
end
handles.soubor = fullfile(cesta, nazevsoub);
[handles.speech, handles.Fs] = audioread(handles.soubor);
% figure(GrafDole_h);
plot(handles.GrafNahore_h,[1:size(handles.speech)]/handles.Fs, handles.speech); 
xlabel('t (s)');
StringTmp0 = split(cesta,'\');
StringTmp0 = split(cesta,'\');
set(handles.TextSoub_h,'String',strcat('Řečník číslo::',StringTmp0(end-1),'...Soubor::',nazevsoub));
set(handles.TlacitkoIdentifikuj_h,'Enable','on')
guidata(hObject, handles);

% --- Executes on button press in pushbutton_Identifikuj.
function pushbutton_Identifikuj_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Identifikuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
Y=Identifikuj(handles.soubor);
bar(handles.GrafDole_h,countcats(Y)*100./sum(countcats(Y)));

xlabel(handles.GrafDole_h,'ID řečníka');
ylabel(handles.GrafDole_h,'Pravděpodobnost (%)');
ylim(handles.GrafDole_h,[0 100]);
handles.GrafDole_h.YGrid='on';
handles.GrafDole_h.XGrid='on';
handles.GrafDole_h.YMinorGrid='on';
[tmp0 Id]=max(countcats(Y));
mes = strcat('Řečníkem na záznamu je řečník č. ',string(Id),'.')
set(handles.TextVysledek_h,'String',mes);
guidata(hObject, handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to TextVysledek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TextVysledek as text
%        str2double(get(hObject,'String')) returns contents of TextVysledek as a double


% --- Executes during object creation, after setting all properties.
function TextVysledek_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TextVysledek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles = guidata(hObject);
handles.TextVysledek_h=hObject;
set(handles.TextVysledek_h,'String',' ');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
handles = guidata(hObject);
handles.GrafNahore_h=hObject;
xlabel('t (s)');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function textSoubor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textSoubor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.TextSoub_h=hObject;
set(handles.TextSoub_h,'String','Není vybraný žádný soubor.');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
handles = guidata(hObject);
handles.GrafDole_h=hObject;
xlabel(handles.GrafDole_h,'ID řečníka');
ylabel(handles.GrafDole_h,'Pravděpodobnost (%)');
ylim(handles.GrafDole_h,[0 100]);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton_Identifikuj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_Identifikuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.TlacitkoIdentifikuj_h=hObject;
guidata(hObject, handles);
