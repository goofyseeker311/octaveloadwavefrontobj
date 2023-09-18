function [k] = normalizevector(vdir)
  k = nan(size(vdir)); l2 = vectorlength(vdir); if (l2!=0) k = vdir./l2; endif;
endfunction
