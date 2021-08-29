function [y,w,e] = ASP_NLMS(u, x, d)
    M=5;
    N=length(x);
    w=zeros(M,N);
    x=[zeros(M-1,1);x];
    y=[];
    e=[];
    for i=1:N
       xx=flipud(x(i:i+M-1));
       y(i)=w(:,i)'*xx;
       e(i)=d(i)-y(i);
       w(:,i+1)=w(:,i)+(u/(xx'*xx))*xx*conj(e(i));
    end
    y=y.';
    e=e.';
end

