function [k] = rayplanedistance(vpos,vdir,vplane)
  k = []; top = -dot([vpos 1],vplane); bottom = dot(vdir,vplane(1:3));
  if (bottom!=0) k = top./bottom; endif
endfunction
