function [y,w,e]  = ASP_RLS(delta, lambda, x, d)
    M=5;
    N=length(x);
    w=zeros(M,N);
    x=[zeros(M-1,1);x];
    y=[];
    e=[];
    P=(1/delta)*eye(M);
    for i=1:N
       xx=flipud(x(i:i+M-1));
       k=((1/lambda)*P*xx)/(1+(1/lambda)*xx'*P*xx);
       xi=d(i)-w(:,i)'*xx;
       y(i)=w(:,i)'*xx;
       w(:,i+1)=w(:,i)+k*conj(xi);
       P=(1/lambda)*P-(1/lambda)*k*xx'*P;
       e(i)=xi;
    end
    e=e.';
end

