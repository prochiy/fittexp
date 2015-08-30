function a = gausdiff(t,d,s)
    N=100;
    n=1:2*N+1;
    D(n)=d*n/N;
    A0=sum(exp(-(D-d)/(2*s^2)));
    z=size(t);
    for m=1:z(1)
        for n=1:z(2)
            a(m,n)=1./A0*sum(exp(-(D-d)/(2*s^2)).*exp(-t(m,n)*D));
        end
    end
 