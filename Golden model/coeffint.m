function [C0i,C1i,C2i] = coeffint(C0d,C1d,C2d,t,p,q)
    C0i = floor(C0d*(2^t));

    C1i = floor(C1d*(2^(p)));
    
    C2i = floor(C2d*(2^(q)));
end