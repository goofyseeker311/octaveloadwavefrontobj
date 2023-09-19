function [k,d] = unitxyzcubemaprays(vres)
  sidefacerays = []; [anglelist,steplist] = cubemapangles(vres);
  x = ones(1,vres); onem = ones(1,vres); rsrays = [];
  for yind = 1:vres
    y = steplist(yind).*onem; z = steplist;
    v = [x; y; z]; v = v./sqrt(dot(v,v));
    sidefacerays(yind,:,:) = v';
    rsrays(:,end+1:end+vres) = v;
  endfor
  rsraysz0 = rsrays';
  rsraysz90 = (rotationmatrix(0,0,90)*rsrays)';
  rsraysz180 = (rotationmatrix(0,0,180)*rsrays)';
  rsraysz270 = (rotationmatrix(0,0,270)*rsrays)';
  rsraysy90 = (rotationmatrix(0,90,0)*rsrays)';
  rsraysy270 = (rotationmatrix(0,270,0)*rsrays)';
  k = {rsraysz0 rsraysz90 rsraysz180 rsraysz270 rsraysy90 rsraysy270};
  d = [rsraysz0;rsraysz90;rsraysz180;rsraysz270;rsraysy90;rsraysy270];
endfunction
