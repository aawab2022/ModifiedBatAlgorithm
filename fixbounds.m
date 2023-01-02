function [sol]=fixbounds(x, UB, LB)
  for i= 1:length(x)
    if x(i) > UB || x(i) < LB
      %x(i) = UB;
      x(i) = LB + rand * (UB - LB);
##    elseif x(i) < LB
##      x(i) = LB;
    endif
  endfor
  sol = x;
