function [k] = trianglecircumsphere(triangle)
  k = nan;
  if (!isempty(triangle))
    trianglec = size(triangle,3);
    k = nan(trianglec,4);
    for n = 1:trianglec
      v12=triangle(2,:,n)-triangle(1,:,n); v13=triangle(3,:,n)-triangle(1,:,n);
      v12l = vectorlength(v12).^2; v13l = vectorlength(v13).^2;
      cv12v13 = cross(v12,v13); top = cross(v12l.*v13-v13l.*v12,cv12v13);
      bottom = 2.*vectorlength(cv12v13).^2; p1 = triangle(1,:,n);
      if (bottom!=0)
        spherecenter = top./bottom + p1;
        sphereradius = vectorlength(spherecenter - p1);
        k(n,:) = [spherecenter sphereradius];
      endif
    endfor
  endif
endfunction
