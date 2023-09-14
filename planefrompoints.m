function [k] = planefrompoints(points)
  v1 = points(2,:)-points(1,:);
  v2 = points(3,:)-points(1,:);
  nm = cross(v1,v2);
  dv = -dot(nm,points(1,:));
  k = [nm dv];
endfunction
