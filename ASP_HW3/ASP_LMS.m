function [y,w,e,b] = ASP_LMS(u, x, d)
    M=5;
    N=length(x);
    w=zeros(M,N);
    x=[zeros(M-1,1);x];
    y=[];
    e=[];
    b=[];
    for i=1:N
       y(i)=w(:,i)'*flipud(x(i:i+M-1));
       e(i)=d(i)-y(i);
       w(:,i+1)=w(:,i)+u*flipud(x(i:i+M-1))*conj(e(i));
       aaa=flipud(x(i:i+M-1));
       b(i)=aaa'*aaa;
    end
    y=y.';
    e=e.';
    b=min(1./b)
end

