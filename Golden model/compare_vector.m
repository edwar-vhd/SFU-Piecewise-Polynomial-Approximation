function [o] = compare_vector(x,y)
  o=1;
  for i=1:size(x,2)
    if (x(i)!=y(i))
      o=0;
      break
    endif
  endfor
end
