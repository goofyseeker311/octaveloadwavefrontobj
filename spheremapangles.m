function [k,d] = spheremapangles(vhres,vvres)
  hanglestep = 360./(vhres-1); hanglelist = -180:hanglestep:180;
  vanglestep = 180./(vvres-1); vanglelist = -90:vanglestep:90;
  k = hanglelist; d = vanglelist;
endfunction
