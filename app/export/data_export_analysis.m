disp('Exporting data for analysis');
header = {'$Bez. SO'	'Bezeichner'	'Langname'	'$UKZ'	'$Kurzname'	'$Un' 'P min' 'P max'};
for t = 1 : handles.config.T
  temp = ['NNF_' num2str(t)];
  header = [header temp];
end

mkdir([handles.config.path.output '\' string_date '-KEP']);

content = [];
for mg=1:handles.config.MG    
    % fetching data for thermo
    park_thermo =  handles.data.area{mg}.park_thermo;
    pgp_normal = num2cell(zeros(handles.data.area{mg}.PP_thermo,8+handles.config.T)); % Initialisieren des pgp
    for kw = 1 : handles.data.area{mg}.PP_thermo
        pgp_normal{kw,4} = handles.config.area{mg,2};
        id = park_thermo(kw,1);
        index=find(cell2mat(handles.data.area{mg}.id)==id,2);
        pgp_normal{kw,1} = handles.data.area{mg}.bezSO{index};
        pgp_normal{kw,2} = handles.data.area{mg}.bezeichner{index};
        pgp_normal{kw,3} = handles.data.area{mg}.langname{index};
        pgp_normal{kw,5} = handles.data.area{mg}.kurzname{index};
        pgp_normal{kw,6} = handles.data.area{mg}.Un{index};
        pgp_normal{kw,7} = handles.data.area{mg}.Pmin{index};
        pgp_normal{kw,8} = handles.data.area{mg}.Pmax{index};
        for t = 1 : handles.config.T
          pgp_normal{kw,8+t} = handles.data.area{mg}.p_thermo(kw,t);
        end
    end
    
    % fetching data for hydro
    park_thermo =  handles.data.area{mg}.park_hydro;
    pgp_hydro = num2cell(zeros(handles.data.area{mg}.PP_hydro,8+handles.config.T)); % Initialisieren des pgp
    for kw = 1 : handles.data.area{mg}.PP_hydro
        pgp_hydro{kw,4} = handles.config.area{mg,2};
        id = park_thermo(kw,1);
        index=find(cell2mat(handles.data.area{mg}.id)==id,2);
        pgp_hydro{kw,1} = handles.data.area{mg}.bezSO{index};
        pgp_hydro{kw,2} = handles.data.area{mg}.bezeichner{index};
        pgp_hydro{kw,3} = handles.data.area{mg}.langname{index};
        pgp_hydro{kw,5} = handles.data.area{mg}.kurzname{index};
        pgp_hydro{kw,6} = handles.data.area{mg}.Un{index};
        pgp_hydro{kw,7} = handles.data.area{mg}.Pmin{index};
        pgp_hydro{kw,8} = handles.data.area{mg}.Pmax{index};
        for t = 1 : handles.config.T
         pgp_hydro{kw,8+t} = handles.data.area{mg}.p_hydro(kw,t);
        end
    end
    
    content = [content; pgp_normal;pgp_hydro];
        
end
content = [header;content];
string_foldername = [handles.config.path.output '\' string_date '-KEP'];
string_filename = [string_foldername '\E001_u_E003_alle_NNF.csv'];
cellwrite_german(string_filename,content);

disp('data exported for analysis');