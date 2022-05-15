function y = dec2bin(x,nd)
    format long
    
    int = floor(x);
    frac = x - int;
    nd_aux = nd;
    
    intbin = '';
    fracbin = '';
        
    % Integer part
    if int > 0
        while (int>0)
            if mod(int,2) == 1
                intbin = strcat('1',intbin);
                int = floor(int/2);
            else
                intbin = strcat('0',intbin);
                int = floor(int/2);
            end
        end
    else
        intbin = '0';
    end
    
    % Fractional part
    while (nd>0)
        frac = frac*2;
        if frac >= 1
           fracbin = strcat(fracbin,'1');
           frac = frac - 1;
        else
            fracbin = strcat(fracbin,'0');
        end
        nd = nd - 1;
    end
    
    if nd_aux == 0
        y = intbin;
    else
        y = strcat(intbin,'.',fracbin);
    end
end
