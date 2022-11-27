function varargout = nahravani(varargin)
% NAHRAVANI MATLAB code for nahravani.fig
%      NAHRAVANI, by itself, creates a new NAHRAVANI or raises the existing
%      singleton*.
%
%      H = NAHRAVANI returns the handle to a new NAHRAVANI or the handle to
%      the existing singleton*.
%
%      NAHRAVANI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NAHRAVANI.M with the given input arguments.
%
%      NAHRAVANI('Property','Value',...) creates a new NAHRAVANI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nahravani_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nahravani_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nahravani

% Last Modified by GUIDE v2.5 22-Feb-2022 10:51:53

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nahravani_OpeningFcn, ...
                   'gui_OutputFcn',  @nahravani_OutputFcn, ...
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


% --- Executes just before nahravani is made visible.
function nahravani_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nahravani (see VARARGIN)

% Choose default command line output for nahravani
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes nahravani wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nahravani_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_nahrej.
function pushbutton_nahrej_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_nahrej (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_nahrej,'Enable','inactive')
handles = guidata(hObject);
if get(handles.uloz_checkbox,'Value')==1
   F_Uloz(handles.speech, handles.Fs, handles.SpID);
   set(handles.save_pushbutton,'Enable','inactive');
end

Fs=16000;
Vyber = get(handles.popupmenuVstup_han,'Value');
a=handles.Din.(3);
IdZarizeni = a(Vyber);
handles.speech=F_Nahrej(handles.delka,Fs, IdZarizeni);
handles.Fs=Fs;
guidata(hObject, handles);

if get(handles.prehrej_checkbox,'Value')==1
    Vyber = get(handles.popupmenuVystup_han,'Value');
    a=handles.Dout.(3);
    IdZarizeni = a(Vyber);
    player = audioplayer(handles.speech,Fs,16,IdZarizeni);
    play(player)
    pause(length(handles.speech)/Fs)
%     sound(handles.speech, Fs);
end

set(handles.play_pushbutton,'Enable','on')
set(handles.save_pushbutton,'Enable','on')
set(handles.uloz_checkbox,'Enable','on')
set(handles.pushbutton_nahrej,'Enable','on')
% set(handles.uloz_checkbox,'Value',1)

function delka_int_Callback(hObject, eventdata, handles)
% hObject    handle to delka_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delka_int as text
%        str2double(get(hObject,'String')) returns contents of delka_int as a double
handles = guidata(hObject);
handles.delka=str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function delka_int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delka_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles = guidata(hObject);
handles.delka_int=hObject;
handles.delka=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes on selection change in vyber_popupmenu.
function vyber_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to vyber_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns vyber_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from vyber_popupmenu
handles = guidata(hObject);
handles.SpID=get(hObject,'Value'); %uloží ID vybraného řečníka
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function vyber_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vyber_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles = guidata(hObject);
handles.vyber_popupmenu=hObject;

[SpId,SpList] = F_ObnovSezRec();
set(hObject,'String',SpList);

handles.SpID=get(hObject,'Value'); %uloží ID vybraného řečníka
guidata(hObject, handles);



% --- Executes on button press in Novy_pushbutton.
function Novy_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Novy_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

popis = inputdlg('Zadej alias řečníka (např: "Josef M."):','Nový řečník');
if isempty(popis)
  return %kdyz zada storno tak ukonci funkci
end
if isempty(popis{1})
    popis{1}='Anonym';
end
F_NovyRecnik(popis);    %vytvoří složku pro nového řečníka
[handles.SpID,SpList] = F_ObnovSezRec();    %vytvoří aktuální seznam všech řečníků
set(handles.vyber_popupmenu,'String',SpList); %obnoví nabídku řečníků v menu
set(handles.vyber_popupmenu,'Value',handles.SpID); %nastaví v menu posledního řečníka

guidata(hObject, handles);


% --- Executes on button press in play_pushbutton.
function play_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to play_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
speech=handles.speech;
Fs=handles.Fs;
%  sound(speech, Fs);
Vyber = get(handles.popupmenuVystup_han,'Value');
a=handles.Dout.(3);
IdZarizeni = a(Vyber);
player = audioplayer(speech,Fs,16,IdZarizeni);
play(player)
pause(length(speech)/Fs)
% set(findobj(nahravani,'tag','Novy_pushbutton'),'String','aaa') %najde handle objektu

% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
speech = handles.speech;
Fs=16000;
F_Uloz(speech, Fs, handles.SpID);
set(handles.save_pushbutton,'Enable','inactive');

% --- Executes on button press in uloz_checkbox.
function uloz_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to uloz_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of uloz_checkbox



% --- Executes on button press in prehrej_checkbox.
function prehrej_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to prehrej_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prehrej_checkbox


% --- Executes during object creation, after setting all properties.
function uloz_checkbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uloz_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.uloz_checkbox=hObject;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Novy_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Novy_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.Novy_pushbutton=hObject;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function prehrej_checkbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prehrej_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.prehrej_checkbox=hObject;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton_nahrej_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_nahrej (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.pushbutton_nahrej=hObject;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function graf_prubeh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graf_prubeh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate graf_prubeh
handles = guidata(hObject);
handles.graf_prubeh=hObject;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function play_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to play_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.play_pushbutton=hObject;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function save_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.save_pushbutton=hObject;
guidata(hObject, handles);


% --- Executes on button press in KontStart.
function KontStart_Callback(hObject, eventdata, handles)
% hObject    handle to KontStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.KontStart,'Enable','inactive')
set(handles.delka2_han,'Enable','inactive')
set(handles.opakovani_han,'Enable','inactive')
set(handles.Stop_han,'Enable','on')

handles = guidata(hObject);
Fs=16000;

Vyber = get(handles.popupmenuVstup_han,'Value');
a=handles.Din.(3);
IdZarizeni = a(Vyber);
for i=1:handles.opakovani_hod
    handles.speech=F_Nahrej(handles.delka2_hod,Fs, IdZarizeni);
    F_Uloz(handles.speech, Fs, handles.SpID);
    drawnow;
    handles = guidata(hObject);
    if handles.Stop_hod==1
        break    
    end
end
soundsc(sin(0:2000), 2000);
handles.Fs=Fs;
guidata(hObject, handles);

set(handles.KontStart,'Enable','on')
set(handles.delka2_han,'Enable','on')
set(handles.opakovani_han,'Enable','on')
set(handles.Stop_han,'Enable','inactive')
handles.Stop_hod=0;
% set(handles.uloz_checkbox,'Value',1)


function delka2_Callback(hObject, eventdata, handles)
% hObject    handle to delka2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delka2 as text
%        str2double(get(hObject,'String')) returns contents of delka2 as a double
handles = guidata(hObject);
handles.delka2_hod=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function delka2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delka2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles = guidata(hObject);
handles.delka2_han=hObject;
handles.delka2_hod=str2double(get(hObject,'String'));
guidata(hObject, handles);


function opakovani_Callback(hObject, eventdata, handles)
% hObject    handle to opakovani (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of opakovani as text
%        str2double(get(hObject,'String')) returns contents of opakovani as a double
handles = guidata(hObject);
handles.opakovani_hod=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function opakovani_CreateFcn(hObject, eventdata, handles)
% hObject    handle to opakovani (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles = guidata(hObject);
handles.opakovani_han=hObject;
handles.opakovani_hod=str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles.Stop_hod=1;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles = guidata(hObject);
handles.Stop_han=hObject;
handles.Stop_hod=0;
set(handles.Stop_han,'Enable','inactive')
guidata(hObject, handles);


% --- Executes on selection change in popupmenuVstup.
function popupmenuVstup_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuVstup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuVstup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuVstup


% --- Executes during object creation, after setting all properties.
function popupmenuVstup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuVstup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles = guidata(hObject);
handles.popupmenuVstup_han=hObject;
info = audiodevinfo;
if isempty(info.input)
   errordlg('Nebyla nalezena žádná vstupní zařízení! Připojte mikrofon a restartujte aplikaci MATLAB. Program bude ukončen')
  closereq() %zadne nalezene zarizeni
end
handles.Din = struct2table(info.input);
handles.Dout = struct2table(info.output);
set(handles.popupmenuVstup_han,'String',handles.Din.Name);
guidata(hObject, handles);


% --- Executes on selection change in popupmenuVystup.
function popupmenuVystup_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuVystup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuVystup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuVystup


% --- Executes during object creation, after setting all properties.
function popupmenuVystup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuVystup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles = guidata(hObject);
handles.popupmenuVystup_han=hObject;
info = audiodevinfo;
if isempty(info.output)
   errordlg('Nebyla nalezena žádná výstupní zařízení! Připojte zvukový výstup a restartujte aplikaci MATLAB. Program bude ukončen.')
  closereq() %zadne nalezene zarizeni
end
handles.Din = struct2table(info.input);
handles.Dout = struct2table(info.output);
set(handles.popupmenuVystup_han,'String',handles.Dout.Name);
guidata(hObject, handles);
