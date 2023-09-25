function [k] = spheremapplanes(vpos,vres)
  global smvecs;
  if (isempty(smvecs)||(size(smvecs,1)!=vres))
    hanglelist = spheremapangles(vres,vres);
    smvecs = [cosd(hanglelist)' sind(hanglelist)' zeros(vres,1)];
  endif
  smvectors = [smvecs -dot(ones(vres,1)*vpos,smvecs,2)]; k = smvectors;
endfunction
