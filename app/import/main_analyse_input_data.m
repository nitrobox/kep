%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Checking the input data for wrong entries like nan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Checks inputdata for wrong values
T = handles.config.T;
MG = handles.config.MG;

if size(handles.data.load,1)~=MG
  disp('input data wrong. Check demand for number of rows.');
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Checking if it is possible to supply the load
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% shorten and init used variables
load = handles.data.load;
p_total_thermo_max = zeros(handles.config.MG,handles.config.T);
p_total_hydro_max = zeros(handles.config.MG,handles.config.T);
p_total_import_max = zeros(handles.config.MG,handles.config.T);
% fill matrix for maximums of thermo, hydro and import
for mg = 1 : handles.config.MG
  p_total_thermo_max(mg,:) = ones(1,handles.config.T)*handles.data.area{mg}.p_total_thermo_MAX;
  p_total_hydro_max(mg,:) = ones(1,handles.config.T)*handles.data.area{mg}.p_total_hydro_MAX;
  p_total_import_max(mg,:) = ones(1,handles.config.T)*sum(cell2mat(handles.data.ntc(:,mg)));
end


% TEST A: Are the Thermo Powerplants enough to supply?
X = load - p_total_thermo_max;
X(X<0)=0;
if (sum(sum(X,2))>0) 
  disp('Thermo powerplants are not enough to supply.') 
  % TEST B: Are the Thermo Powerplants & Imports enough to supply?
  Y = X - p_total_import_max;
  Y(Y<0)=0;
  if (sum(sum(Y,2))>0) 
    disp('Thermo powerplants are not enough to supply even with imports from other countries.') 
    % TEST C: Are the Thermo & Hydro Powerplants & Imports enough to supply?
    Z = Y - p_total_hydro_max;
    Z(Z<0)=0;
    if (sum(sum(Z,2))>0) 
      disp('Thermo & hydro powerplants are not enough to supply even with imports from other countries. Probelm is impossible to solve.') 
    end;  
  end;  
end;





