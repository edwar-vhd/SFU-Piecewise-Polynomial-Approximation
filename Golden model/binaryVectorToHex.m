function [y] = binaryVectorToHex(x)
  y="";
  for i=1:8
    if compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[0 0 0 0])
      aux = "0";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[0 0 0 1])
      aux = "1";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[0 0 1 0])
      aux = "2";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[0 0 1 1])
      aux = "3";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[0 1 0 0])
      aux = "4";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[0 1 0 1])
      aux = "5";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[0 1 1 0])
      aux = "6";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[0 1 1 1])
      aux = "7";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[1 0 0 0])
      aux = "8";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[1 0 0 1])
      aux = "9";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[1 0 1 0])
      aux = "A";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[1 0 1 1])
      aux = "B";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[1 1 0 0])
      aux = "C";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[1 1 0 1])
      aux = "D";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[1 1 1 0])
      aux = "E";
    elseif compare_vector(x(((i-1)*4)+1:((i-1)*4)+4),[1 1 1 1])
      aux = "F";
    endif

    y = strcat(y,aux);
  endfor
end
