function [k] = equilateralspheremaprays(hres,vres)
  k = []; hanglestep = 360./(hres-1); vanglestep = 180./(vres-1);
  hanglelist = -180:hanglestep:180; vanglelist = -90:vanglestep:90;
  vvectors = [cosd(vanglelist);zeros(1,size(vanglelist,2));sind(vanglelist)];
  rvectors = zeros(3,vres,hres);
  for n = 1:hres
    svectors = (rotationmatrix(0,0,hanglelist(n))*vvectors)';
    svectors = normalizevector(svectors);
    k(:,n,:) = svectors;
  endfor
endfunction
