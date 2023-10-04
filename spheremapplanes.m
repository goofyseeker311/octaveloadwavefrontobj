function [k,d,u] = spheremapplanes(vpos,vres)
  global smvecs;
  if (isempty(smvecs)||(size(smvecs,1)!=vres))
    hanglelist = spheremapangles(vres,vres);
    smvecs = [cosd(hanglelist)' sind(hanglelist)' zeros(vres,1)];
  endif
  smvectors = [smvecs -dot(ones(vres,1)*vpos,smvecs,2)]; k = smvectors;
  u = planefromnormalatpoint(vpos,normalizevector(cross(k(1,1:3),k(2,1:3))));
  smupvects = normalizevector(cross(k(:,1:3),ones(vres,1).*u(1:3)));
  d = [smupvects -dot(ones(vres,1)*vpos,smupvects,2)];
endfunction
