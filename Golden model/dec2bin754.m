function y = dec2bin754(x)
    format long
    
    cond_dec = 0;
    
    int = floor(x);
    frac = x - int;
    
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
    if frac ~=0
        while (cond_dec == 0)
            frac = frac*2;
            if frac >= 1
               fracbin = strcat(fracbin,'1');
               frac = frac - 1;
               cond_dec = 1;
            else
                fracbin = strcat(fracbin,'0');
            end
        end
    end
    
    y = strcat(intbin,'.',fracbin);
end