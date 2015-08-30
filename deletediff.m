function deletediff(hObject,eventdata)
%данная функция производит удаление точек диффузионного затухания (или спектров)
global DiffNMR;

if strcmp(DiffNMR.Mode,'spec')
    DiffNMR.newspec.Spectrum(DiffNMR.NSpec,:)=[]; % а может и не надо удалять спектры из newspec
    DiffNMR.newspec.AxisTD1(DiffNMR.NSpec)=[];
    DiffNMR.DiffDecay(DiffNMR.NSpec,:)=[];
    if DiffNMR.NSpec==DiffNMR.size2last
      DiffNMR.NSpec=DiffNMR.NSpec-1;
    end
    DiffNMR.size2last=DiffNMR.size2last-1;
    DiffNMR.Spec1D=DiffNMR.newspec.Spectrum(DiffNMR.NSpec,:);
    DiffNMR.Axis1D=DiffNMR.newspec.AxisTD2;
    cla;
    plot(DiffNMR.Axis1D,real(DiffNMR.Spec1D),'-b')
elseif strcmp(DiffNMR.Mode,'diff')
    if DiffNMR.Step ~= 1;
        disp('Удаление точек возможно только на первом шаге подгонки')
        beep
        return
    end
    %handles=guidata(DiffNMR.MainAxes);
    Data=get(DiffNMR.gco,'Xdata');
    Index=find(DiffNMR.Qdecay{1}(:,1) >= Data,1,'first');
    DiffNMR.DiffDecay(Index,:)=[];
    DiffNMR.Qdecay{1}(Index,:)=[];
    plotdiff(gcbo,[],guidata(DiffNMR.MainAxes),'first')
    
    DiffNMR.newspec.Spectrum(Index,:)=[];
    DiffNMR.newspec.AxisTD1(Index)=[];
    if Index==DiffNMR.size2last
      DiffNMR.NSpec=DiffNMR.NSpec-1;
    end
    DiffNMR.size2last=DiffNMR.size2last-1;
    DiffNMR.NPoints=DiffNMR.NPoints-1;
end

