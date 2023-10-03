function [k] = projectedrays(vhres,vvres,vhfov,vvfov)
  sidefacerays = []; x = ones(1,vhres); onem = ones(1,vhres); k = [];
  [hangles,hstep,vangles,vstep,dasp,aasp]=projectedangles(vhres,vvres,vhfov,vvfov);
  for yind = 1:vvres
    z = vstep(yind).*onem; y = hstep;
    v = [x; y; z]; v = v./sqrt(dot(v,v));
    sidefacerays(yind,:,:) = v';
  endfor
  k = sidefacerays;
endfunction
