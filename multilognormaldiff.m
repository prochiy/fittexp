%���� ������ ���������� �������� ������� �������-����

temp1='';
kk=0;
for ii=1:4
    if DiffNMR.temp.state(ii)==true
        if rbPop(ii)~=1
            kk=kk+1;
            temp1=[temp1 'x(' num2str(kk) '),'];
            x(kk)=pop(ii);
        else
            temp1=[temp1 'pop(' num2str(ii) '),'];
        end
        
        temp1=[temp1 'DiffNMR.Qdecay{1}(:,1),'];

        if rbDiff(ii)~=1
            kk=kk+1;
            temp1=[temp1 'exp(x(' num2str(kk) ')),']; %����� ���������� ��� ������������������ ������� �� ���������
            x(kk)=log(coefDiff(ii));
        else
            temp1=[tempm 'coefDiff(' num2str(ii) '),'];
        end
        
        if rbSig(ii)~=1
            kk=kk+1;
            temp1=[temp1 'x(' num2str(kk) '),'];
            x(kk)=sig(ii);
        else
            temp1=[temp1 'sig(' num2str(ii) '),'];
        end
    end  
end
lVec=kk;
temp1(end)=[]; %������� ��������� �� ������ �������
eval(['msse=@(x) ' 'sum(power(DiffNMR.Qdecay{1}(:,2)-mlnd(' temp1 '),2));'])
%������ ��� ��������
inDiv=0.01;
a=1;
b=0.5;
g=2.8;
%������ ��������� �����
for kk=2:lVec+1
    x(kk,:)=x(1,:);
    x(kk,kk-1)=x(kk,kk-1)+x(kk,kk-1)*inDiv;
end
if get(handles.rbLow,'value')==1
    accurucy=1e-8;
else
    accurucy=1e-12;
end

for ii=1:1000
    %������� ������ ������ �������� � ���������� ��������
    for kk=1:lVec+1
        fx(kk)=msse(x(kk,:));
    end
    [fxh,h]=max(fx);
    [fxl,imin]=min(fx);
    %������� ����� �������
    x(lVec+2,:)=1/lVec*(sum(x(1:lVec+1,:))-x(h,:));
    %������������ ������������� ������������ ����� ����� ����� �������
    x(lVec+3,:)=x(lVec+2,:)+a*(x(lVec+2,:)-x(h,:));
    %��������� �������� ���������� ������� x(lVec+3,:)-x(lVec+2,:)
    x(lVec+4,:)=x(lVec+2,:)+g*(x(lVec+3,:)-x(lVec+2,:));
    if msse(x(lVec+4,:))<fxl
        x(h,:)=x(lVec+4,:);
    else
        for kk=1:lVec+1
            temp=(msse(x(lVec+4,:))>msse(x(kk,:)))&&(kk~=h);
        end
        if all(temp)==true
            %������� ������ x(imax,:)-x(lVec+2,:)
            x(lVec+5,:)=x(lVec+2,:)+b*(x(h,:)-x(lVec+2,:));
            x(h,:)=x(lVec+5,:);
        else
            %��������� ��� ������� � ��� ����
            for kk=1:lVec+1
                x(kk,:)=0.5*x(kk,:)+0.5*x(imin,:);
            end
        end
        temp=[];
    end
    for kk=1:lVec
        temp=sum(power(x(kk,:)-x(lVec+2,:),2));
    end
    if max(temp)<accurucy
        disp(['���������� ���������, ��������� �������� ���������� �� �������� ' num2str(ii)])
        break
    end
    temp=[];
end
x=x(kk,:);
% ������� ������� ��� ������ ������
temp1='';
temp2='';
kk=0;
for ii=1:4
    if DiffNMR.temp.state(ii)==true
        if rbPop(ii)~=1
            kk=kk+1;
            temp1=[temp1 'x(' num2str(kk) '),'];
            set(eval(['handles.edPop' num2str(ii)]),'String',num2str(x(kk)));
            temp2=[temp2 '+x(' num2str(kk) ')'];
        else
            temp1=[temp1 'pop(' num2str(ii) '),'];
            temp2=[temp2 '+pop(' num2str(ii) ')'];
        end
        
        temp1=[temp1 'g,'];
        temp2=[temp2 '*lognpdf(g,'];

        if rbDiff(ii)~=1
            kk=kk+1;
            temp1=[temp1 'exp(x(' num2str(kk) ')),']; %����� ���������� ��� ������������������ ������� �� ���������
            set(eval(['handles.edDiff' num2str(ii)]),'String',num2str(exp(x(kk))));
            temp2=[temp2 'x(' num2str(kk) '),'];
        else
            temp1=[temp1 'coefDiff(' num2str(ii) '),'];
            temp2=[tepm2 'coefDiff(' num2str(ii) '),'];
        end
        
        if rbSig(ii)~=1
            kk=kk+1;
            temp1=[temp1 'x(' num2str(kk) '),'];
            set(eval(['handles.edSig' num2str(ii)]),'String',num2str(x(kk)));
            temp2=[temp2 'x(' num2str(kk) '))'];
        else
            temp1=[temp1 'sig(' num2str(ii) '),'];
            temp2=[temp2 'sig(' num2str(ii) '))'];
        end
    end  
end
temp1(end)=[]; %������� ��������� �� ������ �������
temp2(1)=[];   %������� ������ �� ������ ���� 

eval(['ymultilog = @(g) ' temp2 ';'])  %��� �������������
eval(['ymultilogdiff = @(g) mlnd(' temp1 ');']) %����������� �������


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
