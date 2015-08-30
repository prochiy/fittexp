% ������ �������� ���������� ������������� ���� ������ ��� �������������
% ��� � �������
function phasediff(hObject,eventdata,handles,flag)
global DiffNMR;
if (~strcmp(DiffNMR.Mode,'spec'))||(get(handles.tgCarry,'Value')==1)||(get(handles.tgZoom,'Value'))
    disp('� ������ ������� �������������� ���� ������, ������ �����-�� ������')
    %beep
    return
end

    
i=sqrt(-1); %������ �������
switch flag
    case 'avto'
        QTEMP2 = optimset;
        %QTEMP2.Display = 'iter';
        tic
        DiffNMR.fase1startIndex = round(DiffNMR.size1last/2);
        for ii=1:DiffNMR.size2last
            DiffNMR.Spec1D=DiffNMR.newspec.Spectrum(ii,:);
            [QTEMP1] = fminsearch('ACMEentropy_fun', [DiffNMR.fase0, DiffNMR.fase1],QTEMP2, DiffNMR.Spec1D, DiffNMR.fase1startIndex);
            disp(['Automatic phasing took ' num2str(toc) ' seconds']);
            DiffNMR.dph0 = QTEMP1(1);
            DiffNMR.dph1 = QTEMP1(2);
            %make sure QmatNMR.fase0 is within the range [-180 180]
            while (abs(DiffNMR.fase0 + DiffNMR.dph0) > 180)
                if ((DiffNMR.fase0 + DiffNMR.dph0) < 0)
                    DiffNMR.dph0 = DiffNMR.dph0 + 360;
                else
                    DiffNMR.dph0 = DiffNMR.dph0 - 360;
                end
            end
            anum = -((1:DiffNMR.size1last)-DiffNMR.fase1startIndex)/DiffNMR.size1last;
            DiffNMR.newspec.Spectrum(ii,:)=DiffNMR.Spec1D(:).*exp(i*pi/180*(DiffNMR.dph0+anum(:)*DiffNMR.dph1));
        end
        DiffNMR.Spec1D=DiffNMR.newspec.Spectrum(DiffNMR.NSpec,:);
        DiffNMR.Axis1D=DiffNMR.newspec.AxisTD2;
        cla;
        plot(DiffNMR.Axis1D,real(DiffNMR.Spec1D),'-b')
        
    case 'avto0'
        tic
        DiffNMR.fase1startIndex = round(DiffNMR.size1last/2);
        for ii=1:DiffNMR.size2last
            DiffNMR.Spec1D=DiffNMR.newspec.Spectrum(ii,:);
            for nn=1:360
                spec(nn,:)=DiffNMR.Spec1D*exp(i*nn/180*pi);
                m(nn)=sum(real(spec(nn,:)));
            end
            [maxm,I]=max(real(m));
            anum = -((1:DiffNMR.size1last)-DiffNMR.fase1startIndex)/DiffNMR.size1last;
            DiffNMR.newspec.Spectrum(ii,:)=DiffNMR.Spec1D(:).*exp(i*pi/180*I);
        end
        DiffNMR.Spec1D=DiffNMR.newspec.Spectrum(DiffNMR.NSpec,:);
        DiffNMR.Axis1D=DiffNMR.newspec.AxisTD2;
        cla;
        plot(DiffNMR.Axis1D,real(DiffNMR.Spec1D),'-b')
        
    case 'down'
        DiffNMR.FirstPoint = get(DiffNMR.MainFigure,'CurrentPoint');
    case 'motion'
        DiffNMR.SecondPoint = get(DiffNMR.MainFigure,'CurrentPoint');
        shift=DiffNMR.SecondPoint(1,2)-DiffNMR.FirstPoint(1,2);
        DiffNMR.FirstPoint=DiffNMR.SecondPoint;
        sens=0.5;
        if DiffNMR.NSpec == 1;
            DiffNMR.newspec.Spectrum = DiffNMR.newspec.Spectrum*exp(i*pi/180/sens*shift);
        else
            DiffNMR.newspec.Spectrum(DiffNMR.NSpec,:)=DiffNMR.newspec.Spectrum(DiffNMR.NSpec,:)*exp(i*pi/180/sens*shift);
        end
        DiffNMR.Spec1D=DiffNMR.newspec.Spectrum(DiffNMR.NSpec,:);
        DiffNMR.Axis1D=DiffNMR.newspec.AxisTD2;
        cla;
        plot(DiffNMR.Axis1D,real(DiffNMR.Spec1D),'-b')
        
    case 'up'
end