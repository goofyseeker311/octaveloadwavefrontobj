function [k] = normalizevector(vdir)
  k = []; l2 = dot(vdir,vdir); if (l2!=0) k = vdir./sqrt(l2); endif;
endfunction
