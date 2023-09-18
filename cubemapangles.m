function [k,d] = cubemapangles(vres)
  step = 2/(vres-1); d = -1:step:1; k = atand(d);
endfunction
