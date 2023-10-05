function [k] = vectorangle(vdir1,vdir2)
  k = nan; vdir1c = size(vdir1,1); vdir2c = size(vdir2,1);
  if (vdir1c>0)&&(vdir2c>0)&&(vdir1c==vdir2c)
    vl1 = vectorlength(vdir1); vl2 = vectorlength(vdir2);
    k = acosd(dot(vdir1,vdir2,2)./(vl1.*vl2));
  endif
endfunction
