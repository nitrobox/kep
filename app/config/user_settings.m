function varargout = user_settings(varargin)
%USER_SETTINGS M-file for user_settings.fig
%      USER_SETTINGS, by itself, creates a new USER_SETTINGS or raises the existing
%      singleton*.
%
%      H = USER_SETTINGS returns the handle to a new USER_SETTINGS or the handle to
%      the existing singleton*.
%
%      USER_SETTINGS('Property','Value',...) creates a new USER_SETTINGS using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to user_settings_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      USER_SETTINGS('CALLBACK') and USER_SETTINGS('CALLBACK',hObject,...) call the
%      local function named CALLBACK in USER_SETTINGS.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help user_settings

% Last Modified by GUIDE v2.5 06-Feb-2014 17:44:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @user_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @user_settings_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before user_settings is made visible.
function user_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for user_settings
handles.output = hObject;

user_settings_load;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes user_settings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = user_settings_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function input_T_Callback(hObject, eventdata, handles)
% hObject    handle to input_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_T as text
%        str2double(get(hObject,'String')) returns contents of input_T as a double


% --- Executes during object creation, after setting all properties.
function input_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_save.
function btn_save_Callback(hObject, eventdata, handles)
% hObject    handle to btn_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_settings_save;
close;


function input_MG_Callback(hObject, eventdata, handles)
% hObject    handle to input_MG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_MG as text
%        str2double(get(hObject,'String')) returns contents of input_MG as a double


% --- Executes during object creation, after setting all properties.
function input_MG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_MG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_path_input_Callback(hObject, eventdata, handles)
% hObject    handle to input_path_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input_path_input,'String',uigetdir('Daten/', 'Bitte wählen Sie den Ordner mit den Eingangsdaten'));
updategui_settings;
% Hints: get(hObject,'String') returns contents of input_path_input as text
%        str2double(get(hObject,'String')) returns contents of input_path_input as a double


% --- Executes during object creation, after setting all properties.
function input_path_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_path_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_path_input.
function btn_path_input_Callback(hObject, eventdata, handles)
% hObject    handle to btn_path_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input_path_input,'String',uigetdir('Daten/', 'Bitte wählen Sie den Ordner mit den Eingangsdaten'));
updategui_settings;



function input_path_output_Callback(hObject, eventdata, handles)
% hObject    handle to input_path_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_path_output as text
%        str2double(get(hObject,'String')) returns contents of input_path_output as a double


% --- Executes during object creation, after setting all properties.
function input_path_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_path_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_path_output.
function btn_path_output_Callback(hObject, eventdata, handles)
% hObject    handle to btn_path_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over input_path_input.
function input_path_input_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to input_path_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input_path_input,'String',uigetdir('Daten/', 'Bitte wählen Sie den Ordner mit den Eingangsdaten'));
updategui_settings;



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to input_path_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_path_output as text
%        str2double(get(hObject,'String')) returns contents of input_path_output as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_path_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over input_path_output.
function input_path_output_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to input_path_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input_path_output,'String',uigetdir('Daten/', 'Bitte wählen Sie den Ordner für die Ausgangsdaten'));
updategui_settings;



function input_name_ntc_Callback(hObject, eventdata, handles)
% hObject    handle to input_name_ntc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_name_ntc as text
%        str2double(get(hObject,'String')) returns contents of input_name_ntc as a double



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over input_name_ntc.
function input_name_ntc_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to input_name_ntc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input_name_ntc,'String',uigetfile('Daten/', 'Bitte Datei mit NTC-Matrix wählen'));
updategui_settings;


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
