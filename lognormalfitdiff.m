function varargout = lognormalfitdiff(varargin)
% LOGNORMALFITDIFF M-file for lognormalfitdiff.fig
%      LOGNORMALFITDIFF, by itself, creates a new LOGNORMALFITDIFF or raises the existing
%      singleton*.
%
%      H = LOGNORMALFITDIFF returns the handle to a new LOGNORMALFITDIFF or the handle to
%      the existing singleton*.
%
%      LOGNORMALFITDIFF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOGNORMALFITDIFF.M with the given input arguments.
%
%      LOGNORMALFITDIFF('Property','Value',...) creates a new LOGNORMALFITDIFF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lognormalfitdiff_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lognormalfitdiff_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help lognormalfitdiff

% Last Modified by GUIDE v2.5 02-Oct-2010 20:19:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lognormalfitdiff_OpeningFcn, ...
                   'gui_OutputFcn',  @lognormalfitdiff_OutputFcn, ...
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


% --- Executes just before lognormalfitdiff is made visible.
function lognormalfitdiff_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lognormalfitdiff (see VARARGIN)

% Choose default command line output for lognormalfitdiff
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lognormalfitdiff wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lognormalfitdiff_OutputFcn(hObject, eventdata, handles) 
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
Expectation=str2num(get(handles.edExpectation,'String'))
Sigma=str2num(get(handles.edSigma,'String')) 

a=1;
if get(handles.rbGeneral,'Value')==1
    func=fittype('lognormaldiff(x,m,s,p)','problem','p'); %,'independent','x'
    opt=fitoptions('Method','NonlinearLeastSquares');
    set(opt,'Algorithm','Trust-Region')
    set(opt,'Normalize','off')
    set(opt,'StartPoint',[1*Expectation Sigma*Expectation*a])
    set(opt,'Lower',[0.01*Expectation Sigma*0.5*Expectation*a])
    set(opt,'Upper',[10*Expectation Sigma*2*Expectation*a])
    set(opt,'TolFun',1e-10)
    set(opt,'TolX',1e-10)
    set(opt,'DiffMinChange',1e-12)
    set(opt,'DiffMaxChange',1e-1)
    set(opt,'MaxFunEvals',400)
    set(opt,'Robust','off')
    set(opt,'Display','iter')

    [fitresult,gof]=fit(DiffNMR.Qdecay{DiffNMR.Step}(:,1),DiffNMR.Qdecay{DiffNMR.Step}(:,2),...
        func,opt,'problem',{Expectation*a})
    m=fitresult.m;
    s=fitresult.s/Expectation/a;
    
    %вывод результатов подгонки на график с экспериментальными данными
    x=DiffNMR.Qdecay{1}(1,1):0.01*DiffNMR.Qdecay{1}(end,1):DiffNMR.Qdecay{1}(end,1);
    y=lognormaldiff(x,fitresult.m,fitresult.s,Expectation*a);
    plot(x,y,'r-','Parent',DiffNMR.MainAxes)
    %figure;
    %plot(x/Expectation,y,'r-')
    %вывод распреднления на график
    
    %x=Expectation/500:Expectation/500:2*Expectation;
    x=log10(Expectation)-7:0.01:log10(Expectation)+3;
    x=power(10,x);
    y=lognpdf(x,log(m),s);
    cla;
    semilogx(x,y,'Parent',handles.axes1);
    set(handles.edExpectation,'String',m)
    set(handles.edSigma,'String',s)
else
%     E=0.1*Expectation:0.1*Expectation:10*Expectation;
%     S=0.5*Sigma:2*Sigma/100:2*Sigma;
%     iie=length(E);
%     iis=length(S);
%     for ie=1:iie
%         for is=1:iis
%             sse(ie,is)=sum(power(DiffNMR.Qdecay{1}(:,2)...
%                 -lognormaldiff(DiffNMR.Qdecay{1}(:,1),E(ie),S(is),1),2));
%         end
%     end
%     minsse=min(min(sse));
%     ssei(:,:) = sse(:,:)==minsse;
%     [ie,is]=find(ssei)
%     %disp('вычисления прошли')
%     m=E(ie);
%     s=S(is);
    

    % Метод прямого поиска (метод Хука-Дживса)
    %E=0.1*Expectation:0.1*Expectation:10*Expectation;
    step=-1:0.01:1;
    E=Expectation*power(10,step);
    S=0.5*Sigma:Sigma/100:2*Sigma;
    iie=length(E);
    iis=length(S);
    iieCurrent=find(E>Expectation,1,'first');
    iisCurrent=find(S>Sigma,1,'first');
    valCurrent=sse(E(iieCurrent),S(iisCurrent));
    for ii=1:100
        if (sse(E(iieCurrent+1),S(iisCurrent))<valCurrent)
            if iieCurrent+1<iie
                dE=+1;
            else
                dE=0;
            end
        elseif (sse(E(iieCurrent-1),S(iisCurrent))<valCurrent)
            if iieCurrent-1>1
                dE=-1;
            else
                dE=0;
            end
        else
            dE=0;
        end
        if (sse(E(iieCurrent),S(iisCurrent+1))<valCurrent)
            if iisCurrent+1<iis
                dS=+1;
            else
                dS=0;
            end
        elseif (sse(E(iieCurrent),S(iisCurrent-1))<valCurrent)
            if iisCurrent-1>1
                dS=-1;
            else
                dS=0;
            end
        else
            dS=0;
        end
        if (dS==0)&&(dE==0)
            break;
        else
            iieCurrent=iieCurrent+dE;
            iisCurrent=iisCurrent+dS;
            valCurrent=sse(E(iieCurrent),S(iisCurrent));
        end
    end
    
    m=E(iieCurrent); s=S(iisCurrent);
    
    %вывод результатов подгонки на график с экспериментальными данными
    x=DiffNMR.Qdecay{1}(1,1):0.01*DiffNMR.Qdecay{1}(end,1):DiffNMR.Qdecay{1}(end,1);
    y=lognormaldiff(x,m,s,1);
    plot(x,y,'r-','Parent',DiffNMR.MainAxes)
    
    %вывод распреднления на график
    
    %x=Expectation/500:Expectation/500:2*Expectation;
    x=log10(Expectation)-7:0.01:log10(Expectation)+3;
    x=power(10,x);
    y=lognpdf(x,log(m),s);
    cla;
    semilogx(x,y,'Parent',handles.axes1);
    set(handles.edExpectation,'String',m)
    set(handles.edSigma,'String',s)
end

function out = sse(E,S)
        global DiffNMR;
        out=sum(power(DiffNMR.Qdecay{1}(:,2)...
        -lognormaldiff(DiffNMR.Qdecay{1}(:,1),E,S,1),2));


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.lognormal)




