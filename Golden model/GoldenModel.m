% -------------------------------------------------------------------------
% Set the input value and select the function
% -------------------------------------------------------------------------

%input = dec2hex754(10);   % Input in decimal format
input = 'C23A36C1';      % Input in IEEE-754 format
func = 10;

% -------------------------------------------------------------------------
func_act = func;
func_rro = func;

functions = [   "reci",...          -- 1
                "sqrt_1_2",...      -- 2
                "sqrt_2_4",...      --
                "reci_sqrt_1_2",... -- 4
                "reci_sqrt_2_4",... --
                "exp",...           -- 6
                "ln2",...           -- 7
                "ln2e0",...         --
                "sin"...            -- 9
                "cos"]...           -- 10
                ;
[LUTC0,LUTC1,LUTC2,m] = loadLUTs(func);

% -------------------------------------------------------------------------
% RRO
% -------------------------------------------------------------------------
if (func == 6)                    % If function is 2^x
    input = char(hex2bin(input));

    s = input(1);
    exp = input(2:9);
    man = input(10:end);

    % Too big exponent
    if (bin2dec(strcat(exp,".0"))>133)
        man = strcat('1','11111111','00000000000000000000000');

        vec = 1:32;
        for i=1:size(man,2)
            vec(i)=man(i)-48;
        end

        input = binaryVectorToHex(vec);
    else
        man = strcat("001",man,char(zeros(1,6)+48));
        man = strcat(char(zeros(1,133-bin2dec(strcat(exp,".0")))+48),man(1:end-(133-bin2dec(strcat(exp,".0")))))

        % XOR
        for i=1:size(man,2)
            if man(i)=='0' && s=='0'
                man(i)='0';
            elseif man(i)=='0' && s=='1'
                man(i)='1';
            elseif man(i)=='1' && s=='0'
                man(i)='1';
            else
                man(i)='0';
            end
        end

        man = bin2dec(strcat(man,'.0'))+bin2dec(strcat(s,".0"));
        man = dec2bin(man,0);

        if (size(man,2))~=32
            man = strcat(char(zeros(1,32-size(man,2))+48),man);
        end

        man = strcat('0',man(2:end));

        vec = 1:32;
        for i=1:size(man,2)
            vec(i)=man(i)-48;
        end

        input = binaryVectorToHex(vec);
    end
elseif (func == 9 || func == 10)                    % If function is sin/cos
    input = hex754_2dec(input);

    if (input>0)
      s = '0';
    else
        input = input*-1;
        s = '1';
    end

    % Vueltas
    if (input > pi()*2)
        vueltas = floor(input/(pi()*2));
        input = input-(pi()*2*vueltas);
    end

    % Cuadrante
    if (input>0 && input<=(pi()/2))
        Q='00';
    elseif(input>pi()/2 && input<=pi())
        Q='01';
    elseif(input>pi() && input<=((3*pi())/2))
        Q='10';
    else
        Q='11';
    end

    % Reducción al primer cuadrante
    if (Q=="01")
        input=input-(pi()/2);
	  elseif (Q=="10")
        input=input-pi();
    elseif (Q=="11")
        input=input-((3*pi())/2);
    end

    input=erase(dec2bin(input,23),'.');
    input=strcat(s,Q,'00000',input);

    vec = 1:32;
    for i=1:size(input,2)
        vec(i)=input(i)-48;
    end

    input = binaryVectorToHex(vec);
end

% -------------------------------------------------------------------------
% Adjust the LUTs
% -------------------------------------------------------------------------
if func == 2                                    % For function srqt
    aux = char(hex2bin(input));
    if aux(9) == '0' && func_act == 2           % If the exponent is even (range 2-4)
        [LUTC0,LUTC1,LUTC2,m] = loadLUTs(3);
        func_act = 3;
    elseif aux(9) == '1' && func_act == 3       % If the exponent is odd (range 1-2)
        [LUTC0,LUTC1,LUTC2,m] = loadLUTs(2);
        func_act = 2;
    end
elseif func == 4                                % For function 1/srqt
    aux = char(hex2bin(input));
    if aux(9) == '0' && func_act == 4           % If the exponent is even (range 2-4)
        [LUTC0,LUTC1,LUTC2,m] = loadLUTs(5);
        func_act = 5;
    elseif aux(9) == '1' && func_act == 5       % If the exponent is odd (range 1-2)
        [LUTC0,LUTC1,LUTC2,m] = loadLUTs(4);
        func_act = 4;
    end
elseif func == 7                                % For function log2
    aux = char(hex2bin(input));
    aux = bin2dec(strcat(aux(2:9),'.0'))-127;
    if aux == 0 && func_act == 7
        [LUTC0,LUTC1,LUTC2,m] = loadLUTs(8);
        func_act = 8;
    elseif aux ~= 0 && func_act == 8
        [LUTC0,LUTC1,LUTC2,m] = loadLUTs(7);
        func_act = 7;
    end
elseif func == 9                                % For function sin
    aux = char(hex2bin(input));
    % Adjust according to the RRO format
    if  (aux(1) == '0' && aux(2) == '0' && aux(3) == '1') ||...
        (aux(1) == '0' && aux(2) == '1' && aux(3) == '1') ||...
        (aux(1) == '1' && aux(2) == '0' && aux(3) == '1') ||...
        (aux(1) == '1' && aux(2) == '1' && aux(3) == '1')
        func_rro = 10;
    else
        func_rro = 9;
    end

    % Adjust according to the number
    if func_rro == 9
        aux = bin2dec(strcat(aux(9),'.',aux(10:end)));
        if aux>=1 && func_act == 9
            [LUTC0,LUTC1,LUTC2,m] = loadLUTs(10);
            func_act = 10;
        elseif aux<1 && func_act == 10
            [LUTC0,LUTC1,LUTC2,m] = loadLUTs(9);
            func_act = 9;
        end
    elseif func_rro == 10
        aux = bin2dec(strcat(aux(9),'.',aux(10:end)));
        if aux>=1 && func_act == 10
            [LUTC0,LUTC1,LUTC2,m] = loadLUTs(9);
            func_act = 9;
        elseif aux<1 && func_act == 9
            [LUTC0,LUTC1,LUTC2,m] = loadLUTs(10);
            func_act = 10;
        end
    end
elseif func == 10                               % For function cos
    aux = char(hex2bin(input));
    % Adjust according to the RRO format
    if  (aux(1) == '0' && aux(2) == '0' && aux(3) == '1') ||...
        (aux(1) == '0' && aux(2) == '1' && aux(3) == '1') ||...
        (aux(1) == '1' && aux(2) == '0' && aux(3) == '1') ||...
        (aux(1) == '1' && aux(2) == '1' && aux(3) == '1')
        func_rro = 9;
    else
        func_rro = 10;
    end

    % Adjust according to the number
    if func_rro == 10
        aux = bin2dec(strcat(aux(9),'.',aux(10:end)));
        if aux>=1 && func_act == 10
            [LUTC0,LUTC1,LUTC2,m] = loadLUTs(9);
            func_act = 9;
        elseif aux<1 && func_act == 9
            [LUTC0,LUTC1,LUTC2,m] = loadLUTs(10);
            func_act = 10;
        end
    elseif func_rro == 9
        aux = bin2dec(strcat(aux(9),'.',aux(10:end)));
        if aux>=1 && func_act == 9
            [LUTC0,LUTC1,LUTC2,m] = loadLUTs(10);
            func_act = 10;
        elseif aux<1 && func_act == 10
            [LUTC0,LUTC1,LUTC2,m] = loadLUTs(9);
            func_act = 9;
        end
    end
end

% -------------------------------------------------------------------------
% Adjust the number
% -------------------------------------------------------------------------
if func == 6                        % For function 2^x
    aux = char(hex2bin(input));
    man = aux(10:end);
elseif func == 9                    % For function sin
    aux = char(hex2bin(input));
    % Adjust the sign according to the RRO format
    if  (aux(1) == '0' && aux(2) == '1' && aux(3) == '0') ||...
        (aux(1) == '0' && aux(2) == '1' && aux(3) == '1') ||...
        (aux(1) == '1' && aux(2) == '0' && aux(3) == '0') ||...
        (aux(1) == '1' && aux(2) == '0' && aux(3) == '1')
        s = '1';
    else
        s = '0';
    end

    aux = bin2dec(strcat(aux(9),'.',aux(10:end)));
    if aux>=1
        Pi_2 = bin2dec('110010010000111111011011.0');   %PI/2 truncated at 23 bits

        man = char(hex2bin(input));
        man = man(9:end);
        man = bin2dec(strcat(man,'.0'));

        man = Pi_2-man;
        man = dec2bin(man,0);
        man = strcat(char(zeros(1,23-size(man,2))+48),man);
    else
        man = char(hex2bin(input));
        man = man(10:end);
    end
elseif func == 10                   % For function cos
	aux = char(hex2bin(input));
    % Adjust the sign according to the RRO format
    if  (aux(1) == '0' && aux(2) == '0' && aux(3) == '1') ||...
        (aux(1) == '0' && aux(2) == '1' && aux(3) == '0') ||...
        (aux(1) == '1' && aux(2) == '0' && aux(3) == '1') ||...
        (aux(1) == '1' && aux(2) == '1' && aux(3) == '0')
        s = '1';
	else
        s = '0';
    end

    aux = bin2dec(strcat(aux(9),'.',aux(10:end)));
    if aux>=1
        Pi_2 = bin2dec('110010010000111111011011.0');   %PI/2 truncated at 23 bits

        man = char(hex2bin(input));
        man = man(9:end);
        man = bin2dec(strcat(man,'.0'));

        man = Pi_2-man;
        man = dec2bin(man,0);
        man = strcat(char(zeros(1,23-size(man,2))+48),man);
    else
        man = char(hex2bin(input));
        man = man(10:end);
    end
else
    number = char(hex2bin(input));
    s = number(1);
    exp = number(2:9);
    man = number(10:end);
end

% -------------------------------------------------------------------------
% Evaluate the LUTs
% -------------------------------------------------------------------------
x1 = bin2dec(strcat(man(1:m),'.0'))+1;
x2 = floor(bin2dec(strcat('0.',char(zeros(1,m)+48),man(m+1:end)))*2^23);

% Get the value from the bus of LUTs
C0 = LUTC0(x1,:);
C1 = LUTC1(x1,:);
C2 = LUTC2(x1,:);

sign = [1 -1];
operation = bin2dec(strcat(C0(2:end),'.0'))*2^14*sign(str2double(C0(1))+1)+...
            bin2dec(strcat(C1(2:end),'.0'))*x2*sign(str2double(C1(1))+1)+...
            (bin2dec(strcat(C2(2:end),'.0'))*floor(((bin2dec(strcat(man(m+1:end),'.0'))^2)*2^-19)))*2^1*sign(str2double(C2(1))+1);

% -------------------------------------------------------------------------
% Adjust the result
% -------------------------------------------------------------------------
if func == 1                        % If function is reci
    res = dec2hex754((operation*2^-41)*(2^-(bin2dec(strcat(exp,'.0'))-127))*sign(str2double(s)+1));
    %res = dec2hex754((operation)*(2^-(bin2dec(strcat(exp,'.0'))-127))*sign(str2double(s)+1));
elseif func == 2                    % If function is sqrt
    if func_act == 2
        res = dec2hex754((operation*2^-41)*(2^((bin2dec(strcat(exp,'.0'))-127)/2)));
    else
        res = dec2hex754((operation*2^-41)*(2^((bin2dec(strcat(exp,'.0'))-127-1)/2)));
    end
elseif func == 4                    % If function is 1/sqrt
    if func_act == 4
        res = dec2hex754((operation*2^-41)*(2^-((bin2dec(strcat(exp,'.0'))-127)/2)));
    else
        res = dec2hex754((operation*2^-41)*(2^-((bin2dec(strcat(exp,'.0'))-127-1)/2)));
    end
elseif func == 6                    % If function is 2^x
    aux = char(hex2bin(input));
    if aux(2) == '1'
        aux = aux(2:9);
        for i=1:size(aux,2)
            if aux(i) == '0'
                aux(i) = '1';
            else
                aux(i) = '0';
            end
        end
        exp = (bin2dec(strcat(aux,'.0'))+1)*-1;
    else
        exp = bin2dec(strcat(aux(2:9),'.0'));
    end
    res = dec2hex754((operation*2^-41)*(2^(exp)));
elseif func == 7    % If function is log2
    if func_act == 8
        res = dec2hex754((operation*2^-41)*(hex754_2dec(input)-1));
	else
        res = dec2hex754((operation*2^-41)+(bin2dec(strcat(exp,'.0'))-127));
    end
elseif func == 9 || func == 10      % For function sin or cos
    res = dec2hex754(operation*2^-41*sign(str2double(s)+1));
end

% -------------------------------------------------------------------------
% Exceptions
% -------------------------------------------------------------------------
if func == 6                        % For function 2^x
    input = char(hex2bin(input));

    s = input(1);
    exp = input(2:9);
    man = input(10:end);

    if (s=='1' && exp=="00000000")
        res=binaryVectorToHex([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]);
    elseif (s=='1' && exp=="11111111")
        res=strcat('0',exp,man);

        vec = 1:32;
        for i=1:size(res,2)
            vec(i)=res(i)-48;
        end

        res = binaryVectorToHex(vec);
    end
end
disp(res)
disp(hex754_2dec(res))
