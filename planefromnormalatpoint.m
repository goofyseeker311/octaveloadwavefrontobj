function [k] = planefromnormalatpoint(vpoint,vnormal)
  vpointc = size(vpoint,1); vnormalc = size(vnormal,1); k = nan;
  if ((vpointc>0)&&(vnormalc>0))
    nm=normalizevector(vnormal); dv=-dot(nm,vpoint,2); k = [nm dv];
  endif
endfunction
