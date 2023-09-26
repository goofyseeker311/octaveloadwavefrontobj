function [k] = unitxyzcubemaprays(vres)
  sidefacerays = []; [anglelist,steplist] = cubemapangles(vres);
  x = ones(1,vres); onem = ones(1,vres); rsrays = []; k = []; d = [];
  rmatrixz90 = rotationmatrix(0,0,90);
  rmatrixz180 = rotationmatrix(0,0,180);
  rmatrixz270 = rotationmatrix(0,0,270);
  rmatrixy90 = rotationmatrix(0,90,0);
  rmatrixy270 = rotationmatrix(0,270,0);
  for yind = 1:vres
    y = steplist(yind).*onem; z = steplist;
    v = [x; y; z]; v = v./sqrt(dot(v,v));
    sidefacerays(yind,:,:) = v';
    sidefaceraysz90(yind,:,:) = (rmatrixz90*v)';
    sidefaceraysz180(yind,:,:) = (rmatrixz180*v)';
    sidefaceraysz270(yind,:,:) = (rmatrixz270*v)';
    sidefaceraysy90(yind,:,:) = (rmatrixy90*v)';
    sidefaceraysy270(yind,:,:) = (rmatrixy270*v)';
  endfor
  k = {sidefacerays sidefaceraysz90 sidefaceraysz180 sidefaceraysz270 sidefaceraysy90 sidefaceraysy270};
endfunction
