function [k,hd,k2,vd,f,f2] = projectedangles(vhres,vvres,vhfov,vvfov)
  halfvhfov=vhfov./2; halfvvfov=vvfov./2;
  hstepmax=abs(tand(halfvhfov)); hstepmin=-hstepmax;
  vstepmax=abs(tand(halfvvfov)); vstepmin=-vstepmax;
  hstep=2/(vhres-1).*hstepmax; vstep=2/(vvres-1).*vstepmax;
  hd = hstepmin:hstep:hstepmax; vd = vstepmin:vstep:vstepmax;
  k = atand(hd); k2 = atand(vd); f = vhres./vvres; f2 = vhfov./vvfov;
endfunction
