%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NTC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(handles.tbl_ntc,'Data',handles.data.ntc);
set(handles.tbl_ntc,'ColumnName',handles.config.area(1:handles.config.MG,2));
set(handles.tbl_ntc,'RowName',handles.config.area(1:handles.config.MG,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imports
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if handles.config.status.imex == true
   set(handles.tbl_export,'Data',round(handles.data.area{handles.config.mg}.imports));
end
set(handles.tbl_export,'RowName',handles.config.area(1:handles.config.MG,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% powerplants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% menu
set(handles.popup_marktgebiet,'String',handles.config.area(1:handles.config.MG,1));

% input
park = [];

if get(handles.check_thermo,'Value')==1
park = [park; handles.data.area{handles.config.mg}.park_thermo];
end
if get(handles.check_hydro,'Value')==1
park = [park;handles.data.area{handles.config.mg}.park_hydro];
end
set(handles.tbl_kwpark,'Data',[park]);
set(handles.tbl_kwpark,'ColumnName',{'id' 'kvar/eta' 'Pmin' 'Pmax' 'E00'});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold off;
cla; % Clear all plots
hold on;
tempString = get(handles.popup_plot,'String');
choice = tempString{get(handles.popup_plot,'Value')};
input_legend = cell(0);
switch choice
  case 'Lastverläufe'
      % Load
      if get(handles.check_load,'Value')==1
        X = 1:1:handles.config.T;
        D = handles.data.load(handles.config.mg,:);
        plot(D,'Color','k'); 
        input_legend = [input_legend 'Residuallast'];
      end
      if get(handles.check_load_after_trade,'Value')==1
        X = 1:1:handles.config.T;
        D = handles.data.load_after_trade(handles.config.mg,:);
        plot(D,'Color','b'); 
        input_legend = [input_legend 'Last nach Handel'];
      end
      if get(handles.check_load_after_hydro,'Value')==1
        X = 1:1:handles.config.T;
        D = handles.data.load_after_hydro(handles.config.mg,:);
        plot(D,'Color','r'); 
        input_legend = [input_legend 'Last nach PS-Einsatz'];
      end
      if get(handles.check_marketprice,'Value')==1              
        X = 1:1:handles.config.T;
        D = handles.data.marketprice(handles.config.mg,:);
        plot(X,D,'Color','g');
        input_legend = [input_legend 'Marktpreis'];
      end
      legend(input_legend);
      axis auto
      hold off
      
  % merit order  
  case 'Merit Order'
      Y = handles.data.area{handles.config.mg}.meritorder;
      plot(Y)
      axis ([0 size(Y,2)+10 0 50]);
  % costingcurve    
  case 'SEK-Kurve'
      Y = handles.data.area{handles.config.mg}.costingcurve;
      plot(Y)
      axis auto
  
  % hydro storage
  case 'Füllspeicherstände'
      X = 1:1:handles.config.T;
      Y = sum(handles.data.area{handles.config.mg}.storage);
      plot(Y)
      axis ([1 max(X) -10 max(Y)+300]);
      
  case 'Marktpreis'
      % Marktpreise t
      X = 1:1:handles.config.T;
      Y = X;
      for t = 1 : handles.config.T
          Pges = handles.data.area{handles.config.mg}.p_total_thermo_MAX;
          MeritOrderInput = round(min([max([1,handles.data.load_after_trade(handles.config.mg,t)]),(Pges)+1]));
          testing = handles.config.mg;
          b = handles.data.area{testing};
         Y(t) = b.meritorder(1,MeritOrderInput);
      end

      % bestimme Y-Abschnitt
      Ymax = handles.config.pricecap+10;
      plot(X,Y)
      axis([1 handles.config.T 0 120]);

  otherwise
     disp('Fehler im plot Menue');

end
    

    
    % Popupmenu der Exportmatrix aktualisieren
%         temp = cell(handles.config.T,1);
%         for t=1:handles.config.T
%             temp{t,1} = num2str(t);
%         end
%         set(handles.popup_export,'String',temp);
    
    % info
    infobox;
 
    guidata(hObject,handles);