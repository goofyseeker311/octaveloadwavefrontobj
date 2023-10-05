function [k] = planefrompoints(points)
  k = nan;
  if (!isempty(points))
    pointsc = size(points,3);
    xvpos = reshape(points(1,:,:),3,pointsc)';
    yvpos = reshape(points(2,:,:),3,pointsc)';
    zvpos = reshape(points(3,:,:),3,pointsc)';
    vpos = [xvpos yvpos zvpos];
    v1 = vpos(:,4:6)-vpos(:,1:3);
    v2 = vpos(:,7:9)-vpos(:,1:3);
    nm = cross(v1,v2,2);
    nm = normalizevector(nm);
    dv = -dot(nm,vpos(:,1:3),2);
    k = [nm dv];
  endif
endfunction
