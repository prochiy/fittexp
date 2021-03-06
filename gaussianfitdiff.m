function varargout = gaussianfitdiff(varargin)
% GAUSSIANFITDIFF M-file for gaussianfitdiff.fig
%      GAUSSIANFITDIFF, by itself, creates a new GAUSSIANFITDIFF or raises the existing
%      singleton*.
%
%      H = GAUSSIANFITDIFF returns the handle to a new GAUSSIANFITDIFF or the handle to
%      the existing singleton*.
%
%      GAUSSIANFITDIFF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAUSSIANFITDIFF.M with the given input arguments.
%
%      GAUSSIANFITDIFF('Property','Value',...) creates a new GAUSSIANFITDIFF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gaussianfitdiff_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gaussianfitdiff_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help gaussianfitdiff

% Last Modified by GUIDE v2.5 23-Aug-2010 19:16:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gaussianfitdiff_OpeningFcn, ...
                   'gui_OutputFcn',  @gaussianfitdiff_OutputFcn, ...
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


% --- Executes just before gaussianfitdiff is made visible.
function gaussianfitdiff_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gaussianfitdiff (see VARARGIN)

% Choose default command line output for gaussianfitdiff
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gaussianfitdiff wait for user response (see UIRESUME)
% uiwait(handles.gaussianfit);


% --- Outputs from this function are returned to the command line.
function varargout = gaussianfitdiff_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edExpectation_Callback(hObject, eventdata, handles)
% hObject    handle to edExpectation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edExpectation as text
%        str2double(get(hObject,'String')) returns contents of edExpectation as a double


% --- Executes during object creation, after setting all properties.
function edExpectation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edExpectation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edSigma_Callback(hObject, eventdata, handles)
% hObject    handle to edSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edSigma as text
%        str2double(get(hObject,'String')) returns contents of edSigma as a double


% --- Executes during object creation, after setting all properties.
function edSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on button press in btnFit.
function btnFit_Callback(hObject, eventdata, handles)
% hObject    handle to btnFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
Expectation=str2num(get(handles.edExpectation,'String')); %��� ��������
Sigma=str2num(get(handles.edSigma,'String')); %���������/�����
Dispertion=Expectation*Sigma %���������
if get(handles.rbLinear,'Value')==1
    fun=fittype({'-x','power(x,2)/2'},...
    'coefficient',{'m','s'},...
    'independent','x');
    opt=fitoptions('Method','LinearLeastSquares');
    %set(opt,'Algorithm','Levenberg-Marquardt')
    %set(opt,'StartPoint',[Expectation Dispertion])
    set(opt,'Lower',[0,0])
    %set(opt,'TolFun',1e-9)
    %set(opt,'TolX',1e-9)
    %set(opt,'Display','iter')
    [fitresult,gof]=fit(DiffNMR.Qdecay{1}(:,1),log(DiffNMR.Qdecay{1}(:,2)),fun,opt)
    x=DiffNMR.Qdecay{1}(1,1):0.01*DiffNMR.Qdecay{1}(end,1):DiffNMR.Qdecay{1}(end,1);
    m=fitresult.m;
    s=sqrt(1./fitresult.s);
    y=exp(-m*x+x.^2/(2*s^2));
    plot(x,y,'-r','Parent',DiffNMR.MainAxes)
    x=0:m/100:2*m;
    y=1/s*sqrt(2*pi)*exp(-power(x-m,2)/(2*s^2));
    cla;
    plot(x,y)
    set(handles.edExpectation,'String',m)
    set(handles.edSigma,'String',s/m)
end

if get(handles.rbGeneral,'Value')==1
    
    fun=fittype('gausdiff(x,d,s)');
    opt=fitoptions('Method','NonlinearLeastSquares');
    set(opt,'Algorithm','Trust-Region')
    set(opt,'StartPoint',[1 Dispertion/Expectation])
    set(opt,'Lower',[0.1,Dispertion*0.5/Expectation])
    set(opt,'Upper',[10,Dispertion*2/Expectation])
    set(opt,'TolFun',1e-20)
    set(opt,'TolX',1e-20)
    set(opt,'DiffMinChange',1e-20)
    set(opt,'DiffMaxChange',1e-2)
    set(opt,'Robust','on')
    set(opt,'Display','iter')

    [fitresult,gof]=fit(DiffNMR.Qdecay{1}(:,1)*Expectation,DiffNMR.Qdecay{1}(:,2),fun,opt)
    %����� ����������� �� ������ ������������������ �������
    x=(DiffNMR.Qdecay{1}(1,1):0.01*DiffNMR.Qdecay{1}(end,1):DiffNMR.Qdecay{1}(end,1))*Expectation;
    y=gausdiff(x,fitresult.d,fitresult.s);
    plot(x/Expectation,y,'r-','Parent',DiffNMR.MainAxes)
    m=fitresult.d*Expectation;
    s=fitresult.s*Expectation;
    x=0:m/100:2*m;
    y=1/sqrt(2*pi)/s*exp(-power(x-m,2)/(2*power(s,2)));
    set(handles.edExpectation,'String',m)
    set(handles.edSigma,'String',s/m)
    cla;
    plot(x,y)
end


    




% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.gaussianfit);

