function [k] = cubemapplanes(vpos,vres)
  global cmpl;
  if (isempty(cmpl))
    [anglelist,steplist] = cubemapangles(vres);
    fwdvectors = [ones(vres,1) zeros(vres,1) steplist'];
    fwdvectors = fwdvectors./sqrt(dot(fwdvectors,fwdvectors,2));
    cubemaprgt = (ones(vres,1)*[0 -1 0]);
    cubemapup = cross(cubemaprgt',fwdvectors')';
    cubemapup = cubemapup./sqrt(dot(cubemapup,cubemapup,2));
    cmupx = (rotationmatrix(0,0,180)*cubemapup')';
    cmupx90 = (rotationmatrix(90,0,0)*cmupx')';
    cmupz90a = (rotationmatrix(0,0,90)*cmupx')';
    cmupz90b = (rotationmatrix(0,0,90)*cmupx90')';
    cmupz180a = (rotationmatrix(0,0,180)*cmupx')';
    cmupz180b = (rotationmatrix(0,0,180)*cmupx90')';
    cmupz270a = (rotationmatrix(0,0,270)*cmupx')';
    cmupz270b = (rotationmatrix(0,0,270)*cmupx90')';
    cmupy90a = (rotationmatrix(0,90,0)*cmupx')';
    cmupy90b = (rotationmatrix(0,90,0)*cmupx90')';
    cmupy270a = (rotationmatrix(0,270,0)*cmupx')';
    cmupy270b = (rotationmatrix(0,270,0)*cmupx90')';
    cmpl = {cmupx cmupx90; cmupz90a cmupz90b; cmupz180a cmupz180b; cmupz270a cmupz270b; cmupy90a cmupy90b; cmupy270a cmupy270b};
  endif
  rotx = [cmpl{1,1} -dot(ones(vres,1)*vpos,cmpl{1,1},2)];
  rotx90p = [cmpl{1,2} -dot(ones(vres,1)*vpos,cmpl{1,2},2)];
  rotz90ap = [cmpl{2,1} -dot(ones(vres,1)*vpos,cmpl{2,1},2)];
  rotz90bp = [cmpl{2,2} -dot(ones(vres,1)*vpos,cmpl{2,2},2)];
  rotz180ap = [cmpl{3,1} -dot(ones(vres,1)*vpos,cmpl{3,1},2)];
  rotz180bp = [cmpl{3,2} -dot(ones(vres,1)*vpos,cmpl{3,2},2)];
  rotz270ap = [cmpl{4,1} -dot(ones(vres,1)*vpos,cmpl{4,1},2)];
  rotz270bp = [cmpl{4,2} -dot(ones(vres,1)*vpos,cmpl{4,2},2)];
  roty90ap = [cmpl{5,1} -dot(ones(vres,1)*vpos,cmpl{5,1},2)];
  roty90bp = [cmpl{5,2} -dot(ones(vres,1)*vpos,cmpl{5,2},2)];
  roty270ap = [cmpl{6,1} -dot(ones(vres,1)*vpos,cmpl{6,1},2)];
  roty270bp = [cmpl{6,2} -dot(ones(vres,1)*vpos,cmpl{6,2},2)];
  k = {rotx rotx90p; rotz90ap rotz90bp; rotz180ap rotz180bp; rotz270ap rotz270bp; roty90ap roty90bp; roty270ap roty270bp};
endfunction
