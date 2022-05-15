function [C0b,C1b,C2b] = coeffbin(C0d,C1d,C2d,t,p,q,m)
    C0b = char(zeros(2^m,t+2));
    for i=1:size(C0d,1)
        C0b(i,:) = (dec2bin(abs(C0d(i)),t));
    end

    C1b = char(zeros(2^m,p+2));
    for i=1:size(C1d,1)
        C1b(i,:) = (dec2bin(abs(C1d(i)),p));
    end

    C2b = char(zeros(2^m,q+2));
    for i=1:size(C2d,1)
        C2b(i,:) = (dec2bin(abs(C2d(i)),q));
    end
end