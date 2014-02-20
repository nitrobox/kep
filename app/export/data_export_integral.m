disp('exporting data for integral');

  integral_header = {'CEinspeisung' '' '' '' '' '' '';'$Bez. SO'	'$UKZ SO'	'$Kurzname'	'$Un' 'P min' 'P0' 'P max'; '' '' '' 'kV' 'MW' 'MW' 'MW'};
  trades_header = {'Nr.' 'Von' 'Nach' 'Pmax' 'NNF_Pmax' 'Pmin' 'NNF_Pmin'};
  trades = zeros(handles.config.MG*handles.config.MG,handles.config.T);



%für jeden NNF csv datei schreiben
for t=1:handles.config.T
  % create NNF file for integral
  content_integral = integral_header;
  
  % fetch data for each area
    for mg = 1 : handles.config.MG
      % for thermo powerplants
      park_thermo = handles.data.area{mg}.park_thermo;
      pgp_thermo = num2cell(zeros(handles.data.area{mg}.PP_thermo,size(integral_header,2))); % init power generation plan
      for kw = 1 : handles.data.area{mg}.PP_thermo
          pgp_thermo{kw,2} = handles.config.area{mg,2};
          id = park_thermo(kw,1);
          index=find(cell2mat(handles.data.area{mg}.id)==id,2);
          pgp_thermo{kw,1} = handles.data.area{mg}.bezSO{index}; % $Bez. SO
          pgp_thermo{kw,3} = handles.data.area{mg}.kurzname{index};
          pgp_thermo{kw,4} = handles.data.area{mg}.Un{index};
          pgp_thermo{kw,5} = handles.data.area{mg}.Pmin{index};
          pgp_thermo{kw,7} = handles.data.area{mg}.Pmax{index};
          pgp_thermo{kw,6} = handles.data.area{mg}.p_thermo(kw,t);

      end

      % for hydro powerplants
      park_thermo = handles.data.area{mg}.park_hydro;
      pgp_hydro = num2cell(zeros(handles.data.area{mg}.PP_hydro,size(integral_header,2))); % Initialisieren des pgp
      for kw = 1 : handles.data.area{mg}.PP_hydro
          pgp_hydro{kw,2} = handles.config.area{mg,2}; % $UKZ SO
          id = park_thermo(kw,1);
          index=find(cell2mat(handles.data.area{mg}.id)==id,2);
          pgp_hydro{kw,1} = handles.data.area{mg}.bezSO{index}; % $Bez. SO
          pgp_hydro{kw,3} = handles.data.area{mg}.kurzname{index};
          pgp_hydro{kw,4} = handles.data.area{mg}.Un{index};
          pgp_hydro{kw,5} = handles.data.area{mg}.Pmin{index};
          pgp_hydro{kw,7} = handles.data.area{mg}.Pmax{index};
          pgp_hydro{kw,6} = handles.data.area{mg}.p_hydro(kw,t);

      end

      content_integral = [content_integral;pgp_thermo;pgp_hydro];
    end
    string_foldername = [handles.config.path.output '\' string_date '-KEP' '\NNF-' num2str(t)];
    mkdir(string_foldername);
    string_filename = [string_foldername '\E001_u_E003.csv'];
    
    content_integral = [content_integral(1:3,:); sortcell(content_integral(4:end,:),[2 1])];



    % sum up the list
    pointer = 1; 
    while pointer<size(content_integral,1)
        if strcmp(content_integral{pointer,1},content_integral{pointer+1,1})&& strcmp(content_integral{pointer,4},content_integral{pointer+1,4})&& strcmp(content_integral{pointer,3},content_integral{pointer+1,3})
           content_integral{pointer,5} = min([content_integral{pointer,5} content_integral{pointer+1,5}]);
           content_integral{pointer,6} = content_integral{pointer,6}+content_integral{pointer+1,6};
           content_integral{pointer,7} = content_integral{pointer,7}+content_integral{pointer+1,7};
           content_integral(pointer+1,:) =[];
        else
            pointer = pointer+1;
        end
    end
    cellwrite_german(string_filename,content_integral);
    
    % expand header
    temp = ['NNF_' num2str(t)]; % IST HIER AUCH EINE INLINE LÖSUNG MÖGLICH?
    trades_header = [trades_header temp];
    
    % save exports
    row = 1;
    for i=1:handles.config.MG
        for j=1:handles.config.MG
           trades(row,t) = handles.data.area{j}.imports(i,t);
           row =row + 1;
        end        
    end
    
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create "Zeitreihen_Handel.csv"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create label
label = cell(handles.config.MG*handles.config.MG,7);
    row = 1;
    for i=1:handles.config.MG
        for j=1:handles.config.MG
           label{row,1} = row;                                           %Nr
           label{row,2} = handles.config.marktgebiet{i,2};                       %Von
           label{row,3} = handles.config.marktgebiet{j,2};                       %Nach
           [label{row,4}, label{row,5}] = max(trades(row,:));  %Pmax
           [label{row,6}, label{row,7}] = min(trades(row,:));  %Pmax
           row = row + 1;
        end        
    end

output_trades = [trades_header;label num2cell(trades)];
cellwrite_german([handles.config.path.output '\' string_date '-KEP' '\Zeitreihen_Handel.csv'],output_trades);

disp('data saved for integral');