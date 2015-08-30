% данная функуция производит корректировку фазы спктра как автоматически
% так и вручную
function hpasediff(hObject,eventdata,handles,flag)
global DiffNMR;
if ~strcmp(DiffNMR.Mode,'spec')
    disp('В данном сулучае корректировать фазу нельзя')
    beep
end
i=sqrt(-1); %мнимая единица
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
end