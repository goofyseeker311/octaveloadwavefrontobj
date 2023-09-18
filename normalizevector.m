function [k] = normalizevector(vdir)
  k = nan(size(vdir)); l2 = dot(vdir,vdir); if (l2!=0) k = vdir./sqrt(l2); endif;
endfunction
