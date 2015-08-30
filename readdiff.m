% Программа для чтения данных по диффузии из брюкеровского файла обработки
% диффузионного элксперимента

global DiffNMR;
DiffNMR.Mode = 'diff';
set(handles.mDisplayDifferens,'Checked','on')
set(handles.axes2,'Visible','on')
guidata(hObject,handles)

if isfield(DiffNMR,'PathName')
    if ~isempty(DiffNMR.PathName)
        [DiffNMR.FileName,DiffNMR.PathName] = uigetfile('*.txt', 'Select Bruker File SIMFIT RESULTS to Open',...
            [DiffNMR.PathName filesep 'ct1t2.txt']);
    else
        [DiffNMR.FileName,DiffNMR.PathName] = uigetfile('*.txt', 'Select Bruker File SIMFIT RESULTS to Open',...
            'ct1t2.txt');
    end
else
    [DiffNMR.FileName,DiffNMR.PathName] = uigetfile('*.txt', 'Select Bruker File SIMFIT RESULTS to Open',...
            'ct1t2.txt');
end

%Следующие 25 строк взяты из функции ReadParameterFile тулбокса matNMR
fp = fopen([DiffNMR.PathName filesep DiffNMR.FileName], 'r');
if (fp == -1)
  disp(['matNMR ERROR: couldn''t open parameter file "' DiffNMR.FileName '". Aborting ...']);
  DiffNMR.SimFitResult = [];
  return
end

DiffNMR.SimFitResult = fgetl(fp);

while 1
  tmp = fgetl(fp);
  if ischar(tmp)
    tmp = deblank(tmp);
    if (length(tmp)<80)		%avoid endless lines and thus and memory time loss
      %tmp([findstr(tmp, '#') findstr(tmp, '$')]) = '';
      DiffNMR.SimFitResult = str2mat(DiffNMR.SimFitResult, tmp);
    end
  else
    break
  end
end

fclose(fp);

DiffNMR.SimFitResult=cellstr(DiffNMR.SimFitResult);

%следующие 6 строк считывают колличество шагов градиента
tmp = strfind(DiffNMR.SimFitResult, 'points for');
for i=1:size(tmp,1)
    if ~isempty(tmp{i,1})
        DiffNMR.NPoints=str2num(DiffNMR.SimFitResult{i,1}(1:tmp{i,1}-1));
    end
end

%считывание значений Gamma, Little Delta, Big Delta
tmp = strfind(DiffNMR.SimFitResult, 'Gamma');
for i=1:size(tmp,1)
    if ~isempty(tmp{i,1})
        DiffNMR.Gamma=str2num(DiffNMR.SimFitResult{i,1}(19:28));
        DiffNMR.LittleDelta=str2num(DiffNMR.SimFitResult{i+1,1}(19:27))*1e-3;
        DiffNMR.BigDelta=str2num(DiffNMR.SimFitResult{i+2,1}(19:27))*1e-3;
    end
end

%следующие строки считывают массив данных диффузионного затухания: первый
%столбец номер точки, второй столбец величина градиента, третий столбец
%экспериментальное значение амплитуды, четвертый столбец подогнанное
%значение, пятый столбец разница между подгонным значением и
%экспериментальным
clear tmp;
tmp = strfind(DiffNMR.SimFitResult, 'Point     Gradient       Expt          Calc       Difference');
for i=1:size(tmp,1)
    if ~isempty(tmp{i,1})
        for ii=i+2:i+1+DiffNMR.NPoints
           DiffNMR.DiffDecay(ii-i-1,:) = str2num(DiffNMR.SimFitResult{ii,1});
        end
    end
end


set(DiffNMR.MainFigure,'Name',['Fittexp ' DiffNMR.PathName DiffNMR.FileName])

DiffNMR.Step=1;
DiffNMR.Qdecay=[];
%DiffNMR.Qdecay{DiffNMR.Step}(1:DiffNMR.NPoints,[1 2]) =DiffNMR.DiffDecay(1:DiffNMR.NPoints,[2 3]);
DiffNMR.B=1e+4*power(2*pi*DiffNMR.Gamma*DiffNMR.LittleDelta,2)*(DiffNMR.BigDelta-DiffNMR.LittleDelta/3);
DiffNMR.Qdecay{DiffNMR.Step}(:,1)=power(DiffNMR.DiffDecay(1:DiffNMR.NPoints,2),2)*DiffNMR.B;
DiffNMR.Qdecay{DiffNMR.Step}(:,2)=DiffNMR.DiffDecay(1:DiffNMR.NPoints,3);

handles.first=1;
guidata(hObject,handles);
plotdiff(gcbo,[],guidata(gcbo),'first');

