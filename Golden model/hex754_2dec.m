function y = hex754_2dec(x)
    %x='3863F107';
    number = char(hex2bin(x));

    % The sign
    sign = [1 -1];
    s = number(1);
    
    exp = bin2dec(strcat(number(2:9),'.0'))-127;
    man = bin2dec(strcat('1.',number(10:end)));

    y = (man*2^exp)*sign(str2double(s)+1);
end