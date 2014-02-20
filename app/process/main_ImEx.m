% main_data_open opens all files with the needed data for the kep
% Input: handles.data.T
%        handles.config.MG
%        handles.data.ntc
%        handles.data.area{mg}.park_thermo
%        handles.data.demand
% Output: handles.data.area{mg}.kep : MGxT cell : each cell
% contains a powerplant service plan
%       : handles.data.exports{t}
% Algorithm:
% Date:
% Version:
% Known bugs: 
% Version:
% Author:
% Functions used: opt_imex()
% Variables: sqrMG
%          : AlleKWParks
%          : t


if exist('cplexlp.m','file')
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % imports
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create cell array of all parks
  array_hydro = cell(handles.config.MG,1);
  array_thermo = cell(handles.config.MG,1);
  for mg = 1 : handles.config.MG
    array_hydro{mg,1} = handles.data.area{mg}.park_hydro;
    array_thermo{mg,1} = handles.data.area{mg}.park_thermo;
  end
 
% optimize imports and exports for all timesteps by the function opt_imex()
  pgp = cell(handles.config.MG,handles.config.T); % in each cell is an array of PPx1 with the generated power of each plant
  imports = cell(1,handles.config.T); % each cell contains a MGxMG matrix
  for t = 1 : handles.config.T
    disp(['t = ' num2str(t)]);
    [pgp(1:handles.config.MG,t), imports{t}] = opt_imex(handles.config.MG, cell2mat(handles.data.ntc), handles.data.load_after_hydro(:,t), array_thermo);
  end
  
  
  
  for mg = 1 : handles.config.MG
    handles.data.area{mg}.p_thermo = zeros(handles.data.area{mg}.PP_thermo,handles.config.T);
    handles.data.area{mg}.p_hydro = zeros(handles.data.area{mg}.PP_thermo,handles.config.T);
    for t = 1 : handles.config.T
      handles.data.area{mg}.p_thermo(:,t) = pgp{mg,t};
      handles.data.area{mg}.imports(:,t) = imports{t}(:,mg);
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      % load after trade - update
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      handles.data.load_after_trade(mg,t) = handles.data.load(mg,t) - sum(handles.data.area{mg}.imports(:,t));
      
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      % marketprice - update
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      MeritOrderInput = round(min([max([1,handles.data.load_after_trade(handles.config.mg,t)]),(handles.data.area{mg}.p_total_thermo_MAX)+1]));
      handles.data.area{handles.config.mg}.meritorder(1,MeritOrderInput);
      handles.data.marketprice(mg,t) = handles.data.area{handles.config.mg}.meritorder(1,MeritOrderInput);
    end


  end
  
  handles.config.status.imex = true;
  disp('Im- & exports optimized');

else
  disp('integrate SOLVER of IBM. open directory "scripts" to integrate.');
end


clear pgp imports;