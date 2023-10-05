function [k] = normalizevector(vdir)
  k=nan(size(vdir)); l2=vectorlength(vdir); k=vdir./l2;
endfunction
