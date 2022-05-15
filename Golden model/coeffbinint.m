function [C0b,C1b,C2b] = coeffbinint(C0i,C1i,C2i,m)
    aux = ceil(log2(C0i(1)));
    C0b = char(zeros(2^m,aux));
    for i=1:size(C0i,1)
        C0b(i,:) = (dec2bin(abs(C0i(i)),0));
    end

    aux = ceil(log2(abs(C1i(1))));
    C1b = char(zeros(2^m,aux));
    for i=1:size(C1i,1)        
        C1b(i,:) = (dec2bin(abs(C1i(i)),0));
    end

    aux = ceil(log2(abs(C2i(1))));
    C2b = char(zeros(2^m,aux));
    for i=1:size(C2i,1)
        C2b(i,:) = (dec2bin(abs(C2i(i)),0));
    end
end