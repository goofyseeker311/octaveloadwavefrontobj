function [k] = pointplanedistance(vpoint,vplane)
  k = nan(size(vpoint)); l2 = dot(vplane(1:3),vplane(1:3));
  if (l2!=0) k = dot([vpoint 1],vplane)./sqrt(l2); endif;
endfunction
