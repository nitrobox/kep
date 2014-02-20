%NEW VERSION
if isfield(handles.config,'MG')&& isfield(handles.config,'T')
  % shorting the variables for easy use
  MG = handles.config.MG;
  T = handles.config.T;
  handles.data.co2price            = 12; % MUSS NOCH EINSTELLBAR WERDEN, BEIM EINLESEN

  for mg = 1 : MG
    % input
    handles.data.area{mg}.park_thermo = []; % KWx
    handles.data.area{mg}.park_hydro = [];

    % description of powerplantpark
    handles.data.area{mg}.bezSO       = '';
    handles.data.area{mg}.bezeichner  = '';
    handles.data.area{mg}.langname    = '';
    handles.data.area{mg}.Un          = '';
    handles.data.area{mg}.kurzname    = '';
    handles.data.area{mg}.id          = '';
    handles.data.area{mg}.Pmin        = '';
    handles.data.area{mg}.Pmax        = '';

    % NTC-Values
    handles.data.area{mg}.ntc_max_import = zeros(MG,1);


    % constant
    handles.data.area{mg}.PP = 0; % Number of all powerplants
    handles.data.area{mg}.PP_thermo = 0; % Number of thermo powerplants
    handles.data.area{mg}.PP_hydro = 0; % Number of hydro powerplants
    handles.data.area{mg}.p_total_MAX = 0;
    handles.data.area{mg}.p_total_thermo_MAX = 0;
    handles.data.area{mg}.p_total_hydro_MAX = [];

    % Power
    PP_thermo = handles.data.area{mg}.PP_thermo;
    PP_hydro = handles.data.area{mg}.PP_hydro;
    handles.data.area{mg}.p_thermo = zeros(PP_thermo,T);% Power-generation-plan of thermo
    handles.data.area{mg}.p_hydro = zeros(PP_hydro,T);% Power-generation-plan of hydro
    handles.data.area{mg}.p_total_thermo = zeros(1,T); % Total amount of generated power by thermo powerplants
    handles.data.area{mg}.p_total_hydro = zeros(1,T); % Total amount of generated power by thermo powerplants
    handles.data.area{mg}.p_total = handles.data.area{mg}.p_total_thermo + handles.data.area{mg}.p_total_hydro;
    
    % storage
    handles.data.area{mg}.storage = zeros(PP_hydro,T);  



    % imports
    handles.data.area{mg}.imports = zeros(MG,T);

    % generation costs
    handles.data.area{mg}.meritorder = []; % 1xPges+?
    handles.data.area{mg}.costingcurve = []; %[0 cumsum_merit Order]


  end

else
  error('Number of markets or timesteps not known.');
end

handles.data.ntc = zeros(MG,MG);

handles.data.load = zeros(MG,T);
handles.data.load_after_hydro = zeros(MG,T);
handles.data.load_after_trade = zeros(MG,T);

handles.data.marketprice = zeros(MG,T);

    % Load
    %%%%handles.data.area{mg}.load_res = zeros(1,T);
    
        % load after
%     handles.data.area{mg}.load_after_hydro = zeros(1,T);
%     handles.data.area{mg}.load_after_trade = zeros(1,T);
    
    
% OLD VERSION
  % Init data
    % handles.data.ntc = zeros(MG,MG);
%     handles.data.ntc = zeros(MG,MG); % BUILD OF all ntc_max_imports vektors by [handles.data.area{mg}.ntc_max_import(1) handles.data.area{mg}.ntc_max_import(2) handles.data.area{mg}.ntc_max_import(3) ...]
%     
%     % handles.data.demand = zeros(MG,T);
%     handles.data.demand = zeros(MG,T);
%     handles.data.demand_after_hydro = handles.data.demand;
%     handles.data.load_balance = handles.data.demand;
%     handles.data.load_final = handles.data.demand;
%     handles.data.P_hydro_total = zeros(MG,1);
%     handles.data.exports = cell(1,T);
%     handles.data.pgp = cell(MG,T);
% 
%     for t = 1 : T
%        handles.data.exports{1,t} = zeros(MG);
%     end

