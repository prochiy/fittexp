function plotdiff(hObject,eventdata,handles,flag);
global DiffNMR;

if ~strcmp(DiffNMR.Mode,'diff')
    return;
end

if eq(get(handles.tgZoom,'Value'),1)||eq(get(handles.tgCarry,'Value'),1)||eq(DiffNMR.Step,0)
    return
end
DiffNMR.gco=gco;
%guidata(DiffNMR.MainAxes,handles)
set(gcf,'CurrentAxes',DiffNMR.MainAxes)
switch flag 
    case 'first'
        cla;
        set(DiffNMR.MainAxes,'UIContextMenu','')
        set(DiffNMR.MainAxes,'XDir','normal')
        set(DiffNMR.MainAxes,'YScale','Log')
        hold on;
        d=size(DiffNMR.Qdecay{DiffNMR.Step});
        for ik=1:d(1)
            if strcmp(get(DiffNMR.MainAxes,'YScale'),'log')
                if gt(DiffNMR.Qdecay{DiffNMR.Step}(ik,2),0)
                    handles.differens=plot(DiffNMR.Qdecay{DiffNMR.Step}(ik,1),DiffNMR.Qdecay{DiffNMR.Step}(ik,2),'b*',...
                        'ButtonDownFcn',{'plotdiff',guidata(DiffNMR.MainAxes),'down'},'UIContextMenu',handles.cmenu);
                    %else
                    %    handles.differens=plot(DiffNMR.Qdecay{DiffNMR.Step}(ik,1),-DiffNMR.Qdecay{DiffNMR.Step}(ik,2),'*r',...
                    %    'ButtonDownFcn',{'plotdiff',guidata(DiffNMR.MainAxes),'down'},'UIContextMenu',handles.cmenu);
                end
            else
                handles.differens=plot(DiffNMR.Qdecay{DiffNMR.Step}(ik,1),DiffNMR.Qdecay{DiffNMR.Step}(ik,2),'*b',...
                    'ButtonDownFcn',{'plotdiff',guidata(DiffNMR.MainAxes),'down'},'UIContextMenu',handles.cmenu);
            end
        end
        if eq(handles.first,1) %handles.first ��������������� ������ 1 � ������� mOpenFile_Callback(hObject, eventdata, handles)
            axis auto;
            % ������������ ��������� ������� ����, ��� ������� zoomdiff
            DiffNMR.InitialAxisXLim=get(DiffNMR.MainAxes,'XLim');
            DiffNMR.InitialAxisYLim=get(DiffNMR.MainAxes,'YLim');
            handles.CurrentAxisXlim=get(DiffNMR.MainAxes,'XLim');
            handles.CurrentAxisYlim=get(DiffNMR.MainAxes,'YLim');
            handles.first=0;
            %else
            %    set(DiffNMR.MainAxes,'XLim',handles.CurrentAxisXlim)
            %    set(DiffNMR.MainAxes,'YLim',handles.CurrentAxisYlim)
        end
        guidata(hObject,handles); % ��������� ��������� handles
    case 'down'
        DiffNMR.Click=1;
        if ~strcmp(get(DiffNMR.MainFigure,'SelectionType'),'normal')
            return
        end
        %plotdiff(DiffNMR.MainAxes,[],guidata(DiffNMR.MainAxes),'first');
        DiffNMR.FirstPoint=get(DiffNMR.MainAxes,'CurrentPoint');
        handles.FirstPoint=plot(DiffNMR.FirstPoint(1,1),DiffNMR.FirstPoint(1,2),'or',...
            'MarkerSize',10,'ButtonDownFcn',{'plotdiff',guidata(DiffNMR.MainAxes),'down'});
        guidata(DiffNMR.MainAxes,handles);
    case 'up'
        if ~strcmp(get(DiffNMR.MainFigure,'SelectionType'),'normal')
            return
        end
        if handles.FirstPointShift==1
            handles.FirstPointShift=0;
            guidata(hObject,handles)
            DiffNMR.FirstPoint=get(DiffNMR.MainAxes,'CurrentPoint');
            plotdiff(gcbo,[],guidata(gcbo),'plot')
            handles.InitialFirstPoint=DiffNMR.FirstPoint;
            handles.InitialSecondPoint=DiffNMR.SecondPoint;
            guidata(hObject,handles)
        elseif handles.SecondPointShift==1
            handles.SecondPointShift=0;
            guidata(hObject,handles)
            DiffNMR.SecondPoint=get(DiffNMR.MainAxes,'CurrentPoint');
            plotdiff(gcbo,[],guidata(gcbo),'plot')
            handles.InitialFirstPoint=DiffNMR.FirstPoint;
            handles.InitialSecondPoint=DiffNMR.SecondPoint;
            guidata(hObject,handles)
        elseif handles.LineShift==1
            handles.LineShift=0;
            guidata(hObject,handles)
            DiffNMR.ShiftPoint=get(DiffNMR.MainAxes,'CurrentPoint');
            DiffNMR.FirstPoint(1,1)=handles.InitialFirstPoint(1,1)+DiffNMR.ShiftPoint(1,1)-DiffNMR.IntermediatePoint(1,1);
            DiffNMR.FirstPoint(1,2)=handles.InitialFirstPoint(1,2)*DiffNMR.ShiftPoint(1,2)/DiffNMR.IntermediatePoint(1,2);
            DiffNMR.SecondPoint(1,1)=handles.InitialSecondPoint(1,1)+DiffNMR.ShiftPoint(1,1)-DiffNMR.IntermediatePoint(1,1);
            DiffNMR.SecondPoint(1,2)=handles.InitialSecondPoint(1,2)*DiffNMR.ShiftPoint(1,2)/DiffNMR.IntermediatePoint(1,2);
            plotdiff(gcbo,[],guidata(gcbo),'plot')
            handles.InitialFirstPoint=DiffNMR.FirstPoint;
            handles.InitialSecondPoint=DiffNMR.SecondPoint;
            guidata(DiffNMR.MainAxes,handles)
        else
            DiffNMR.SecondPoint=get(DiffNMR.MainAxes,'CurrentPoint');
            plotdiff(gcbo,[],guidata(gcbo),'plot')
            handles.InitialFirstPoint=DiffNMR.FirstPoint;
            handles.InitialSecondPoint=DiffNMR.SecondPoint;
            guidata(hObject,handles) %� ��� ����� ���� ������ �� ���������� ���������� ���������
        end

    case 'motion'
        if ~strcmp(get(DiffNMR.MainFigure,'SelectionType'),'normal')
            return
        end
        if handles.LineShift==1;
            DiffNMR.ShiftPoint=get(DiffNMR.MainAxes,'CurrentPoint');
            DiffNMR.FirstPoint(1,1)=handles.InitialFirstPoint(1,1)+DiffNMR.ShiftPoint(1,1)-DiffNMR.IntermediatePoint(1,1);
            DiffNMR.FirstPoint(1,2)=handles.InitialFirstPoint(1,2)*DiffNMR.ShiftPoint(1,2)/DiffNMR.IntermediatePoint(1,2);
            DiffNMR.SecondPoint(1,1)=handles.InitialSecondPoint(1,1)+DiffNMR.ShiftPoint(1,1)-DiffNMR.IntermediatePoint(1,1);
            DiffNMR.SecondPoint(1,2)=handles.InitialSecondPoint(1,2)*DiffNMR.ShiftPoint(1,2)/DiffNMR.IntermediatePoint(1,2);
            plotdiff(gcbo,[],guidata(gcbo),'plot')
        elseif handles.FirstPointShift==1
            DiffNMR.FirstPoint=get(DiffNMR.MainAxes,'CurrentPoint');
            plotdiff(gcbo,[],guidata(gcbo),'plot')
            %elseif handles.SecondPointShift==1
            %DiffNMR.SecondPoint=get(DiffNMR.MainAxes,'CurrentPoint');
            %plotdiff(gcbo,[],guidata(gcbo),'plot')
        else
            DiffNMR.SecondPoint=get(DiffNMR.MainAxes,'CurrentPoint');
            plotdiff(gcbo,[],guidata(gcbo),'plot')
            handles.InitialFirstPoint=DiffNMR.FirstPoint;
            handles.InitialSecondPoint=DiffNMR.SecondPoint;
            guidata(hObject,handles)
        end
    
    case 'plot'
        plotdiff(gcbo,[],guidata(gcbo),'first');
        if eq((DiffNMR.FirstPoint(1,1)-DiffNMR.SecondPoint(1,1)),0)
            return
        end
        ae=exp((DiffNMR.FirstPoint(1,1)*log(DiffNMR.SecondPoint(1,2))-...
            DiffNMR.SecondPoint(1,1)*log(DiffNMR.FirstPoint(1,2)))/...
            (DiffNMR.FirstPoint(1,1)-DiffNMR.SecondPoint(1,1)));
        be=(log(DiffNMR.SecondPoint(1,2))-log(DiffNMR.FirstPoint(1,2)))/...
            (DiffNMR.SecondPoint(1,1)-DiffNMR.FirstPoint(1,1));
        x=DiffNMR.FirstPoint(1,1):(DiffNMR.SecondPoint(1,1)-DiffNMR.FirstPoint(1,1))/20:DiffNMR.SecondPoint(1,1);
        y=ae*exp(be*x);
        handles.FirstPoint=plot(DiffNMR.FirstPoint(1,1),DiffNMR.FirstPoint(1,2),'or',...
            'MarkerSize',10,'ButtonDownFcn',{'plotdiff',guidata(DiffNMR.MainAxes),'firstpoint'});
        handles.SecondPoint=plot(DiffNMR.SecondPoint(1,1),DiffNMR.SecondPoint(1,2),'or',...
            'MarkerSize',10,'ButtonDownFcn',{'plotdiff',guidata(DiffNMR.MainAxes),'secondpoint'});
        handles.line=plot(x,y,'-r','ButtonDownFcn',{'plotdiff',guidata(DiffNMR.MainAxes),'line'});
        guidata(hObject,handles);
        set(DiffNMR.MainAxes,'XLim',handles.CurrentAxisXlim)
        set(DiffNMR.MainAxes,'YLim',handles.CurrentAxisYlim)
        %DiffNMR.LittleDelta=str2num(get(handles.edLittledelta,'String'))*1e-3;
        %DiffNMR.BigDelta=str2num(get(handles.edBigdelta,'String'))*1e-3;
        DiffNMR.CoefDiff(DiffNMR.Step)=-be;%*(1e-4/(power(2*pi*DiffNMR.Gamma*DiffNMR.LittleDelta,2)*(DiffNMR.BigDelta-DiffNMR.LittleDelta/3)));
        DiffNMR.Population(DiffNMR.Step)=ae;
        switch DiffNMR.Step % ���� ������������� ������� ������ � ���� ������ � ������������
            case 1 % ������� ���� � ����� ���������
                set(handles.edCoefDiff1,'String',num2str(-be));
                set(handles.edCoef1,'String',num2str(ae));
            case 2
                set(handles.edCoefDiff2,'String',num2str(-be));
                set(handles.edCoef2,'String',num2str(ae));
            case 3
                set(handles.edCoefDiff3,'String',num2str(-be));
                set(handles.edCoef3,'String',num2str(ae));
            case 4
                set(handles.edCoefDiff4,'String',num2str(-be));
                set(handles.edCoef4,'String',num2str(ae));
        end

        %���� ����������� ������� ����� ������������������ ������� �
        %����������� ����������� �� ������� ��������� � �����
        set(gcf,'CurrentAxes',handles.axes2)
        cla;
        d=size(DiffNMR.Qdecay{DiffNMR.Step});
        for ik=1:d(1)
            yd=ae*exp(be*DiffNMR.Qdecay{DiffNMR.Step}(ik,1));
            DiffNMR.Qdecay{DiffNMR.Step+1}(ik,1:2)=[DiffNMR.Qdecay{DiffNMR.Step}(ik,1),DiffNMR.Qdecay{DiffNMR.Step}(ik,2)-yd];
            
            if strcmp(get(handles.axes2,'YScale'),'log')
                if gt(DiffNMR.Qdecay{DiffNMR.Step+1}(ik,2),0)
                    handles.differens2=plot(DiffNMR.Qdecay{DiffNMR.Step+1}(ik,1),DiffNMR.Qdecay{DiffNMR.Step+1}(ik,2),'*b');
                else
                    handles.differens2=plot(DiffNMR.Qdecay{DiffNMR.Step+1}(ik,1),-DiffNMR.Qdecay{DiffNMR.Step+1}(ik,2),'*r');
                end
            else
                handles.differens2=plot(DiffNMR.Qdecay{DiffNMR.Step+1}(ik,1),DiffNMR.Qdecay{DiffNMR.Step+1}(ik,2),'*b');
            end
        end
        guidata(hObject,handles)
        set(gcf,'CurrentAxes',DiffNMR.MainAxes)
    
    case 'firstpoint' %���� ������ �� ������ ����� ����������� �����
        handles=guidata(DiffNMR.MainAxes);
        DiffNMR.Click=1;
        handles.FirstPointShift=1;
        guidata(DiffNMR.MainAxes,handles)
   
    case 'secondpoint' %���� ������ �� ������ ����� ����������� �����
        handles=guidata(DiffNMR.MainAxes);
        DiffNMR.Click=1;
        handles.SecondPointShift=1;
        guidata(DiffNMR.MainAxes,handles)
    
    case 'line' %���� ������ �� ���� ����������� �����
        handles=guidata(DiffNMR.MainAxes);
        DiffNMR.Click=1;
        handles.LineShift=1;
        guidata(DiffNMR.MainAxes,handles)
        DiffNMR.IntermediatePoint=get(DiffNMR.MainAxes,'CurrentPoint');
end     
  