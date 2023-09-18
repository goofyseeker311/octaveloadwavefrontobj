function [k] = pointplanedistance(vpoint,vplane)
  k = nan(size(vpoint)); l2 = vectorlength(vplane(1:3));
  if (l2!=0) k = dot([vpoint 1],vplane)./l2; endif;
endfunction
