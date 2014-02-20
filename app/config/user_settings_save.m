handles.config.T = str2num(get(handles.input_T,'String'));
handles.config.MG = str2num(get(handles.input_MG,'String'));
handles.config.path.input = get(handles.input_path_input,'String');
handles.config.path.output = get(handles.input_path_output,'String');
handles.config.filename.ntc       = get(handles.input_name_ntc,'String');
handles.config.filename.load  = get(handles.input_name_residual,'String');
handles.config.filename.park     = {get(handles.input_name_park_pre,'String') get(handles.input_name_park_post,'String')};
handles.config.area = get(handles.tbl_input_markets,'Data');
%save('config\config', '-struct', 'handles', 'config'); 

% temporary settings
handles.config.mg = 1;
handles.config.t = 1;
handles.config.status.imex = false;
handles.config.status.mp = false;

% QUICK & DIRTY

 %Der Dateiname muss den Namen des Marktgebietes enthalten

handles.config.Spalte_KW_id        =   'A'; %Eindeutige id       des KW
handles.config.Spalte_KW_Pmin      =   'K'; %Minimalleistung     des KW
handles.config.Spalte_KW_Pmax      =   'J'; %Maximalleistung     des KW
handles.config.Spalte_KW_eta       =   'G'; %Wirkungsgrad        des KW 
handles.config.Spalte_KW_e         =   'H'; %Emissionsgrad       des KW
handles.config.Spalte_KW_kb        =   'I'; %Brennstoffkosten    des KW
handles.config.Spalte_KW_kurzname  =   'C'; %ob E001 oder E003
handles.config.Spalte_KW_typ       =   'F'; %Primärenergietyp    des KW

handles.config.Spalte_KW_bezSO     =   'B';
handles.config.Spalte_KW_bezeichner=   'E'; %Entspricht Kurzname!
handles.config.Spalte_KW_langname  =   'F';
handles.config.Spalte_KW_Un        =   'D';

% pricecap
handles.config.pricecap = inf;

% admin settings
handles.config.doc = true;

save('config\config', '-struct', 'handles', 'config'); 
