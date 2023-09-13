function [k] = rotationmatrix(xaxisr,yaxisr,zaxisr)
  xrot = [1 0 0;0 cosd(xaxisr) -sind(xaxisr);0 sind(xaxisr) cosd(xaxisr)];
  yrot = [cosd(yaxisr) 0 sind(yaxisr);0 1 0;-sind(yaxisr) 0 cosd(yaxisr)];
  zrot = [cosd(zaxisr) -sind(zaxisr) 0;sind(zaxisr) cosd(zaxisr) 0;0 0 1];
  k = xrot; k = yrot*k; k = zrot*k;
endfunction
