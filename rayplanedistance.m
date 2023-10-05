function [k] = rayplanedistance(vpos,vdir,vplane)
  vdirc = size(vdir,1); vplanec = size(vplane,1); k = nan;
  if ((!isempty(vpos))&&(vdirc>0)&&(vplanec>0))
    k = nan(vdirc,vplanec);
    for n = 1:vplanec
      top = -dot([vpos 1],vplane(n,:),2);
      bottom = dot(vdir,ones(vdirc,1).*vplane(n,1:3),2);
      k(:,n) = top./bottom;
    endfor
  endif
endfunction
