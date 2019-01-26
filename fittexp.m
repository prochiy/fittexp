function varargout = fittexp(varargin)
% FITTEXP M-mFile for fittexp.fig
%      FITTEXP, by itself, creates a new FITTEXP or raises the existing
%      singleton*.
%
%      H = FITTEXP returns the handle to a new FITTEXP or the handle to
%      the existing singleton*.
%
%      FITTEXP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FITTEXP.M with the given input arguments.
%
%      FITTEXP('Property','Value',...) creates a new FITTEXP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fittexp_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fittexp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help fittexp

% Last Modified by GUIDE v2.5 24-Apr-2011 20:48:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fittexp_OpeningFcn, ...
                   'gui_OutputFcn',  @fittexp_OutputFcn, ...
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


% --- Executes just before fittexp is made visible.
function fittexp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fittexp (see VARARGIN)

% Choose default command line output for fittexp
handles.output = hObject;

%���������� ����������
global DiffNMR;
evalin('base','global DiffNMR;');
DiffNMR.MainFigure=gcf;
DiffNMR.Mode = 'start';
DiffNMR.Click=0;
DiffNMR.Step=0;
DiffNMR.fase0=0;
DiffNMR.fase1=0;
DiffNMR.LimitA=[];
DiffNMR.LimitB=[];
handles.Limits=[];
handles.FirstPointShift=0;
handles.SecondPointShift=0;
handles.LineShift=0;
set(gcf,'CurrentAxes',handles.axes1);
DiffNMR.MainAxes = gca;

%�������� ������������ ���� ��� �������� ����� �������
handles.cmenu = uicontextmenu;
handles.item1 = uimenu(handles.cmenu, 'Label', 'delete', 'Callback','deletediff(gcbo,[])');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fittexp wait for user response (see UIRESUME)
% uiwait(handles.MainFigure);


% --- Outputs from this function are returned to the command line.
function varargout = fittexp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edEquation_Callback(hObject, eventdata, handles)
% hObject    handle to edEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edEquation as text
%        str2double(get(hObject,'String')) returns contents of edEquation as a double


% --- Executes during object creation, after setting all properties.
function edEquation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edTau_Callback(hObject, eventdata, handles)
% hObject    handle to edTau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTau as text
%        str2double(get(hObject,'String')) returns contents of edTau as a double


% --- Executes during object creation, after setting all properties.
function edTau_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edTau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnNext.
function btnNext_Callback(hObject, eventdata, handles)
% hObject    handle to btnNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)get(handles.edTau,'String'
global DiffNMR;
if strcmp(DiffNMR.Mode,'diff')
    if DiffNMR.Step<4
        DiffNMR.Step=DiffNMR.Step+1;
        handles.first=1;
        guidata(hObject,handles)
        plotdiff(hObject,[],handles,'first');
    else
        disp('��� ��������, ������ ������� ��������� ������ ������')
        beep
    end
elseif strcmp(DiffNMR.Mode,'spec')
    plotspecdiff(gcbo,[],guidata(gcbo),'next')
end
    





function edBigdelta_Callback(hObject, eventdata, handles)
% hObject    handle to edBigdelta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edBigdelta as text
%        str2double(get(hObject,'String')) returns contents of edBigdelta as a double


% --- Executes during object creation, after setting all properties.
function edBigdelta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edBigdelta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edLittledelta_Callback(hObject, eventdata, handles)
% hObject    handle to edLittledelta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edLittledelta as text
%        str2double(get(hObject,'String')) returns contents of edLittledelta as a double


% --- Executes during object creation, after setting all properties.
function edLittledelta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edLittledelta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pmNucleus.
function pmNucleus_Callback(hObject, eventdata, handles)
% hObject    handle to pmNucleus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pmNucleus contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmNucleus
Num={get(hObject,'Value')};
switch Num{1}
    case 1
        handles.gamma=4.258e+003;
    case 2
        handles.gamma=1.655e+003;
    
        
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pmNucleus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmNucleus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --------------------------------------------------------------------
function mFile_Callback(hObject, eventdata, handles)
% hObject    handle to mFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
%guidata(gcbo,handles); % ��������� ��������� handles




% --- Executes on button press in btnStop.
function btnStop_Callback(hObject, eventdata, handles)
% hObject    handle to btnStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
DiffNMR.Click=1;
zoomdiff(gcbo,handles,'down');
plotdiff(gcbo,[],guidata(gcbo),'down');
phasediff(gcbo,[],guidata(gcbo),'down');
if strcmp(DiffNMR.Mode,'integration')
    integrationdiff(gcbo,[],guidata(gcbo),'click')
end



% --- Executes on button press in tgZoom.
function tgZoom_Callback(hObject, eventdata, handles)
% hObject    handle to tgZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tgZoom
global DiffNMR;
%��������� ������ ������� ��� �������
if get(handles.tgZoom,'Value')
    set(DiffNMR.MainFigure,'Pointer','fullcross')
else
    set(DiffNMR.MainFigure,'Pointer','arrow')
end
%
if get(handles.tgCarry,'Value')==1;
    set(handles.tgCarry,'Value',0)
    pan off;
    handles.CurrentAxisXlim=get(DiffNMR.MainAxes,'XLim');
    handles.CurrentAxisYlim=get(DiffNMR.MainAxes,'YLim');
    guidata(hObject,handles);
end


% --- Executes on button press in tgCarry.
function tgCarry_Callback(hObject, eventdata, handles)
% hObject    handle to tgCarry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tgCarry
global DiffNMR;
if get(handles.tgZoom,'Value')==1;
    set(handles.tgZoom,'Value',0)
end
if get(hObject,'Value')==1
    pan(handles.axes1)
else
    pan off;
    handles.CurrentAxisXlim=get(DiffNMR.MainAxes,'XLim');
    handles.CurrentAxisYlim=get(DiffNMR.MainAxes,'YLim');
    guidata(hObject,handles);
end




% --- Executes on mouse motion over figure - except title and menu.
function MainFigure_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to MainFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%zoomdiff(hObject,handles,'motion');
global DiffNMR;
if DiffNMR.Click==1
    plotdiff(hObject,[],handles,'motion');
    phasediff(gcbo,[],handles,'motion');
elseif strcmp(DiffNMR.Mode,'integration')
    integrationdiff(gcbo,[],guidata(gcbo),'limits')
end



% --- Executes during object creation, after setting all properties.
function MainFigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MainFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
global DiffNMR;
DiffNMR.MainAxes=gca;
DiffNMR.InitialAxisXLim=get(DiffNMR.MainAxes,'XLim'); %��� �� ���������, ��� �� ��� �������� ������������
DiffNMR.InitialAxisYLim=get(DiffNMR.MainAxes,'YLim'); %��� ���������� ������� ����� ������ �� �����
%guidata(hObject,handles);




% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function MainFigure_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to MainFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
if eq(DiffNMR.Click,1)
    DiffNMR.Click=0;
    zoomdiff(hObject,handles,'up')
    plotdiff(hObject,[],handles,'up')
    phasediff(hObject,[],handles,'up')
end




% --- Executes on button press in btnBack.
function btnBack_Callback(hObject, eventdata, handles)
% hObject    handle to btnBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
if strcmp(DiffNMR.Mode,'diff')
    if ne(DiffNMR.Step,1)
        DiffNMR.Step=DiffNMR.Step-1;
        handles.first=1;
        guidata(hObject,handles);
        plotdiff(hObject,[],handles,'first')
    else
        disp('��� ����� ������ ������')
    end
elseif strcmp(DiffNMR.Mode,'spec')
    plotspecdiff(gcbo,[],guidata(gcbo),'back')
end





% --------------------------------------------------------------------
function mView_Callback(hObject, eventdata, handles)
% hObject    handle to mView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mDisplayDifferens_Callback(hObject, eventdata, handles)
% hObject    handle to mDisplayDifferens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'Checked'),'on')
    set(hObject,'Checked','off')
    set(handles.axes2,'Visible','off')
    if isfield(handles,'differens')&&ishandle(handles.differens)
        set(handles.differens,'Visible','off')
    end
else
    set(hObject,'Checked','on')
    set(handles.axes2,'Visible','on')
    if isfield(handles,'differens')&&ishandle(handles.differens)
        set(handles.differens,'Visible','on')
    end
end




% --------------------------------------------------------------------
function mOpenFile_Callback(hObject, eventdata, handles)
% hObject    handle to mOpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DiffNMR;
readdiff; %������ ������ �� ���� ��������� ������������� ���������

set(handles.edCoefDiff1,'String','CoefDiff'); %���� ���� �������� �� 
set(handles.edCoef1,'String','coef');      %��������� ����� ������ 
set(handles.edCoefDiff2,'String','CoefDiff');
set(handles.edCoef2,'String','coef');
set(handles.edCoefDiff3,'String','CoefDiff');
set(handles.edCoef3,'String','coef');
set(handles.edCoefDiff4,'String','CoefDiff');
set(handles.edCoef4,'String','coef');



%������������� ��� ���������� ���������� ����� edit ������� ���������� ��
%����� ��������� ������������� ���������.
set(handles.edBigdelta,'String',num2str(DiffNMR.BigDelta*1e+3));
set(handles.edLittledelta,'String',num2str(DiffNMR.LittleDelta*1e+3));
switch DiffNMR.Gamma;   %Hz/G
    case 4258           %1H
        set(handles.pmNucleus,'Value',2);
    case 1655           %7Li
        set(handles.pmNucleus,'Value',3);
end




% --------------------------------------------------------------------
function mAxesDifferensYScale_Callback(hObject, eventdata, handles)
% hObject    handle to mAxesDifferensYScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mYScaleLog_Callback(hObject, eventdata, handles)
% hObject    handle to mYScaleLog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if eq(get(hObject,'Checked'),'off')
    set(hObject,'Checked','on')
    set(handles.axes2,'YScale','log')
    set(handles.mYScaleLinear,'Checked','off')
end



% --------------------------------------------------------------------
function mYScaleLinear_Callback(hObject, eventdata, handles)
% hObject    handle to mYScaleLinear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if eq(get(hObject,'Checked'),'off')
    set(hObject,'Checked','on')
    set(handles.axes2,'YScale','linear')
    set(handles.mYScaleLog,'Checked','off')
end


% --------------------------------------------------------------------
function mEdit_Callback(hObject, eventdata, handles)
% hObject    handle to mEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mCopyFigure_Callback(hObject, eventdata, handles)
% hObject    handle to mCopyFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
h=figure();
CopyAxes=copyobj(handles.axes1,h);
set(CopyAxes,'Units','normalized','Position',[0.13 0.11 0.775 0.815],'ButtonDownFcn','')
set(get(CopyAxes,'Children'),'ButtonDownFcn','')
DiffNMR.MainAxes = handles.axes1;





% --------------------------------------------------------------------
function mShowFittingResult_Callback(hObject, eventdata, handles)
% hObject    handle to mShowFittingResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
x=0:0.005*DiffNMR.Qdecay{1}(end,1):DiffNMR.Qdecay{1}(end,1);
k=size(x,2);
y(1:k)=0;
for i=1:DiffNMR.Step
    M=str2num(get(eval(['handles.edCoef' num2str(i)]),'String'));
    D=str2num(get(eval(['handles.edCoefDiff' num2str(i)]),'String'));
    for ii=1:k
        y(ii)=y(ii)+M*exp(-D*x(ii));
    end
end

temp=DiffNMR.Step;
DiffNMR.Step=1;
plotdiff(hObject,[],handles,'first')
plot(x,y,'r:','LineWidth',2)
DiffNMR.Step=temp;


% --------------------------------------------------------------------
function mFitting_Callback(hObject, eventdata, handles)
% hObject    handle to mFitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mGaussianFit_Callback(hObject, eventdata, handles)
% hObject    handle to mGaussianFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gaussianfitdiff;


% --------------------------------------------------------------------
function mDistributionFit_Callback(hObject, eventdata, handles)
% hObject    handle to mDistributionFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
distributionfitdiff



% --------------------------------------------------------------------
function mLogNormalFit_Callback(hObject, eventdata, handles)
% hObject    handle to mLogNormalFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lognormalfitdiff




% --------------------------------------------------------------------
function mOpemFile2rr_Callback(hObject, eventdata, handles)
% hObject    handle to mOpemFile2rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
Brukerlaaddiff;
plotspecdiff(gcbo,[],guidata(gcbo),'first');



% --------------------------------------------------------------------
function mProcessing_Callback(hObject, eventdata, handles)
% hObject    handle to mProcessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mIntegrationR_Callback(hObject, eventdata, handles)
% hObject    handle to mIntegrationR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
integrationdiff(gcbo,[],guidata(gcbo),'real')


% --------------------------------------------------------------------
function mIntgrationB_Callback(hObject, eventdata, handles)
% hObject    handle to mIntgrationB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
integrationdiff(gcbo,[],guidata(gcbo),'both')




% --- Executes during object deletion, before destroying properties.
function MainFigure_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to MainFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
DiffNMR.Mode = 'delete';




% --------------------------------------------------------------------
function mAutomaticCP_Callback(hObject, eventdata, handles)
% hObject    handle to mAutomaticCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

phasediff(gcbo,[],guidata(gcbo),'avto')


% --------------------------------------------------------------------
function mOpenWorkspaseSpectrum_Callback(hObject, eventdata, handles)
% hObject    handle to mOpenWorkspaseSpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

openworkspasespectrumdiff



% --- Executes on button press in pbMinus.
function pbMinus_Callback(hObject, eventdata, handles)
% hObject    handle to pbMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
incrementdiff(hObject,[],handles,'minus')


% --- Executes on button press in pbPlus.
function pbPlus_Callback(hObject, eventdata, handles)
% hObject    handle to pbPlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
incrementdiff(hObject,[],handles,'plus')



function edIncrement_Callback(hObject, eventdata, handles)
% hObject    handle to edIncrement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edIncrement as text
%        str2double(get(hObject,'String')) returns contents of edIncrement as a double


% --- Executes during object creation, after setting all properties.
function edIncrement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edIncrement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in rb1.
function rb1_Callback(hObject, eventdata, handles)
% hObject    handle to rb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb1


% --- Executes on button press in rb2.
function rb2_Callback(hObject, eventdata, handles)
% hObject    handle to rb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb2


% --- Executes on button press in rb3.
function rb3_Callback(hObject, eventdata, handles)
% hObject    handle to rb3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb3


% --- Executes on button press in rb4.
function rb4_Callback(hObject, eventdata, handles)
% hObject    handle to rb4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb4


% --- Executes on button press in rb12.
function rb12_Callback(hObject, eventdata, handles)
% hObject    handle to rb12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb12


% --- Executes on button press in rb6.
function rb6_Callback(hObject, eventdata, handles)
% hObject    handle to rb6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb6


% --- Executes on button press in rb7.
function rb7_Callback(hObject, eventdata, handles)
% hObject    handle to rb7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb7


% --- Executes on button press in rb8.
function rb8_Callback(hObject, eventdata, handles)
% hObject    handle to rb8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb8



% --- Executes on button press in pbFit.
function pbFit_Callback(hObject, eventdata, handles)
% hObject    handle to pbFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fitdiff(hObject,[],handles)




% --- Executes on button press in pbRefresh.
function pbRefresh_Callback(hObject, eventdata, handles)
% hObject    handle to pbRefresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DiffNMR;
DiffNMR.Population=[];
DiffNMR.CoefDiff=[];
if isfield(DiffNMR,'Qdecay')
    temp=DiffNMR.Qdecay{1};
    DiffNMR.Qdecay=[];
    DiffNMR.Qdecay{1}=temp;
end
DiffNMR.Step=1;
handles.first=1;
guidata(hObject,handles)
plotdiff(hObject,[],handles,'first')
set(handles.edCoefDiff1,'String','CoefDiff'); %���� ���� �������� �� 
set(handles.edCoef1,'String','coef');      %��������� ����� ������ 
set(handles.edCoefDiff2,'String','CoefDiff');
set(handles.edCoef2,'String','coef');
set(handles.edCoefDiff3,'String','CoefDiff');
set(handles.edCoef3,'String','coef');
set(handles.edCoefDiff4,'String','CoefDiff');
set(handles.edCoef4,'String','coef');




% --------------------------------------------------------------------
function mMultiLogNormalFit_Callback(hObject, eventdata, handles)
% hObject    handle to mMultiLogNormalFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
multilognormalfitdiff;



% --- Executes on button press in rbN.
function rbN_Callback(hObject, eventdata, handles)
% hObject    handle to rbN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbN


% --- Executes on button press in rbGrad.
function rbGrad_Callback(hObject, eventdata, handles)
% hObject    handle to rbGrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbGrad








% --------------------------------------------------------------------
function mAutomaticCP0_Callback(hObject, eventdata, handles)
% hObject    handle to mAutomaticCP0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
phasediff(gcbo,[],guidata(gcbo),'avto0')

