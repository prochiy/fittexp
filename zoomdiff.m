%данный функци€ отвечает за увеличени рисунка
function zoomdiff(hObject,handles,flag)
global DiffNMR;

if eq(get(handles.tgZoom,'Value'),1)
      DiffNMR.Click=1;
      if strcmp(flag,'down')
          %set(gcf,'Pointer','arosshair')
          DiffNMR.FirstPoint=get(DiffNMR.MainAxes,'CurrentPoint'); %координаты точки по нажатию мыши
                    
      end
  
      if strcmp(flag,'up')
          %set(gcf,'Pointer','arrow')
          DiffNMR.SecondPoint=get(DiffNMR.MainAxes,'CurrentPoint');%координаты точки по отпусканию мыши
          DiffNMR.Click=0;
          if strcmp(get(handles.MainFigure,'SelectionType'),'normal')
              ymin=min([DiffNMR.FirstPoint(1,1) DiffNMR.SecondPoint(1,1)]);
              ymax=max([DiffNMR.FirstPoint(1,1) DiffNMR.SecondPoint(1,1)]);
              xmin=min([DiffNMR.FirstPoint(1,2) DiffNMR.SecondPoint(1,2)]);
              xmax=max([DiffNMR.FirstPoint(1,2) DiffNMR.SecondPoint(1,2)]);
              if eq(DiffNMR.FirstPoint,DiffNMR.SecondPoint)
                  return; % в случае если пользователь делает медленно двойной щелчок мышкой.
              end
              set(handles.axes1,'XLim',[ymin ymax]);
              set(handles.axes1,'YLim',[xmin xmax]);
          elseif strcmp(get(handles.MainFigure,'SelectionType'),'open')
              set(handles.axes1,'XLim',DiffNMR.InitialAxisXLim);
              set(handles.axes1,'YLim',DiffNMR.InitialAxisYLim);
          elseif strcmp(get(handles.MainFigure,'SelectionType'),'alt')
              XLim=get(DiffNMR.MainAxes,'XLim');
              YLim=get(DiffNMR.MainAxes,'YLim');
              XMin=XLim(1)-0.2*(DiffNMR.FirstPoint(1,1)-XLim(1));
              XMax=XLim(2)+0.2*(XLim(2)-DiffNMR.FirstPoint(1,1));
              YMin=YLim(1)/power((DiffNMR.FirstPoint(1,2)/YLim(1)),0.2);
              YMax=YLim(2)*power((YLim(2)/DiffNMR.FirstPoint(1,2)),0.2);
              set(DiffNMR.MainAxes,'XLim',[XMin XMax])
              set(DiffNMR.MainAxes,'YLim',[YMin YMax])
          end
      else
          return;
      end
      handles.CurrentAxisXlim=get(DiffNMR.MainAxes,'XLim');
      handles.CurrentAxisYlim=get(DiffNMR.MainAxes,'YLim');
      guidata(hObject,handles);
  
end  