ov=[];
a=0.3:0.001:0.5;
b=-0.75:0.001:0.75;
for ai=1:length(a)
    for bi=1:length(b)
        sys=tf([1,b(bi)],[(1+b(bi)),(-1.1-b(bi)),(a(ai)+a(ai)*b(bi))],1);
        ov(ai,bi)=stepinfo(sys).Overshoot;        
    end
end
mesh(ov)