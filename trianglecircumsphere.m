function [k,d] = trianglecircumsphere(triangle)
  k = nan(1,size(triangle,2)); d = nan;
  v12 = triangle(2,:)-triangle(1,:); v13 = triangle(3,:)-triangle(1,:);
  v12l = vectorlength(v12).^2; v13l = vectorlength(v13).^2;
  cv12v13 = cross(v12,v13); top = cross(v12l.*v13-v13l.*v12,cv12v13);
  bottom = 2.*vectorlength(cv12v13).^2; p1 = triangle(1,:);
  if (bottom!=0) k = top./bottom + p1; d = vectorlength(k - p1); endif
endfunction
