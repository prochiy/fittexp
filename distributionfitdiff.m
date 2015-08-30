function varargout = distributionfitdiff(varargin)
% DISTRIBUTIONFITDIFF M-file for distributionfitdiff.fig
%      DISTRIBUTIONFITDIFF, by itself, creates a new DISTRIBUTIONFITDIFF or raises the existing
%      singleton*.
%
%      H = DISTRIBUTIONFITDIFF returns the handle to a new DISTRIBUTIONFITDIFF or the handle to
%      the existing singleton*.
%
%      DISTRIBUTIONFITDIFF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISTRIBUTIONFITDIFF.M with the given input arguments.
%
%      DISTRIBUTIONFITDIFF('Property','Value',...) creates a new DISTRIBUTIONFITDIFF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before distributionfitdiff_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to distributionfitdiff_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help distributionfitdiff

% Last Modified by GUIDE v2.5 08-Nov-2010 22:19:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @distributionfitdiff_OpeningFcn, ...
                   'gui_OutputFcn',  @distributionfitdiff_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before distributionfitdiff is made visible.
function distributionfitdiff_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to distributionfitdiff (see VARARGIN)

% Choose default command line output for distributionfitdiff
handles.output = hObject;
global DiffNMR;
if isfield(DiffNMR,'NPoints')
    set(handles.edNumber,'String',fix(DiffNMR.NPoints/2))
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes distributionfitdiff wait for user response (see UIRESUME)
% uiwait(handles.distribution);


% --- Outputs from this function are returned to the command line.
function varargout = distributionfitdiff_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function btnFit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
%вычисление вектора коэффициентов диффузии в зависимости от типа шкалы
min=str2num(get(handles.edMin,'String'));
max=str2num(get(handles.edMax,'String'));

if get(handles.rbLaplace,'Value')==1
    Number=str2num(get(handles.edNumber,'String'));   
else   %Определение количества подгоняемых экспонент
    Number=fix(DiffNMR.NPoints/2);
    
end
if get(handles.rbLog,'Value')==1
    l=log10(max/min)/(Number-1);
    D=power(10,log10(min):l:log10(max))
else
    l=(max-min)/(Number-1);
    D=min:l:max;
end

%Определение матрицы К
g=DiffNMR.Qdecay{1}(:,1);
M=DiffNMR.Qdecay{1}(:,2);

for n=1:DiffNMR.NPoints
    for m=1:Number
        K(n,m)=exp(-D(m).*g(n));
    end
end

if get(handles.rbLSM,'Value')==1
    %Метод наименьших квадратов.
    F=inv(K'*K)*K'*M;
else
    %Метод обратного преобразования Лапласа
    [U,S,V]=svd(K,0);
    size(S);
    %F=V*inv(S)*U'*M;  %Суммируются все чтлены, что может привести к
    %значительным ошибкам
    Term=str2num(get(handles.edTerm,'String'));
    F=zeros(Number,1);
    for n=1:Term
        F=F+U(:,n)'*M/S(n,n)*V(:,n);
    end
end 

%Вывод результатов подгонки на график
x=DiffNMR.Qdecay{1}(1,1):DiffNMR.Qdecay{1}(end,1)/100:DiffNMR.Qdecay{1}(end,1);
y(1:length(x))=0;
for n=1:length(x)
    for m=1:Number
        y(n)=y(n)+F(m)*exp(-D(m).*x(n));
    end
end
hold on;
cla;
plot(x,y,'r-','Parent',DiffNMR.MainAxes)
%Вывод распределения на график
%Определение оси обцис
if get(handles.rbLog,'Value')==1
    l=log10(max/min)/(Number-1);
    D=power(10,log10(min):l:log10(max));
else
    l=(max-min)/(Number-1);
    D=min:l:max;
end
bar(D,F,'Parent',handles.axes1)
%Получение значений
%DiffNMR.X4=D;
%DiffNMR.Y4=F;
axis auto
if get(handles.rbALinear,'Value')==1
    set(handles.axes1,'XScale','Linear')
else
    set(handles.axes1,'XScale','Log')
end


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.distribution);




function edMin_Callback(hObject, eventdata, handles)
% hObject    handle to edMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edMin as text
%        str2double(get(hObject,'String')) returns contents of edMin as a double


% --- Executes during object creation, after setting all properties.
function edMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edMax_Callback(hObject, eventdata, handles)
% hObject    handle to edMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edMax as text
%        str2double(get(hObject,'String')) returns contents of edMax as a double


% --- Executes during object creation, after setting all properties.
function edMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function edNumber_Callback(hObject, eventdata, handles)
% hObject    handle to edNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edNumber as text
%        str2double(get(hObject,'String')) returns contents of edNumber as a double


% --- Executes during object creation, after setting all properties.
function edNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edTerm_Callback(hObject, eventdata, handles)
% hObject    handle to edTerm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTerm as text
%        str2double(get(hObject,'String')) returns contents of edTerm as a double


% --- Executes during object creation, after setting all properties.
function edTerm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edTerm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rbALog_Callback(hObject, eventdata, handles)
% hObject    handle to edTerm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTerm as text
%        str2double(get(hObject,'String')) returns contents of edTerm as a double
if get(handles.rbALog,'Value')==1
    set(handles.axes1,'XScale','Log')
else
    set(handles.axes1,'XScale','Linear')
end



function rbALinear_Callback(hObject, eventdata, handles)
% hObject    handle to edTerm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTerm as text
%        str2double(get(hObject,'String')) returns contents of edTerm as a double
if get(handles.rbALinear,'Value')==1
    set(handles.axes1,'XScale','Linear')
else
    set(handles.axes1,'XScale','Log')
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
get(gcf,'SelectionType')
if strcmp(get(gcf,'SelectionType'),'open')
    %global DiffNMR;
    h=figure();
    CopyAxes=copyobj(handles.axes1,h);
    set(CopyAxes,'Units','normalized','Position',[0.13 0.11 0.775 0.815],'ButtonDownFcn','')
    set(get(CopyAxes,'Children'),'ButtonDownFcn','')
    %DiffNMR.MainAxes = handles.axes1;
end


