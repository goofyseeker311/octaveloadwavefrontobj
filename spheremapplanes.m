function [k,d,u] = spheremapplanes(vpos,vres,vrot)
  global smvecs;
  if (isempty(smvecs)||(size(smvecs,1)!=vres))
    hanglelist = spheremapangles(vres,vres);
    smvecs = [cosd(hanglelist)' sind(hanglelist)' zeros(vres,1)];
  endif
  smrotmat=rotationmatrix(vrot(1),vrot(2),vrot(3)); smplrot = smvecs; smplrot=(smrotmat*(smplrot'))';
  smvectors = planefromnormalatpoint(ones(vres,1)*vpos,smplrot); k = smvectors;
  u = planefromnormalatpoint(vpos,normalizevector(cross(k(1,1:3),k(2,1:3))));
  smupvects = normalizevector(cross(ones(vres,1).*u(1:3),k(:,1:3)));
  d = planefromnormalatpoint(ones(vres,1)*vpos,smupvects);
endfunction
