if exist('config.mat','file')
load('config.mat');
handles.config = config;
clear config

set(handles.input_T,'String',handles.config.T);
set(handles.input_MG,'String',handles.config.MG);
set(handles.input_path_input,'String',handles.config.path.input);
set(handles.input_path_output,'String',handles.config.path.output);
set(handles.input_name_ntc,'String',handles.config.filename.ntc );
set(handles.input_name_residual,'String',handles.config.filename.load);
set(handles.input_name_park_pre,'String',handles.config.filename.park{1,1});
set(handles.input_name_park_post,'String',handles.config.filename.park{1,2});
set(handles.tbl_input_markets,'Data',handles.config.area);
updategui_settings;
end;