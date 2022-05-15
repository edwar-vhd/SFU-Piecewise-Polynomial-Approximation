function y = bin2dec(x)
    format long
    
    b = strsplit(x,".");

    intbin = char(b(1)); 
    fracbin = char(b(2));
    
    int = 0;
    frac = 0;
        
    % Integer part
    if size(intbin,2) > 1
        intbin = fliplr(intbin);
        for i=size(intbin,2):-1:1
            int = int + str2double(intbin(i))*2^(i-1);
        end
    else
        if str2double(intbin) == 1
            int = 1;
        end
    end
    
    % Fractional part
    if size(fracbin,2) > 0
        for i=1:size(fracbin,2)
            frac = frac + str2double(fracbin(i))*2^-i;
        end
    end
    y = int + frac;
end