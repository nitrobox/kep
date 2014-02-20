disp('Calculating hydro power generation');
for mg = 1 : handles.config.MG % handles.daten.MG
  disp([' for "' handles.config.area{mg,1} '" with ' num2str(handles.data.area{mg}.PP_hydro) ' hydro powerplants']);
  PP = size(handles.data.area{mg}.park_hydro,1);
  handles.data.area{mg}.p_hydro = zeros(PP,handles.config.T);
  handles.data.area{mg}.storage = zeros(PP,handles.config.T);
  for kw = 1 : handles.data.area{mg}.PP_hydro
    mp = handles.data.load_after_hydro(mg,:);
    eta = handles.data.area{mg}.park_hydro(kw,2);
    Pmin = handles.data.area{mg}.park_hydro(kw,3);
    Pmax = handles.data.area{mg}.park_hydro(kw,4);
    Emax = 5*Pmax;
    e1 = 0.5*Emax;
    eT = e1; % SPÄTER ABHÄNGIG MACHEN VON ANDEREN BERECHNUNGEN
    if (Pmax~=0)&&(Pmin~=0)
      [handles.data.area{mg}.p_hydro(kw,:), handles.data.area{mg}.storage(kw,:)] = opt_hydro(mp,eta,Pmin,Pmax,Emax, e1, eT);
      for t = 1 : handles.config.T
        % calculate p_total_hydro
        handles.data.area{mg}.p_total_hydro(1,t) = sum(handles.data.area{mg}.p_hydro(:,t));
        handles.data.load_after_hydro(mg,t) = handles.data.load(mg,t) - handles.data.area{mg}.p_total_hydro(1,t);
      end
      
    else
      handles.data.area{mg}.p_hydro(kw,:) = zeros(1,size(mp,2));
      handles.data.area{mg}.storage(kw,:) = zeros(1,size(mp,2));
      if Pmax==0 disp(['Pmax = 0 für MG=' num2str(mg) ' and kw_hydro=' num2str(kw)]); end
      if Pmin==0 disp(['Pmin = 0 für MG=' num2str(mg) ' and kw_hydro=' num2str(kw)]); end
    end

    tempString = get(handles.popup_plot,'String');
    tempString{5} =  'Füllspeicherstände';
    set(handles.popup_plot,'String',tempString);
  end
end
disp('Calculation of hydro power generation finished.');