function load = open_load(MG,T,path,filename)
% input
  % path : string : path to the file e.g: "data/input"
  % filename : string : name of the demand xlsx-file with e.g: "demand.xlsx"
  
% output
  % demand : 

disp(' residual ...');
 [~,~,load]=xlsread([path '/' filename]);
 load = load(2:end,2:end);
 for i=1:size(load,1)
  for j = 1: size(load,2)
     % demand{i,j} = strrep(demand{i,j},'.',',');
    if strcmp(class(load{i,j}),'double')
    else
      load{i,j} = 0;
      disp(['Please check the Input data of the load. They should be of type double. MG=' num2str(i) ' t=' num2str(j) ' It is replaced by 0.'])
    end
  end
 end
 load = cell2mat(load);

 load = load(1:MG,1:T);
 
end
    
