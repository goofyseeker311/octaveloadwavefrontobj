function [k,d] = cubemapangles(vres)
  step = 1/(vres-1);
  d = -1:step:1;
  k = atand(d);
endfunction
