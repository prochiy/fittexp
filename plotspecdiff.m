% ���� ������� ���������� ���������� � ���������� ������� � ������� ����
% ���������
function plotspecdiff(hObject,eventdata,handles,flag)
global DiffNMR;
set(gcf,'CurrentAxes',DiffNMR.MainAxes)
switch flag
    case 'first'
        
        DiffNMR.Spec1D=DiffNMR.newspec.Spectrum(1,:);
        DiffNMR.Axis1D=DiffNMR.newspec.AxisTD2;
        cla;
        hold on;
        set(gca,'UIContextMenu',handles.cmenu)
        set(gca,'XDir','reverse')
        set(gca,'XScale','Linear','YScale','Linear')
        plot(DiffNMR.Axis1D,real(DiffNMR.Spec1D),'-b')
        axis auto;
        % ������������ ��������� ������� ����, ��� ������� zoomdiff
        DiffNMR.InitialAxisXLim=get(DiffNMR.MainAxes,'XLim');
        DiffNMR.InitialAxisYLim=get(DiffNMR.MainAxes,'YLim');
        handles.CurrentAxisXlim=get(DiffNMR.MainAxes,'XLim');
        handles.CurrentAxisYlim=get(DiffNMR.MainAxes,'YLim');
        axis manual;
        guidata(hObject,handles)
        
    case 'next'
        if ge(DiffNMR.NSpec,DiffNMR.size2last)
            disp('���, ������ �������� � ���� ������������ ���.')
            beep;
        else
            DiffNMR.NSpec=DiffNMR.NSpec+1;
            DiffNMR.Spec1D=DiffNMR.newspec.Spectrum(DiffNMR.NSpec,:);
            DiffNMR.Axis1D=DiffNMR.newspec.AxisTD2;
            cla;
            plot(DiffNMR.Axis1D,real(DiffNMR.Spec1D),'-b')
        end
        
    case 'back'
        if le(DiffNMR.NSpec,1)
            disp('���, ������ �������� � ���� ������������ ���.')
            beep;
        else
            DiffNMR.NSpec=DiffNMR.NSpec-1;
            DiffNMR.Spec1D=DiffNMR.newspec.Spectrum(DiffNMR.NSpec,:);
            DiffNMR.Axis1D=DiffNMR.newspec.AxisTD2;
            cla;
            plot(DiffNMR.Axis1D,real(DiffNMR.Spec1D),'-b')
        end
end
