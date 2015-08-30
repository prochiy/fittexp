function a = lognormaldiff(g,m,s,p)
%m=log(D)-log(Sigma/D+1)/2;
%s=sqrt(log(Sigma/D+1));

z=size(g);
pmax=m*2*exp(-s/p); %позиция максимума логнормального распределения
pstart=log(pmax)-10*s/p;
pend=log(pmax)+6*s/p;

% x=log10(m)-7:0.01:log10(m)+3;
% x=power(10,x);
% ii=1:1000;

x=pstart:(pend-pstart)/300:pend;
x=power(exp(1),x);
ii=1:300; 

dx(ii)=x(ii+1)-x(ii);
M=log(m);


%интеграл считается методом прямоугольников
% for n=1:z(1)
%     for k=1:z(2)
%         a(n,k)=sum(lognpdf(x(ii),log(m),s/p).*exp(-x(ii)*g(n,k)).*dx(ii));
%     end
% end

%интеграл считается методом трапеций
%алгоритм не оптимизирован
for n=1:z(1)
    for k=1:z(2)
        a(n,k)=sum((lognpdf(x(ii),M,s/p).*exp(-x(ii)*g(n,k))+...
            lognpdf(x(ii+1),M,s/p).*exp(-x(ii+1)*g(n,k)))./2.*dx(ii));
    end
end
