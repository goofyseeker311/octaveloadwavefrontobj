function [k] = projectedplanes(vpos,vhres,vvres,vhfov,vvfov)
  global prpl;
  if (isempty(prpl)||(size(prpl{1},1)!=vhres)||(size(prpl{2},1)!=vvres))
    [hangles,hstep,vangles,vstep,dasp,aasp]=projectedangles(vhres,vvres,vhfov,vvfov);
    hfwdvectors = [ones(vhres,1) hstep' zeros(vhres,1)];
    hfwdvectors = hfwdvectors./sqrt(dot(hfwdvectors,hfwdvectors,2));
    hprojrgt = (ones(vhres,1)*[0 0 1]);
    hprojup = cross(hprojrgt',hfwdvectors')';
    hprojup = hprojup./sqrt(dot(hprojup,hprojup,2));
    hprojupx = (rotationmatrix(0,0,180)*hprojup')';
    vfwdvectors = [ones(vvres,1) zeros(vvres,1) vstep'];
    vfwdvectors = vfwdvectors./sqrt(dot(vfwdvectors,vfwdvectors,2));
    vprojrgt = (ones(vvres,1)*[0 -1 0]);
    vprojup = cross(vprojrgt',vfwdvectors')';
    vprojup = vprojup./sqrt(dot(vprojup,vprojup,2));
    vprojupx = (rotationmatrix(0,0,180)*vprojup')';
    prpl = {hprojupx vprojupx};
  endif
  hprrotx = [prpl{1,1} -dot(ones(vhres,1)*vpos,prpl{1,1},2)];
  vprrotx = [prpl{1,2} -dot(ones(vvres,1)*vpos,prpl{1,2},2)];
  k = {hprrotx vprrotx};
endfunction
