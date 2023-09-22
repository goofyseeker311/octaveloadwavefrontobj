function [k] = planefromnormalatpoint(vpoint,vnormal)
  nm = normalizevector(vnormal); dv = -dot(nm,vpoint); k = [nm dv];
endfunction
