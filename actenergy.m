function energy = actenergy(t,y,c,g)
%ACTENERGY(t,y,c,g) ��������� �������� ������� ��������� � �� �� ����
%��� t �������� ����������� � �������� ��������
%y �������� �������� ��������� �� ����������
%���� �=0 �� ����������� �������� a*exp(b*x)��������� �������� ���
%���� g=1 �� �������� ������ ������������� ��������

if(ne(size(t,2),1))
    t=t';           %����� ������ ���������� � �������, ���� ��� ���� ��������
end                 %� ������� � ���� ������
if(ne(size(y,2),1))
    y=y';
end
invt=rdivide(1,t);
figure;
semilogy(invt,y,'rs');
grid on;
hold on;
if eq(c,0)
   ftype=fittype('exp1');
   opts = fitoptions('Method','LinearLeastSquares')
else
  
  but=1;
  n=1;
  [xi,yi,but] = ginput(1); %����������� ��������� �� ������� ������ ����
  xy(n,:) = [xi,yi];  
  plot(xi,yi,'ro')        %������ ����� ���� �������� ������   
  n = 2;
  while but == 1
    [xi,yi,but] = ginput(1); %����������� ��������� �� ������� ����� ����
    xy(n,:) = [xi,yi] ;
    hold off;  
    semilogy(invt,y,'rs');
    grid on;
    hold on;  
    nn=1:2;
    plot(xy(nn,1),xy(nn,2),'ro')
    ae=exp((xy(1,1)*log(xy(2,2))-xy(2,1)*log(xy(1,2)))/(xy(1,1)-xy(2,1)));
    be=(log(xy(2,2))-log(xy(1,2)))/((xy(2,1)-xy(1,1)));
    x=xy(1,1):(xy(2,1)-xy(1,1))/20:xy(2,1);
    yy=ae*exp(be*x);
    plot(x,yy,'r-'); %��� ������ ������ ���������� �� ���� ������ ���������� ������
  end
 
  
  ftype=fittype('a*exp(-b*x)+c');
  opts = fitoptions('Method','NonlinearLeastSquares','StartPoint',[ae -be 0],...
         'Display','iter','TolFun',1e-19,'TolX',1e-12);
  
end  
mfit=fit(invt,y,ftype,opts);
disp('������� ��������� �����');
if eq(c,0) 
    znak=-1;
else
    znak=1;
end
energy=mfit.b*8.314472*znak
if ne(g,0)
    if or(eq(c,0),eq(c,1))
        plot(invt,y,'rs');
        plot(mfit,'b--');
    else
        plot(invt,y-mfit.c,'rs',invt,mfit.a*exp(-mfit.b*invt))
    end
    grid on;
end
