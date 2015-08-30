%Эта функция проводит интегрирование либо только реальной части или обеих в
%зависимости от того с каким флагом была вызвана функция
function integrationdiff(hObject,eventdata,handles,flag)
global DiffNMR;

if DiffNMR.size2last==1
    disp('Это одномерный спектр, диффузионное затухание от него не построишь')
    beep;
    return
end

if strcmp(DiffNMR.Mode,'spec')
    DiffNMR.Mode = 'integration';
    DiffNMR.Integration = flag;
    DiffNMR.NPoints = length(DiffNMR.newspec.AxisTD1);
    DiffNMR.LimitA = [];
    DiffNMR.LimitB = [];
    DiffNMR.IndexA = [];
    DiffNMR.IndexB = [];
    DiffNMR.DiffDecay = [];
    return
end

if and(strcmp(flag,'real'),~isempty(DiffNMR.LimitB))
    a=DiffNMR.IndexA;
    b=DiffNMR.IndexB;
    for ii=1:DiffNMR.NPoints
        DiffNMR.DiffDecay(ii,1)=ii;
        DiffNMR.DiffDecay(ii,2)=DiffNMR.newspec.AxisTD1(ii);
        if a<b
            DiffNMR.DiffDecay(ii,3)=sum(real(DiffNMR.newspec.Spectrum(ii,a:b)));
        else
            DiffNMR.DiffDecay(ii,3)=sum(real(DiffNMR.newspec.Spectrum(ii,b:a)));
        end
    end
    DiffNMR.DiffDecay(:,3) = DiffNMR.DiffDecay(:,3)./DiffNMR.DiffDecay(1,3);
    aaa(gcbo,[],guidata(gcbo));
    return
elseif and(strcmp(flag,'both'),~isempty(DiffNMR.LimitB))
    a=DiffNMR.IndexA;
    b=DiffNMR.IndexB;
    for ii=1:DiffNMR.size2last
        DiffNMR.DiffDecay(ii,1)=ii;
        DiffNMR.DiffDecay(ii,2)=DiffNMR.newspec.Axis1D(ii);
        if a<b
            DiffNMR.DiffDecay(ii,3)=sum(abs(DiffNMR.newspec.Spectrum(ii,a:b)));
        else
            DiffNMR.DiffDecay(ii,3)=sum(abs(DiffNMR.newspec.Spectrum(ii,b:a)));
        end
    end
    DiffNMR.DiffDecay(:,3) = DiffNMR.DiffDecay(:,3)./DiffNMR.DiffDecay(1,3);
    aaa(gcbo,[],guidata(gcbo));
    return
%определяем пределы интегрирования
elseif strcmp(flag,'limits')
   %strcmp(flag,'limits')
   if ishandle(handles.Limits)
       delete(handles.Limits)
   end
   x=get(DiffNMR.MainAxes,'CurrentPoint');
   handles.Limits=plot([x(1,1) x(1,1)],handles.CurrentAxisYlim,'r-',...
       'ButtonDownFcn',{'integrationdiff',guidata(DiffNMR.MainAxes),'click'});
   guidata(hObject,handles)
   return
elseif strcmp(flag,'click')
    x=get(DiffNMR.MainAxes,'CurrentPoint');
    if ~((DiffNMR.Axis1D(1)<x(1,1))&&(x(1,1)<DiffNMR.Axis1D(end)))
        disp('Пределы интегрирования должны лежать в пределах спектра')
        beep;
        return
    end
    if isempty(DiffNMR.LimitA)
        DiffNMR.IndexA=find(DiffNMR.Axis1D>x(1,1),1,'first');
        DiffNMR.LimitA=x(1,1);
        plot([x(1,1) x(1,1)],handles.CurrentAxisYlim,'r-')
        return
    elseif isempty(DiffNMR.LimitB)
        DiffNMR.IndexB=find(DiffNMR.Axis1D>x(1,1),1,'first');
        plot([x(1,1) x(1,1)],handles.CurrentAxisYlim,'r-')
        DiffNMR.LimitB=x(1,1);
        integrationdiff(hObject,[],handles,DiffNMR.Integration)
        return
    end
    
else
    %disp('Вы вызвали функцию integrationdiff с каким-то не тем флагом')
    %beep
    return
end

function aaa(hObject,eventdata,handles)
global DiffNMR;
DiffNMR.Step=1;
DiffNMR.Qdecay=[];
%DiffNMR.Qdecay{DiffNMR.Step}(1:DiffNMR.NPoints,[1 2]) =DiffNMR.DiffDecay(1:DiffNMR.NPoints,[2 3]);
DiffNMR.B=1e+4*power(2*pi*DiffNMR.Gamma*DiffNMR.LittleDelta,2)*(DiffNMR.BigDelta-DiffNMR.LittleDelta/3);
DiffNMR.Qdecay{DiffNMR.Step}(:,1)=power(DiffNMR.DiffDecay(1:DiffNMR.NPoints,2),2)*DiffNMR.B;
DiffNMR.Qdecay{DiffNMR.Step}(:,2)=DiffNMR.DiffDecay(1:DiffNMR.NPoints,3);


handles.first=1;
set(handles.axes2,'Visible','on')
guidata(hObject,handles);
DiffNMR.Mode = 'diff';
plotdiff(DiffNMR.MainAxes,[],guidata(DiffNMR.MainAxes),'first');

set(handles.edCoefDiff1,'String','CoefDiff'); %этот блок отвечает за 
set(handles.edCoef1,'String','coef');      %обнуление полей данных 
set(handles.edCoefDiff2,'String','CoefDiff');
set(handles.edCoef2,'String','coef');
set(handles.edCoefDiff3,'String','CoefDiff');
set(handles.edCoef3,'String','coef');
set(handles.edCoefDiff4,'String','CoefDiff');
set(handles.edCoef4,'String','coef');



%Нижеследующий код производит заполнение полей edit данными считанными из
%файла оброботки диффузиноного затухания.
set(handles.edBigdelta,'String',num2str(DiffNMR.BigDelta*1e+3));
set(handles.edLittledelta,'String',num2str(DiffNMR.LittleDelta*1e+3));
switch round(DiffNMR.Gamma);   %Hz/G
    case 4258           %1H
        set(handles.pmNucleus,'Value',2);
    case 654            %2D 
        set(handles.pmNucleus,'Value',3);
    case 1655           %7Li
        set(handles.pmNucleus,'Value',4);
    case 1366           %11B
        set(handles.pmNucleus,'Value',5);
    case 4005           %19F
        set(handles.pmNucleus,'Value',6);
end


