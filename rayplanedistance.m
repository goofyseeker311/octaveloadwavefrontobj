function [k] = rayplanedistance(vpos,vdir,vplane)
  vdirc = size(vdir,1); vplanec = size(vplane,1); k = nan;
  if ((!isempty(vpos))&&(vdirc>0)&&(vplanec>0))
    k = nan(vdirc,vplanec);
    for n = 1:vdirc
      top = -dot(ones(vplanec,1).*[vpos 1],vplane,2);
      bottom = dot(ones(vplanec,1).*vdir(n,:),vplane(:,1:3),2);
      k(n,:) = top./bottom;
    endfor
  endif
endfunction
