function [k] = cubemapplanes(vpos,vres)
  global cmpl;
  if (isempty(cmpl))
    [anglelist,steplist] = cubemapangles(vres);
    fwdvectors = [ones(vres,1) zeros(vres,1) steplist'];
    fwdvectors = fwdvectors./sqrt(dot(fwdvectors,fwdvectors,2));
    cubemaprgt = (ones(vres,1)*[0 -1 0]);
    cubemapup = cross(cubemaprgt',fwdvectors')';
    cubemapup = cubemapup./sqrt(dot(cubemapup,cubemapup,2));
    cmupx90 = (rotationmatrix(90,0,0)*cubemapup')';
    cmupz90a = (rotationmatrix(0,0,90)*cubemapup')';
    cmupz90b = (rotationmatrix(0,0,90)*cmupx90')';
    cmupy90a = (rotationmatrix(0,90,0)*cubemapup')';
    cmupy90b = (rotationmatrix(0,90,0)*cmupx90')';
    cmpl = {cubemapup cmupx90; cmupz90a cmupz90b; cmupy90a cmupy90b};
  endif
  rotx = [cmpl{1,1} -dot(ones(vres,1)*vpos,cmpl{1,1},2)];
  rotx90p = [cmpl{1,2} -dot(ones(vres,1)*vpos,cmpl{1,2},2)];
  rotz90ap = [cmpl{2,1} -dot(ones(vres,1)*vpos,cmpl{2,1},2)];
  rotz90bp = [cmpl{2,2} -dot(ones(vres,1)*vpos,cmpl{2,2},2)];
  roty90ap = [cmpl{3,1} -dot(ones(vres,1)*vpos,cmpl{3,1},2)];
  roty90bp = [cmpl{3,2} -dot(ones(vres,1)*vpos,cmpl{3,2},2)];
  k = {rotx rotx90p; rotz90ap rotz90bp; roty90ap roty90bp};
endfunction
