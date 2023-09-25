function [k] = spheremapplanes(vpos,vres)
  global smvecs;
  if (isempty(smvecs)||(size(smvecs,1)!=vres))
    hanglestep=360./(vres-1); hanglelist=-180:hanglestep:180;
    smvecs = [cosd(hanglelist)' sind(hanglelist)' zeros(vres,1)];
  endif
  smvectors = [smvecs -dot(ones(vres,1)*vpos,smvecs,2)]; k = smvectors;
endfunction
