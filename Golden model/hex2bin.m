function y = hex2bin(x)
    y = '';
    for i=1:size(x,2)
        if x(i)=='0'
            y = strcat(y,"0000");
        elseif x(i)=='1'
            y = strcat(y,"0001");
        elseif x(i)=='2'
            y = strcat(y,"0010");
        elseif x(i)=='3'
            y = strcat(y,"0011");
        elseif x(i)=='4'
            y = strcat(y,"0100");
        elseif x(i)=='5'
            y = strcat(y,"0101");
        elseif x(i)=='6'
            y = strcat(y,"0110");
        elseif x(i)=='7'
            y = strcat(y,"0111");
        elseif x(i)=='8'
            y = strcat(y,"1000");
        elseif x(i)=='9'
            y = strcat(y,"1001");
        elseif x(i)=='a' || x(i)=='A'
            y = strcat(y,"1010");
        elseif x(i)=='b' || x(i)=='B'
            y = strcat(y,"1011");
        elseif x(i)=='c' || x(i)=='C'
            y = strcat(y,"1100");
        elseif x(i)=='d' || x(i)=='D'
            y = strcat(y,"1101");
        elseif x(i)=='e' || x(i)=='E'
            y = strcat(y,"1110");
        elseif x(i)=='f' || x(i)=='F'
            y = strcat(y,"1111");
        end
    end
end