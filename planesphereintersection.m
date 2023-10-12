function [k] = planesphereintersection(vplane,vsphere)
  k = pointplanedistance(vsphere(:,1:3),vplane);
endfunction
