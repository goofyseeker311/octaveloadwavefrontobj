function [k] = planefrompoints(points)
  k = nan;
  if (!isempty(points))
    pointsc = size(points,3);
    k = nan(pointsc,4);
    for n = 1:pointsc
      v1 = points(2,:,n)-points(1,:,n);
      v2 = points(3,:,n)-points(1,:,n);
      nm = cross(v1,v2);
      nm = normalizevector(nm);
      dv = -dot(nm,points(1,:,n));
      k(n,:) = [nm dv];
    endfor
  endif
endfunction
