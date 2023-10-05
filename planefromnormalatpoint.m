function [k] = planefromnormalatpoint(vpoint,vnormal)
  vpointc = size(vpoint,1); vnormalc = size(vnormal,1); k = nan;
  if ((vpointc>0)&&(vnormalc>0))
    k = nan(vpointc,4,vnormalc);
    for n = 1:vnormalc
      nm=ones(vpointc,1).*normalizevector(vnormal(n,:)); dv=-dot(nm,vpoint,2);
      k(:,:,n) = [nm dv];
    endfor
  endif
endfunction
