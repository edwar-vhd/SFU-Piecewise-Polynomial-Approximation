function [LUTC0,LUTC1,LUTC2,m] = loadLUTs(func)
    functions = {   'reci';...          -- 1 (1-2)
                    'sqrt_1_2';...      -- 2 (1-2)
                    'sqrt_2_4';...      -- 3 (2-4)
                    'reci_sqrt_1_2';... -- 4 (1-2)
                    'reci_sqrt_2_4';... -- 5 (2-4)
                    'exp';...           -- 6 (0-1)
                    'ln2';...           -- 7 (1-2)
                    'ln2e0';...         -- 8 (1-2)
                    'sin';...           -- 9 (0-1)
                    'cos'}...           -- 10(0-1)
                    ;

    bus_C0 = 29;
    bus_C1 = 20;
    bus_C2 = 14;

    % Get de look-up-tables of a function
    [C0d,C1d,C2d,t,p,q,m] = coeff(functions{func});

    % Get de look-up-tables in binary
    [C0b,C1b,C2b] = coeffbin(C0d,C1d,C2d,t,p,q,m);

    % Get bits to storage from binary look-up-tables
    [C0i,C0i_concat,C0i_sign] = getLUT(C0b,C0d,1);
    [C1i,C1i_concat,C1i_sign] = getLUT(C1b,C1d,1);
    [C2i,C2i_concat,C2i_sign] = getLUT(C2b,C2d,1);

    % Adjust the LUT values adding zeros to the right
    C0i = strcat(C0i,char(zeros(1,bus_C0-2-t)+48));
    C1i = strcat(C1i,char(zeros(1,bus_C1-2-p)+48));
    C2i = strcat(C2i,char(zeros(1,bus_C2-1-q)+48));

    % Generate the concat values
    C0i_concat = strcat(C0i_sign+48,char(zeros(1,bus_C0-1-size(C0i_concat,2)-size(C0i,2))+48),C0i_concat);
    C1i_concat = strcat(C1i_sign+48,char(zeros(1,bus_C1-1-size(C1i_concat,2)-size(C1i,2))+48),C1i_concat);
    C2i_concat = strcat(C2i_sign+48,char(zeros(1,bus_C2-1-size(C2i_concat,2)-size(C2i,2))+48),C2i_concat);

    % Change the sign of the first sine constant in LUT C0
    if func == 9
        LUTC0 = strcat(C0i_concat,C0i);
        LUTC0(1,1) = '1';
    else
        LUTC0 = strcat(C0i_concat,C0i);
    end

    LUTC1 = strcat(C1i_concat,C1i);
    LUTC2 = strcat(C2i_concat,C2i);
end