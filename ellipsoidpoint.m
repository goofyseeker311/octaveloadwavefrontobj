function [k,d,f,u,r,v] = ellipsoidpoint(vpos,vangles,vdims,vrot)
  vrotmat=rotationmatrix(vrot(1),vrot(2),vrot(3));vecfwd=(vrotmat*[1 0 0]')';vecrgt=(vrotmat*[0 1 0]')';vecup=(vrotmat*[0 0 1]')';
  vdimsc=size(vdims,1); vfwd=vdims(:,1).*vecfwd; vrgt=vdims(:,2).*vecrgt; vup=vdims(:,3).*vecup;
  v = (vfwd.*cosd(vangles(:,1)) + vrgt.*sind(vangles(:,1))).*cosd(vangles(:,2)) + vup.*sind(vangles(:,2));
  k = v + ones(vdimsc,1).*vpos; d = vectorlength(v); f = vfwd; u = vup; r = vrgt;
endfunction
