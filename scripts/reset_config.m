handles.config.T = 10;
handles.config.MG = 10;
handles.config.path.input = '../data/input';
handles.config.path.output = '../data/output';
handles.config.filename.ntc = 'NTC.xlsx';
handles.config.filename.load = 'Residuallast_test.xlsx';
handles.config.filename.park{1,1} = 'Netzeinspeisungen-E001-E003-';
handles.config.filename.park{1,2} = '.xlsx';
handles.config.area = {
'Belgien'       'B'       'BE';
'Dänemark_Ost'  'DK_O'    'DK';
'Dänemark_West' 'DK_W'    'DK';
'Frankreich'    'F'       'FR';
'Niederlande'   'N'       'NL';
'Österreich'    'O'       'AT';
'Polen'         'Z'       'PL';
'Schweiz'       'S'       'CH';
'Tschechien'    'C'       'CZ';
'Deutschland'   'D'       'DE'
};

% TO RENAME
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

handles.config.pricecap = inf;
handles.config.doc = true;
handles.config.mg = 1;
handles.config.t = 1;
handles.config.status.imex = false;
handles.config.status.mp = false;

save('../app/config/config_NEW', '-struct', 'handles', 'config'); 
