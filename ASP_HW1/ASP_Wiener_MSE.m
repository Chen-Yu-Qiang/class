function [j] = ASP_Wiener_MSE(R, w, p, sd2)
if ~all(eig(R) >= 0)
    error("R is not positive semidefinite")
end
Rn=size(R);
pn=size(p);
wn=size(w);
if ~(Rn(1)==Rn(2))
    error("R is not N*N")
end
if ~(Rn(1)==pn(1)) || ~(pn(2)==1)
    error("p is not N*1")
end
if ~(Rn(1)==wn(1)) || ~(wn(2)==1)
    error("w is not N*1")
end
if ~isreal(sd2)
    error("sd2 is not real number")
end
if sd2<0
    error("sd2 < 0")
end
j=real(sd2-w'*p-p'*w+w'*R*w);
end

