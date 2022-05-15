% IEEE 754 single-precision floating-point

function [s,e,m] = dec2spfp(x)

    if x == 0
        s = 0;
        e = char(zeros(1,8)+48);
        m = char(zeros(1,23)+48);
    else
        % Sign bit
        if x > 0
            s = 0;
        else
            s = 1;
            x=-x;
        end

        % Exponent
        e = bin(fi((floor(log2(x))+127),0,8,0));

        % Mantissa
        m = bin(fi(((x/(2^(floor(log2(x)))))-1),0,23,23));
    end
end