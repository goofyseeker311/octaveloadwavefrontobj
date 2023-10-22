function [k,d,u,r] = projectedplanes(vpos,vhres,vvres,vhfov,vvfov,vvrot)
  global prpl;
  if (isempty(prpl)||(size(prpl{1},1)!=vhres)||(size(prpl{2},1)!=vvres))
    [hangles,hstep,vangles,vstep,dasp,aasp]=projectedangles(vhres,vvres,vhfov,vvfov);
    hfwdvectors = [ones(vhres,1) hstep' zeros(vhres,1)];
    hfwdvectors = hfwdvectors./vectorlength(hfwdvectors);
    hprojrgtvec = [0 0 1]; hprojdirvec = [1 0 0];
    hprojrgt = (ones(vhres,1)*hprojrgtvec);
    hprojup = cross(hprojrgt',hfwdvectors')';
    hprojup = hprojup./vectorlength(hprojup);
    hprojupx = (rotationmatrix(0,0,180)*hprojup')';
    vfwdvectors = [ones(vvres,1) zeros(vvres,1) vstep'];
    vfwdvectors = vfwdvectors./vectorlength(vfwdvectors);
    vprojrgtvec = [0 -1 0]; vprojdirvec = [1 0 0];
    vprojrgt = (ones(vvres,1)*vprojrgtvec);
    vprojup = cross(vprojrgt',vfwdvectors')';
    vprojup = vprojup./vectorlength(vprojup);
    vprojupx = (rotationmatrix(0,0,180)*vprojup')';
    prpl = {hprojupx vprojupx hprojdirvec vprojdirvec hprojrgtvec vprojrgtvec hfwdvectors vfwdvectors};
  endif
  prrotmat=rotationmatrix(vvrot(1),vvrot(2),vvrot(3)); prplrot = prpl;
  for n = 1:8; prplrot{n}=(prrotmat*(prplrot{n}'))'; endfor
  hprrotx = planefromnormalatpoint(ones(vhres,1).*vpos,prplrot{1});
  vprrotx = planefromnormalatpoint(ones(vvres,1).*vpos,prplrot{2});
  hprojdirvecrotx = planefromnormalatpoint(vpos,prplrot{3});
  vprojdirvecrotx = planefromnormalatpoint(vpos,prplrot{4});
  hprojrgtvecrotx = planefromnormalatpoint(vpos,prplrot{5});
  vprojrgtvecrotx = planefromnormalatpoint(vpos,prplrot{6});
  hfwdvectorsrotx = planefromnormalatpoint(ones(vhres,1).*vpos,prplrot{7});
  vfwdvectorsrotx = planefromnormalatpoint(ones(vvres,1).*vpos,prplrot{8});
  k = {hprrotx vprrotx}; d = {hprojdirvecrotx vprojdirvecrotx};
  u = {hprojrgtvecrotx vprojrgtvecrotx}; r = {hfwdvectorsrotx vfwdvectorsrotx};
endfunction
