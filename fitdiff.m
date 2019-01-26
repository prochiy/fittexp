function fitdiff(hObject,eventdata,handles)
%������ ������� ��������� �������� ������������, ��������� ���������
%�������� �������� ���� �� �������
global DiffNMR;
if ~strcmp(DiffNMR.Mode,'diff')
    disp('� ������ ������ ��� ������� �� ��������')
    beep;
    return
end
for r=1:8
    eval(['rb(' num2str(r) ')=get(handles.rb' num2str(r) ',' '''Value''' ');'])
end

multiexp=''; %������� ������� ����� ������������ ��������
Nexp=0;      %����������� �������� � ��������
Nprob=0;     %����������� ������������� ����������
Prob = {};   %����� ������������� ����������
StartPoint=[];
ProbPoint={};
APoint=[];
BPoint=[];
%SProbPoint='';
SAPoint=''; SA=''; PA=[];
SBPoint=''; SB=''; PB=[];
Norm=DiffNMR.Qdecay{1}(ceil(DiffNMR.NPoints/2),1);
for r=1:4
    eval(['temp=get(handles.edCoef' num2str(r) ',' '''String''' ');'])
    eval(['temp1=get(handles.edCoefDiff' num2str(r) ',' '''String''' ');'])
    if (~isempty(str2num(temp)))&&(~isempty(str2num(temp1)))
        p(r)=str2num(temp); %����� � ���� ������������
        d(r)=str2num(temp1); %����� � ���� ������������ ��������
        Nexp=Nexp+1;
        eval(['temp=' '''' 'A' num2str(r) '*exp(-B' num2str(r) '*x)' '''' ';' ])
        SA=[SA 'A' num2str(r) ','];
        SB=[SB 'B' num2str(r) ','];
        SAPoint=[SAPoint 'PB(' num2str(r) '),'];
        SBPoint=[SBPoint 'PB(' num2str(r) '),'];
        PA=[PA p(r)];
        PB=[PB d(r)*Norm];
        if r==1
            multiexp =temp;
        else
            multiexp=[multiexp '+' temp];
        end
        if rb(r)==1
            Nprob=Nprob+1;
            eval(['Prob{' num2str(Nprob) '}=' '''' 'A' num2str(r) '''' ';'])
            ProbPoint{Nprob}=p(r);
            %SProbPoint=[SProbPoint 'ProbPoint{' num2str(Nprob) '},'];
        else
            APoint=[APoint p(r)];
        end
        if rb(r+4)==1
            Nprob=Nprob+1;
            eval(['Prob{' num2str(Nprob) '}=' '''' 'B' num2str(r) '''' ';'])
            ProbPoint{Nprob}=d(r)*Norm;
        else
            BPoint=[BPoint d(r)*Norm];
        end    
    end
end


SArg=[SAPoint SBPoint];
SArg(end)=[];
eval(['funfit=@(' SA SB 'x) ' multiexp])

%Norm=DiffNMR.Qdecay{1}(ceil(DiffNMR.NPoints/2),1);
StartPoint=[APoint BPoint];

fun=fittype(multiexp,'independent','x','problem',Prob)
opt=fitoptions('Method','NonlinearLeastSquares');
if get(handles.rbNo,'Value')
    set(opt,'Weights',ones(DiffNMR.NPoints,1))
elseif get(handles.rbN,'Value')
    set(opt,'Weights',DiffNMR.DiffDecay(:,1))
elseif get(handles.rbGrad,'Value')
    set(opt,'Weights',eval(['1./fun(' SArg ',DiffNMR.Qdecay{1}(:,1)./Norm)']))
end
    set(opt,'Algorithm','Trust-Region')
    set(opt,'Normalize','off')
    set(opt,'StartPoint',StartPoint)
    set(opt,'Lower',StartPoint/2)
    set(opt,'Upper',StartPoint*2)
    set(opt,'TolFun',1e-18)
    set(opt,'TolX',1e-15)
    set(opt,'DiffMinChange',1e-12)
    set(opt,'DiffMaxChange',1e-2)
    set(opt,'MaxFunEvals',400)
    set(opt,'Robust','off')
    set(opt,'Display','iter')
    
[fitresult,gof]=fit(DiffNMR.Qdecay{1}(:,1)./Norm,DiffNMR.Qdecay{1}(:,2),...
        fun,opt,'problem',ProbPoint)
%���������� ����� ������������ �������� � ���������� ������������� � ��������� DiiffNMR   
for r=1:4
    if r<=Nexp
        if rb(r)~=1
            eval(['temp=' 'fitresult.A' num2str(r) ';' ])
            eval(['set(handles.edCoef' num2str(r) ',' '''String''' ',' '''' num2str(temp) '''' ')'])
            DiffNMR.Population(r)=temp;
        else
            eval(['temp=get(handles.edCoef' num2str(r) ',' '''String''' ');'])
            DiffNMR.Population(r)=str2double(temp);
        end
        if rb(r+4)~=1
            eval(['temp=' 'fitresult.B' num2str(r) './' num2str(Norm) ';' ])
            eval(['set(handles.edCoefDiff' num2str(r) ',' '''String''' ',' '''' num2str(temp) '''' ')'])
            DiffNMR.CoefDiff(r)=temp;
        else
            eval(['temp=get(handles.edCoefDiff' num2str(r) ',' '''String''' ');'])
            DiffNMR.CoefDiff(r)=str2double(temp);
        end
    else 
        %if exist(DiffNMR.Population(r))
        %    DiffNMR.Population(r)=[];
        %end
        %if exist(DiffNMR.CoefDiff(r))
        %    DiffNMR.CoefDiff(r)=[];
        %end
    end
end

%����� ����������� �������� �� ������
fittexp('mShowFittingResult_Callback',gcbo,[],guidata(gcbo))

%���� ����������� ������� ����� ������������������ ������� �
%� ������ ����������� ���������

set(gcf,'CurrentAxes',handles.axes2)
cla;
for ik=1:DiffNMR.NPoints
    yd=DiffNMR.Qdecay{1}(:,2)-fitresult(DiffNMR.Qdecay{1}(:,1)./Norm);
    if strcmp(get(handles.axes2,'YScale'),'log')
        if gt(DiffNMR.Qdecay{DiffNMR.Step+1}(ik,2),0)
            handles.differens2=plot(DiffNMR.Qdecay{1}(ik,1),yd(ik),'*b');
        else
            handles.differens2=plot(DiffNMR.Qdecay{1}(ik,1),-yd(ik),'*r');
        end
    else
        handles.differens2=plot(DiffNMR.Qdecay{1}(ik,1),yd(ik),'*b');
    end
end
guidata(hObject,handles)
set(gcf,'CurrentAxes',DiffNMR.MainAxes)

