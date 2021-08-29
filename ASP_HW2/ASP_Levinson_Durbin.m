function [a,P,kappa] = ASP_Levinson_Durbin(r)
    if r(1)<0
        error("r does not correspond to a valid autocorrelation")
    end
    M=length(r)-1;
    a=cell(1,M);
    P=[r(0+1)];
    a0=1;
    delta=[conj(r(1+1))];
    for m=1:M
        kappa(m)=-delta(m)/P(m);
        if m==1
            a{1}=[a0;0]+kappa(1)*[0;conj(flip(a0))];
        else
            a{m}=[a{m-1};0]+kappa(m)*[0;conj(flip(a{m-1}))];
        end
        P(m+1)=P(m)*(1-(abs(kappa(m)))^2);
        if m<M
            rbtm=flip(conj(r(2:m+2).'));
            delta(m+1)=rbtm*a{m};
        end
    end
end