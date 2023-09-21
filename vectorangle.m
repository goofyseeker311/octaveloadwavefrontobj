function [k] = vectorangle(vdir1,vdir2)
  k = nan; vl1 = vectorlength(vdir1); vl2 = vectorlength(vdir2);
  if ((vl1!=0)&&(vl2!=0)) k = acosd(dot(vdir1,vdir2)./(vl1.*vl2)); endif
endfunction
