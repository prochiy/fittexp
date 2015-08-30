function varargout = openworkspasespectrumdiff(varargin)
% OPENWORKSPASESPECTRUMDIFF M-file for openworkspasespectrumdiff.fig
%      OPENWORKSPASESPECTRUMDIFF, by itself, creates a new OPENWORKSPASESPECTRUMDIFF or raises the existing
%      singleton*.
%
%      H = OPENWORKSPASESPECTRUMDIFF returns the handle to a new OPENWORKSPASESPECTRUMDIFF or the handle to
%      the existing singleton*.
%
%      OPENWORKSPASESPECTRUMDIFF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPENWORKSPASESPECTRUMDIFF.M with the given input arguments.
%
%      OPENWORKSPASESPECTRUMDIFF('Property','Value',...) creates a new OPENWORKSPASESPECTRUMDIFF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before openworkspasespectrumdiff_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to openworkspasespectrumdiff_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help openworkspasespectrumdiff

% Last Modified by GUIDE v2.5 30-Sep-2010 00:16:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @openworkspasespectrumdiff_OpeningFcn, ...
                   'gui_OutputFcn',  @openworkspasespectrumdiff_OutputFcn, ...
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


% --- Executes just before openworkspasespectrumdiff is made visible.
function openworkspasespectrumdiff_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to openworkspasespectrumdiff (see VARARGIN)

% Choose default command line output for openworkspasespectrumdiff
handles.output = hObject;

global DiffNMR;
if isfield(DiffNMR,'VaribleName')
    set(handles.edName,'String',DiffNMR.VaribleName)
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes openworkspasespectrumdiff wait for user response (see UIRESUME)
% uiwait(handles.OpenWorkspaseSpectrum);


% --- Outputs from this function are returned to the command line.
function varargout = openworkspasespectrumdiff_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edName_Callback(hObject, eventdata, handles)
% hObject    handle to edName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edName as text
%        str2double(get(hObject,'String')) returns contents of edName as a double


% --- Executes during object creation, after setting all properties.
function edName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbOk.
function pbOk_Callback(hObject, eventdata, handles)
% hObject    handle to pbOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
mainhandles=guidata(DiffNMR.MainAxes);
temp = DiffNMR;
evalin('base',['DiffNMR =' get(handles.edName,'String') ';'])
if isfield(DiffNMR,'Gamma')
    clear temp
    DiffNMR.VaribleName=get(handles.edName,'String')
    delete(handles.OpenWorkspaseSpectrum)
    
    DiffNMR.MainAxes=mainhandles.axes1;
    DiffNMR.MainFigure=mainhandles.MainFigure;
    %Нижеследующий код производит заполнение полей edit данными считанными из
    %файла оброботки диффузиноного затухания.
    set(mainhandles.edTau,'String',num2str(DiffNMR.Tau*1e+3));
    set(mainhandles.edBigdelta,'String',num2str(DiffNMR.BigDelta*1e+3));
    set(mainhandles.edLittledelta,'String',num2str(DiffNMR.LittleDelta*1e+3));
    switch round(DiffNMR.Gamma);   %Hz/G
        case 4258           %1H
            set(mainhandles.pmNucleus,'Value',2);
        case 654            %2D
            set(mainhandles.pmNucleus,'Value',3);
        case 1655           %7Li
            set(mainhandles.pmNucleus,'Value',4);
        case 1366           %11B
            set(mainhandles.pmNucleus,'Value',5);
        case 4005           %19F
            set(mainhandles.pmNucleus,'Value',6);
    end
    if isfield(DiffNMR,'Qdecay')
        DiffNMR.Step=1;
        DiffNMR.Mode='diff'; %возможно придальнейшей модернизации эту строку надо убрать
        mainhandles.first = 1;
        guidata(DiffNMR.MainAxes,mainhandles)
        plotdiff(DiffNMR.MainAxes,[],mainhandles,'first')
    else
        disp('Диффузионного затухания в этой переменой нет')
        beep
    end
    %Заполнение полей коэффициентов диффузии и населенносте    
    if isfield(DiffNMR,'Population')
       s=length(DiffNMR.Population);
       for ii=1:4
          if ii<=s
              eval(['set(mainhandles.edCoefDiff' num2str(ii) ',' '''String'''...
                  ',' num2str(DiffNMR.CoefDiff(ii)) ')']);
              eval(['set(mainhandles.edCoef' num2str(ii) ',' '''String'''...
                  ',' num2str(DiffNMR.Population(ii)) ')']);
          else
              eval(['set(mainhandles.edCoefDiff' num2str(ii) ',' '''String''' ',' '''CoefDiff''' ')']);
              eval(['set(mainhandles.edCoef' num2str(ii) ',' '''String''' ',' '''coef''' ')']);
          end
       end
    end
set(mainhandles.MainFigure,'Name',['Fittexp' DiffNMR.Fname DiffNMR.VaribleName])
else
    DiffNMR = temp;
    disp('Эта переменная не содержет результатов обработки диффузионного эксперимента')
    beep
end


% --- Executes on button press in pbCancel.
function pbCancel_Callback(hObject, eventdata, handles)
% hObject    handle to pbCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.OpenWorkspaseSpectrum)




% --- Executes on key press over edName with no controls selected.
function edName_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on key press over OpenWorkspaseSpectrum with no controls selected.
function OpenWorkspaseSpectrum_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to OpenWorkspaseSpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


