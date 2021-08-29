function [y,w,e] = ASP_LMS(u, x, d)
    M=5;
    N=length(x);
    w=zeros(M,N);
    x=[zeros(M-1,1);x];
    y=[];
    e=[];
    for i=1:N
       y(i)=w(:,i)'*flipud(x(i:i+M-1));
       e(i)=d(i)-y(i);
       w(:,i+1)=w(:,i)+u*flipud(x(i:i+M-1))*conj(e(i));
    end
    y=y.';
    e=e.';
end

