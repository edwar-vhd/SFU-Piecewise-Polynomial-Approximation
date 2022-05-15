function y = dec2hex754(x)
    % The sign
    sign = '0';
    if x < 0
        sign = '1';
        x = x*-1;
    end
        
    num = dec2bin754(x);

    % Get the position of the dot and the 1's
    id_dot = strfind(num(1,:),".");
    id_one = strfind(num(1,:),"1");
   
    % Get the exponent
    if id_dot-id_one(1) == 0
        exp = 0;
        man = num(id_one(1)+1:end);
    elseif id_dot-id_one(1) > 0
        exp = id_dot-id_one(1)-1;
        
        if exp >= 25
            num = dec2bin(x,0);
            man = num(2:26);
        else
            % Recalculate the number
            num = dec2bin(x,25-(id_dot-id_one(1)-1));
            num(:,id_dot)=[];
            man = num(id_one(1)+1:end);
        end
    else
        exp = id_dot-id_one(1);
        
        % Recalculate the number
        num = dec2bin(x,25+(id_one(1)-id_dot));
        man = num(id_one(1)+1:end);
    end    

    % The aproximation to the next...
    if (man(end-1)=='1')
        %man(end)=='1' && man(end-1)=='1' ||...
        %man(end)=='0' && man(end-1)=='1' ||... %* | man(end-1)=='1' && man(end-2)=='1' ||...
        %man(end)=='1' && man(end-1)=='1' && man(end-2)=='1'
    
        man = dec2bin(bin2dec(strcat(man(1:end-2),'.0'))+1,0);
        
        if size(man,2) < 23
            man = strcat(char(zeros(1,23-size(man,2))+48),man);
        elseif size(man,2) > 23
            man = man(2:end);
            exp = exp+1;
        end
    else
        man = man(1:end-2);
    end
    
    % Normalization of the exponent
    exp = dec2bin(exp+127,0);
    if size(exp,2)<8
        exp = strcat(char(zeros(1,8-size(exp,2))+48),exp);
    end
    
    res = strcat(sign,exp,man);

    % Get the representation in hexadecimal
    y = '';
    while size(res,2)~=0
        if res(1:4)=="1010"
            y = strcat(y,'A');
        elseif res(1:4)=="1011"
            y = strcat(y,'B');
        elseif res(1:4)=="1100"
            y = strcat(y,'C');
        elseif res(1:4)=="1101"
            y = strcat(y,'D');
        elseif res(1:4)=="1110"
            y = strcat(y,'E');
        elseif res(1:4)=="1111"
            y = strcat(y,'F');
        else
            y = strcat(y,char(bin2dec(strcat(res(1:4),'.0'))+48));
        end
        res(1:4)=[];
    end
end