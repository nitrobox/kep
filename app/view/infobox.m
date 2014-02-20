    set(handles.info,'String',[]);
    info{1} = ['Infos: '];
    info = [info;['-----------------------------']];
    info = [info;['Gesamt:']];
    info = [info;['-----------------------------']];
    info = [info;['MG: ' num2str(handles.config.MG)]];
    info = [info;['T : ' num2str(handles.config.T)]];
    info = [info;['P_L_ges(t=' num2str(handles.config.t) '): ' num2str(sum(handles.data.load(:,handles.config.t))/1000)]];
%     if handles.config.status.imex
%       
%       E001_total = 0;
%       E003_total = 0;
%       for mg = 1:handles.config.MG
%         E001_total = sum(handles.data.pgp{mg,handles.config.t}) + E001_total;
%         E003_total = handles.data.P_hydro_total(mg,1) + E003_total;
%       end
%     info = [info;['P_E001:' num2str(E001_total/1000) ' GW']];
%     info = [info;['P_E003:' num2str(E003_total /1000) ' GW']];
%     info = [info;['P_E1+P_E3:' num2str((E001_total+E003_total)/1000) ' GW']];
%     
%     info = [info;['Über:' num2str((handles.data.P_hydro_total(handles.config.mg,1)+sum(handles.data.pgp{handles.config.mg,handles.config.t}))/1000-handles.data.load_balance(handles.config.mg,handles.config.t)/1000) ' GW']];
%     end
    info = [info;['-----------------------------']];
    info = [info;['Marktgebiet ' handles.config.area{handles.config.mg,2}] ':'];
    info = [info;['-----------------------------']];
    info = [info;['Pges      : ' num2str(handles.data.area{handles.config.mg}.p_total_thermo_MAX/1000) ' GW']];
    info = [info;['Spizenlast: ' num2str(max(handles.data.load(handles.config.mg,:))/1000) ' GW']];
    info = [info;['Grundlast : ' num2str(min(handles.data.load(handles.config.mg,:))/1000) ' GW']];
    info = [info;['Energie   : ' num2str(sum(handles.data.load(handles.config.mg,:))/1000000) ' TWh']];
    info = [info;['-----------------------------']];
    info = [info;['Zeitpunkt t = ' num2str(handles.config.t)] ':'];
    info = [info;['-----------------------------']];
    temp = handles.data.area{handles.config.mg}.imports(:,handles.config.t);
    
    temp(temp <0)=0;
    imports = temp;
    temp(temp >0)=0;
    temp = -temp;
    exports = temp;

    info = [info;['Pres   :' num2str(handles.data.load(handles.config.mg,handles.config.t)/1000) ' GW']];
    info = [info;['Pexport:' num2str(sum(exports)/1000) ' GW']];
    info = [info;['Pimport:' num2str(sum(imports)/1000) ' GW']];
% %     info = [info;['Psaldo :' num2str(handles.data.load_balance(handles.config.mg,handles.config.t)/1000) ' GW']];
%     if handles.config.status.imex
% %     info = [info;['P_E001:' num2str(sum(handles.data.pgp{handles.config.mg,handles.config.t})/1000) ' GW']];
% %     info = [info;['P_E003:' num2str(handles.data.P_hydro_total(handles.config.mg,1)/1000) ' GW']];
% %     info = [info;['P_E1+P_E3:' num2str((handles.data.P_hydro_total(handles.config.mg,1)+sum(handles.data.pgp{handles.config.mg,handles.config.t}))/1000) ' GW']];
%     
% %     info = [info;['Über:' num2str((handles.data.P_hydro_total(handles.config.mg,1)+sum(handles.data.pgp{handles.config.mg,handles.config.t}))/1000-handles.data.load_balance(handles.config.mg,handles.config.t)/1000) ' GW']];
%     end
%     if handles.config.status.mp 
%     MeritOrderInput = min([max([1,handles.data.load_balance(handles.config.mg,handles.config.t)]),(handles.data.area{handles.config.mg}.Pges)+1]);
%     mp = handles.data.area{handles.config.mg}.meritorder(MeritOrderInput);
%     info = [info;['mp     :' num2str(mp) ' €']]; 
%     end; 
    
    set(handles.info,'String',info);