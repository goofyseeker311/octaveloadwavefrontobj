function [k] = axisalignedboundingbox(vvertexlist)
  k = [min(vvertexlist,[],1) max(vvertexlist,[],1)];
endfunction
