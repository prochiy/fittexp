function varargout = multilognormalfitdiff(varargin)
% MULTILOGNORMALFITDIFF M-file for multilognormalfitdiff.fig
%      MULTILOGNORMALFITDIFF, by itself, creates a new MULTILOGNORMALFITDIFF or raises the existing
%      singleton*.
%
%      H = MULTILOGNORMALFITDIFF returns the handle to a new MULTILOGNORMALFITDIFF or the handle to
%      the existing singleton*.
%
%      MULTILOGNORMALFITDIFF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTILOGNORMALFITDIFF.M with the given input arguments.
%
%      MULTILOGNORMALFITDIFF('Property','Value',...) creates a new MULTILOGNORMALFITDIFF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multilognormalfitdiff_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multilognormalfitdiff_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help multilognormalfitdiff

% Last Modified by GUIDE v2.5 19-Mar-2011 17:57:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multilognormalfitdiff_OpeningFcn, ...
                   'gui_OutputFcn',  @multilognormalfitdiff_OutputFcn, ...
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


% --- Executes just before multilognormalfitdiff is made visible.
function multilognormalfitdiff_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multilognormalfitdiff (see VARARGIN)

% Choose default command line output for multilognormalfitdiff
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes multilognormalfitdiff wait for user response (see UIRESUME)
% uiwait(handles.multilognormal);


% --- Outputs from this function are returned to the command line.
function varargout = multilognormalfitdiff_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edPop1_Callback(hObject, eventdata, handles)
% hObject    handle to edPop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edPop1 as text
%        str2double(get(hObject,'String')) returns contents of edPop1 as a double


% --- Executes during object creation, after setting all properties.
function edPop1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edPop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edSig1_Callback(hObject, eventdata, handles)
% hObject    handle to edSig1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edSig1 as text
%        str2double(get(hObject,'String')) returns contents of edSig1 as a double


% --- Executes during object creation, after setting all properties.
function edSig1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edSig1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edDiff1_Callback(hObject, eventdata, handles)
% hObject    handle to edDiff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edDiff1 as text
%        str2double(get(hObject,'String')) returns contents of edDiff1 as a double


% --- Executes during object creation, after setting all properties.
function edDiff1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edDiff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rbPop1.
function rbPop1_Callback(hObject, eventdata, handles)
% hObject    handle to rbPop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbPop1


% --- Executes on button press in rbSig1.
function rbSig1_Callback(hObject, eventdata, handles)
% hObject    handle to rbSig1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbSig1


% --- Executes on button press in rbDiff1.
function rbDiff1_Callback(hObject, eventdata, handles)
% hObject    handle to rbDiff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbDiff1



function edPop2_Callback(hObject, eventdata, handles)
% hObject    handle to edPop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edPop2 as text
%        str2double(get(hObject,'String')) returns contents of edPop2 as a double


% --- Executes during object creation, after setting all properties.
function edPop2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edPop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edSig2_Callback(hObject, eventdata, handles)
% hObject    handle to edSig2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edSig2 as text
%        str2double(get(hObject,'String')) returns contents of edSig2 as a double


% --- Executes during object creation, after setting all properties.
function edSig2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edSig2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edDiff2_Callback(hObject, eventdata, handles)
% hObject    handle to edDiff2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edDiff2 as text
%        str2double(get(hObject,'String')) returns contents of edDiff2 as a double


% --- Executes during object creation, after setting all properties.
function edDiff2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edDiff2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rbPop2.
function rbPop2_Callback(hObject, eventdata, handles)
% hObject    handle to rbPop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbPop2


% --- Executes on button press in rbSig2.
function rbSig2_Callback(hObject, eventdata, handles)
% hObject    handle to rbSig2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbSig2


% --- Executes on button press in rbDiff2.
function rbDiff2_Callback(hObject, eventdata, handles)
% hObject    handle to rbDiff2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbDiff2



function edPop3_Callback(hObject, eventdata, handles)
% hObject    handle to edPop3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edPop3 as text
%        str2double(get(hObject,'String')) returns contents of edPop3 as a double


% --- Executes during object creation, after setting all properties.
function edPop3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edPop3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edSig3_Callback(hObject, eventdata, handles)
% hObject    handle to edSig3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edSig3 as text
%        str2double(get(hObject,'String')) returns contents of edSig3 as a double


% --- Executes during object creation, after setting all properties.
function edSig3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edSig3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edDiff3_Callback(hObject, eventdata, handles)
% hObject    handle to edDiff3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edDiff3 as text
%        str2double(get(hObject,'String')) returns contents of edDiff3 as a double


% --- Executes during object creation, after setting all properties.
function edDiff3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edDiff3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rbPop3.
function rbPop3_Callback(hObject, eventdata, handles)
% hObject    handle to rbPop3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbPop3


% --- Executes on button press in rbSig3.
function rbSig3_Callback(hObject, eventdata, handles)
% hObject    handle to rbSig3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbSig3


% --- Executes on button press in rbDiff3.
function rbDiff3_Callback(hObject, eventdata, handles)
% hObject    handle to rbDiff3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbDiff3



function edPop4_Callback(hObject, eventdata, handles)
% hObject    handle to edPop4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edPop4 as text
%        str2double(get(hObject,'String')) returns contents of edPop4 as a double


% --- Executes during object creation, after setting all properties.
function edPop4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edPop4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edSig4_Callback(hObject, eventdata, handles)
% hObject    handle to edSig4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edSig4 as text
%        str2double(get(hObject,'String')) returns contents of edSig4 as a double


% --- Executes during object creation, after setting all properties.
function edSig4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edSig4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edDiff4_Callback(hObject, eventdata, handles)
% hObject    handle to edDiff4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edDiff4 as text
%        str2double(get(hObject,'String')) returns contents of edDiff4 as a double


% --- Executes during object creation, after setting all properties.
function edDiff4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edDiff4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rbPop4.
function rbPop4_Callback(hObject, eventdata, handles)
% hObject    handle to rbPop4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbPop4


% --- Executes on button press in rbSig4.
function rbSig4_Callback(hObject, eventdata, handles)
% hObject    handle to rbSig4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbSig4


% --- Executes on button press in rbDiff4.
function rbDiff4_Callback(hObject, eventdata, handles)
% hObject    handle to rbDiff4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbDiff4


% --- Executes on button press in pbCancel.
function pbCancel_Callback(hObject, eventdata, handles)
% hObject    handle to pbCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.multilognormal)


% --- Executes on button press in bpFit.
function bpFit_Callback(hObject, eventdata, handles)
% hObject    handle to bpFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DiffNMR;
state=[];
%cell2mat(get(eval(['handles.edPop' num2str(1)]),'String'))
lnd=@lognormaldiff; %��������������� �������, ����� ������ ���� ������
for ii=1:4 %��������� ���� ������ ����� � ���������� ��������� ���������
    %������ � �������
    if iscell(get(eval(['handles.edPop' num2str(ii)]),'String'))
        temp1=isempty(str2num(cell2mat(get(eval(['handles.edPop' num2str(ii)]),'String'))));
    else
        temp1=isempty(str2num(get(eval(['handles.edPop' num2str(ii)]),'String')));
    end
    if iscell(get(eval(['handles.edSig' num2str(ii)]),'String'))
        temp2=isempty(str2num(cell2mat(get(eval(['handles.edSig' num2str(ii)]),'String'))));
    else
        temp2=isempty(str2num(get(eval(['handles.edSig' num2str(ii)]),'String')));
    end
    if iscell(get(eval(['handles.edDiff' num2str(ii)]),'String'))
        temp3=isempty(str2num(cell2mat(get(eval(['handles.edDiff' num2str(ii)]),'String'))));
    else
        temp3=isempty(str2num(get(eval(['handles.edDiff' num2str(ii)]),'String')));
    end
%     if isempty(str2num(cell2mat(get(eval(['handles.edPop' num2str(ii)]),'String'))))...
%             ||isempty(str2num(cell2mat(get(eval(['handles.edSig' num2str(ii)]),'String'))))...
%             ||isempty(str2num(cell2mat(get(eval(['handles.edDiff' num2str(ii)]),'String'))))
    if temp1 || temp2 || temp3    
        DiffNMR.temp.state(ii)=false;
        disp(['������ ' num2str(ii) ' �� �������������'])
        term{ii}=' ';
    else
        DiffNMR.temp.state(ii)=true;
        disp(['������ ' num2str(ii) ' �������������'])
        %���������� ���� �� ������ ������� ������������������� �������������
        DiffNMR.temp.term{ii}=['+a' mat2str(ii) '*lnd(g' num2str(ii) ',m' num2str(ii) ',s' num2str(ii) ',1)'];
        %���������� ��������� ������� �������������������� �������������
        DiffNMR.temp.arg{ii}=[',a' mat2str(ii) ',g' num2str(ii) ',m' num2str(ii) ',s' num2str(ii)];
        %���������� ������, ���������� �� �� ����� �� ���������� �����������
        rbPop(ii)=get(eval(['handles.rbPop' num2str(ii)]),'value');
        rbSig(ii)=get(eval(['handles.rbSig' num2str(ii)]),'value');
        rbDiff(ii)=get(eval(['handles.rbDiff' num2str(ii)]),'value');
        
        %����������� �������� �������� ������� ����� ������������ ��������
        %pop(ii)=str2num(cell2mat(get(eval(['handles.edPop' num2str(ii)]),'string')));
        %sig(ii)=str2num(cell2mat(get(eval(['handles.edSig' num2str(ii)]),'string')));
        %coefDiff(ii)=str2num(cell2mat(get(eval(['handles.edDiff' num2str(ii)]),'string')));
        
        %������ � �������
        if iscell(get(eval(['handles.edPop' num2str(ii)]),'String'))
            pop(ii)=str2num(cell2mat(get(eval(['handles.edPop' num2str(ii)]),'string')));
        else
            pop(ii)=str2num(get(eval(['handles.edPop' num2str(ii)]),'string'));
        end
        if iscell(get(eval(['handles.edSig' num2str(ii)]),'String'))
            sig(ii)=str2num(cell2mat(get(eval(['handles.edSig' num2str(ii)]),'string')));
        else
            sig(ii)=str2num(get(eval(['handles.edSig' num2str(ii)]),'string'));
        end
        if iscell(get(eval(['handles.edDiff' num2str(ii)]),'String'))
            coefDiff(ii)=str2num(cell2mat(get(eval(['handles.edDiff' num2str(ii)]),'string')));
        else
            coefDiff(ii)=str2num(get(eval(['handles.edDiff' num2str(ii)]),'string'));
        end
        if get(handles.rbHook,'Value')==1
            %����������� �������� �� ������� ����� ������������� ��������
            if get(handles.rbLow,'value')==1
                DiffNMR.temp.vPop{ii}=pop(ii)/2:pop(ii)/100:pop(ii)*2;
                DiffNMR.temp.vSig{ii}=sig(ii)/2:sig(ii)/100:sig(ii)*2;
                cvd=-0.5:0.5/100:0.5;
                DiffNMR.temp.vCD{ii}=coefDiff(ii)*power(10,cvd);
            else
                DiffNMR.temp.vPop{ii}=pop(ii)*0.8:pop(ii)/100:pop(ii)*1.2;
                DiffNMR.temp.vSig{ii}=sig(ii)*0.8:sig(ii)/100:sig(ii)*1.2;
                cvd=-0.2:0.2/100:0.2;
                DiffNMR.temp.vCD{ii}=coefDiff(ii)*power(10,cvd);
            end
            lvPop(ii)=length(DiffNMR.temp.vPop{ii}); %������ ��������
            lvSig(ii)=length(DiffNMR.temp.vSig{ii});
            lvCD(ii)=length(DiffNMR.temp.vCD{ii});

            ciPop(ii)=find(DiffNMR.temp.vPop{ii}>pop(ii),1,'first'); %��������� (�������) �������
            ciSig(ii)=find(DiffNMR.temp.vSig{ii}>sig(ii),1,'first');
            ciCD(ii)=find(DiffNMR.temp.vCD{ii}>coefDiff(ii),1,'first');
        end
    end
    clear temp1 temp2 temp3
end
%���������� ������� ������������������� �������������
DiffNMR.temp.arg{1}(1)=[]; %������� ������ �������
DiffNMR.temp.arg{:};
eval(['mlnd=@(' DiffNMR.temp.arg{:} ') ' DiffNMR.temp.term{:} ';'])

if get(handles.rbNelder,'Value')==1
    multilognormaldiff %� ���� ������� ���������� ����� �������-����
    return;
end

for ii=1:100
    cVal=sse(ciPop,ciCD,ciSig); %������� �������� ������������������� ����������
    for kk=1:4
        %disp('�������� �����')
        if DiffNMR.temp.state(kk)
            if rbPop(kk)~=1
                %��� �� ��������� Pop
                if ciPop(kk)+1<lvPop(kk)
                    iiPop=ciPop;
                    iiPop(kk)=iiPop(kk)+1;
                    if sse(iiPop,ciCD,ciSig)<cVal
                        dPop(kk)=+1;
                    else
                        dPop(kk)=0;
                    end
                else
                    dPop(kk)=0;
                end
                if ciPop(kk)-1>0
                    iiPop=ciPop;
                    iiPop(kk)=iiPop(kk)-1;
                    if sse(iiPop,ciCD,ciSig)<cVal
                        dPop(kk)=-1;
                    end
                end
            else
                dPop(kk)=0;
            end
            
            if rbDiff(kk)~=1
                %��� �� ��������� coefDiif
                if ciCD(kk)+1<lvCD(kk)
                    iiCD=ciCD;
                    iiCD(kk)=iiCD(kk)+1;
                    if sse(ciPop,iiCD,ciSig)<cVal
                        dCD(kk)=+1;
                    else
                        dCD(kk)=0;
                    end
                else
                    dCD(kk)=0;
                end
                if ciCD(kk)-1>0
                    iiCD=ciCD;
                    iiCD(kk)=iiCD(kk)-1;
                    if sse(ciPop,iiCD,ciSig)<cVal
                        dCD(kk)=-1;
                    end
                end
            else
                dCD(kk)=0;
            end
            
            if rbSig(kk)~=1
                %��� �� ��������� Sigma
                if ciSig(kk)+1<lvSig(kk)
                    iiSig=ciSig;
                    iiSig(kk)=iiSig(kk)+1;
                    if sse(ciPop,ciCD,iiSig)<cVal
                        dSig(kk)=+1;
                    else
                        dSig(kk)=0;
                    end
                else
                    dSig(kk)=0;
                end
                if ciSig(kk)-1>0
                    iiSig=ciSig;
                    iiSig(kk)=iiSig(kk)-1;
                    if sse(ciPop,ciCD,iiSig)<cVal
                        dSig(kk)=-1;
                    end
                end
            else
                dSig(kk)=0;
            end
            
        end
    end
    
    %��������� �������� �������
        if any(dPop) || any(dCD) || any(dSig)
            %disp('��������� ������� ��������')
            ciPop=ciPop+dPop;
            ciCD=ciCD+dCD;
            ciSig=ciSig+dSig;           
        else
            disp('�������� �����������')
             break;
        end
end

%����� ����������� ��������
expr=' ';
expr2=' ';
for kk=1:4
    if DiffNMR.temp.state(kk)
        if rbPop(kk)~=1
            set(eval(['handles.edPop' num2str(kk)]),'String',num2str(DiffNMR.temp.vPop{kk}(ciPop(kk))))
        end
        if rbSig(kk)~=1
            set(eval(['handles.edSig' num2str(kk)]),'String',num2str(DiffNMR.temp.vSig{kk}(ciSig(kk))))
        end
        if rbDiff(kk)~=1
            set(eval(['handles.edDiff' num2str(kk)]),'String',num2str(DiffNMR.temp.vCD{kk}(ciCD(kk))))
        end
        expr=[expr '+' num2str(DiffNMR.temp.vPop{kk}(ciPop(kk))) '*lognpdf(x,log('...
            num2str(DiffNMR.temp.vCD{kk}(ciCD(kk)))...
            '),' num2str(DiffNMR.temp.vSig{kk}(ciSig(kk))) ')'];
        expr2=[expr2 num2str(DiffNMR.temp.vPop{kk}(ciPop(kk)))...
            ',g,' num2str(DiffNMR.temp.vCD{kk}(ciCD(kk))) ','...
            num2str(DiffNMR.temp.vSig{kk}(ciSig(kk))) ',' ];        
    end
end
expr2(end)=[]; %������� ��������� �� ������ �������
eval(['ymultilog = @(x)' expr ';'])
eval(['ymultilogdiff = @(g) mlnd(' expr2 ');'])

 p=DiffNMR.temp.vPop{1}(ciPop(1));
 m=DiffNMR.temp.vCD{1}(ciCD(1));
 s=DiffNMR.temp.vSig{1}(ciSig(1));
    
    %����� ����������� �������� �� ������ � ������������������ �������
    x=DiffNMR.Qdecay{1}(1,1):0.01*DiffNMR.Qdecay{1}(end,1):DiffNMR.Qdecay{1}(end,1);
    %y=lognormaldiff(x,m,s,1);
    y=ymultilogdiff(x);
    plot(x,y,'r-','Parent',DiffNMR.MainAxes)
    
    %����� ������������� �� ������
    
    %x=Expectation/500:Expectation/500:2*Expectation;
    x=log10(coefDiff(1))-6:0.01:log10(coefDiff(1))+3;
    x=power(10,x);
    %y=lognpdf(x,log(m),s);
    y=ymultilog(x);
    cla;
    semilogx(x,y,'Parent',handles.axes1);

rmfield(DiffNMR,'temp');



%���� ��������� ���������� ����������� ������������������ ����������
%����������������� ����� �� ����������� ������
function out=sse(a,m,s)
global DiffNMR;
lnd=@lognormaldiff; %��������������� �������, ����� ������ ���� ������
eval(['mlnd=@(' DiffNMR.temp.arg{:} ') ' DiffNMR.temp.term{:} ';'])
arSimbol=' ';
for ii=1:4
    if DiffNMR.temp.state(ii)
        sk=num2str(ii);
        arSimbol=[arSimbol 'DiffNMR.temp.vPop{' sk '}(a(' sk...
            ')),DiffNMR.Qdecay{1}(:,1),DiffNMR.temp.vCD{' sk...
            '}(m(' sk ')),DiffNMR.temp.vSig{' sk '}(s(' sk ')),'];
    end
end

arSimbol(end)=[]; %������� �������� �� ������ �������
eval(['out=sum(power(DiffNMR.Qdecay{1}(:,2)-mlnd(' arSimbol '),2));'])

%out=sum(power(DiffNMR.Qdecay{1}(:,2)+eval(arSimbol)))
    


