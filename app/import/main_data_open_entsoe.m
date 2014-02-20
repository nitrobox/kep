disp(' entsoe demand ...');
filename_demand = 'entsoe_demand.xls';
 [~,~,load]=xlsread([handles.config.path.input '/' filename_demand]);
 handles.data.T = 744;
 handles.config.MG = 10;
 handles.data.load = zeros(handles.config.MG,handles.data.T);
 for mg = 1 : handles.config.MG
   UKZ = handles.config.area{mg,3};
   line = 11;
   day = 0;
   while line<=size(load,1)
     if strcmp(load{line,1},UKZ)
       left = (day*24+1);
       right = (day*24+24);
       content =  cell2mat(load(line,3:26));
       handles.data.demand(mg,left:right) = content;   
       day = day + 1;
     end
     line = line + 1;
   end
   if strcmp(UKZ,'DK')
     disp('load of denmark is cutted to the half and distributed to east and west');
     handles.data.demand = handles.data.demand/2;
   end
   
   
 end;