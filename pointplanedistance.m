function [k] = pointplanedistance(vpoint,vplane)
  k = dot([vpoint 1],vplane)./sqrt(dot(vplane(1:3),vplane(1:3)));
endfunction

