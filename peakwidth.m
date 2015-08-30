function w=peakwidth;
%PEAKWIDTH ¬озращет ширину линии спектра.
%–аботает только с одномерными спектрами и с одним широким пиком.
%—пектр считываетс€ из стуктуры QmatNMR рабочего пространства.
global QmatNMR;
if ne(QmatNMR.SizeTD1,1)
    error('Ёта функци€ с двумерными спектрами не работает')
end
xs=QmatNMR.Axis1D;
as=real(QmatNMR.Spec1D);
[maxas,maxxs]=max(as);
size=QmatNMR.Size1D;
an=0;
bn=0;
for i=1:(size-1)
    if xor(lt(as(i),maxas/2),lt(as(i+1),maxas/2))
        if lt(xs(i),xs(maxxs))
            an=an+1;
            ax(an)=xs(i);
        else
            bn=bn+1;
            bx(bn)=xs(i);
        end
    end
end
w=mean(bx)-mean(ax);
disp(['ширина линии = ' num2str(w)]);
