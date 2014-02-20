% main_data_open opens all files with the needed data for the pgp
% Input:
% Output:
% Algorithm:
% Date:
% Version:
% Known bugs: 
% Version:
% Author:
% Functions used : open_powerplant_park()
%                : open_ntc_matrix()
%                : open_demand()
% Variables:

if (handles.config.path.input~=0)
  % Loading data
  disp('Opening data:');
  path = handles.config.path.input;
  handles.data.ntc       = open_ntc_matrix(handles.config.MG,path,handles.config.filename.ntc);
  if size(handles.data.ntc,1)~=handles.config.MG || size(handles.data.ntc,2)~=handles.config.MG
    disp('NTC-Matrix has wrong size. MGxMG-Matrix and 2 Lines and Rows for Headers.');
  end
  for mg = 1 : handles.config.MG
    handles.data.area{mg}.ntc_max_import = handles.data.ntc(:,mg);
  end
  % handles.config.MG        = size(handles.data.ntc,1);
  handles.data.load = open_load(handles.config.MG,handles.config.T,path,handles.config.filename.load);
  handles.data.load = handles.data.load(1:handles.config.MG,1:handles.config.T);
  % main_data_open_entsoe;
  handles.data.load_after_trade = handles.data.load;
  handles.data.load_after_hydro = handles.data.load;
  % loading powerplantparks
  tag_thermo = cell(handles.config.MG,8);
  for mg = 1 : handles.config.MG

  [handles.data.area{mg}.park_thermo, tag_thermo, handles.data.area{mg}.park_hydro] = open_powerplant_park(path,handles.config.filename.park{1},handles.config.area{mg,1},handles.config.filename.park{2});
  handles.data.area{mg}.PP_thermo = size(handles.data.area{mg}.park_thermo,1);
  handles.data.area{mg}.PP_hydro = size(handles.data.area{mg}.park_hydro,1);
  handles.data.area{mg}.PP = handles.data.area{mg}.PP_thermo + handles.data.area{mg}.PP_hydro;
  if (handles.data.area{mg}.PP_hydro>0)
    handles.data.area{mg}.p_total_hydro_MAX = sum(handles.data.area{mg}.park_hydro(:,4));
  else
    handles.data.area{mg}.p_total_hydro_MAX = 0;
  end
  if (handles.data.area{mg}.PP_thermo>0)
    handles.data.area{mg}.p_total_thermo_MAX = sum(handles.data.area{mg}.park_thermo(:,4));
  else
    handles.data.area{mg}.p_total_thermo_MAX = 0;
  end
    handles.data.area{mg}.bezSO       = tag_thermo{1};
    handles.data.area{mg}.bezeichner  = tag_thermo{2};
    handles.data.area{mg}.langname    = tag_thermo{3};
    handles.data.area{mg}.Un          = tag_thermo{4};
    handles.data.area{mg}.kurzname    = tag_thermo{5};
    handles.data.area{mg}.id          = tag_thermo{6};
    handles.data.area{mg}.Pmin        = tag_thermo{7};
    handles.data.area{mg}.Pmax        = tag_thermo{8};
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % calculate Merit Order and total powers
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  disp('Calculating merit orders and total powers');

  for mg = 1:handles.config.MG
    % Calucalting maximum possible
    handles.data.area{mg}.p_total_MAX = sum(handles.data.area{mg}.park_thermo(:,4));
    % create merit order for market mg
    handles.data.area{mg}.meritorder = create_merit_order(handles.data.area{mg}.park_thermo);
    % calculate costingcurve for market mg
    handles.data.area{mg}.costingcurve = [0 cumsum(handles.data.area{mg}.meritorder)];
  end
  
  
end
