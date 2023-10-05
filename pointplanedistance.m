function [k] = pointplanedistance(vpoint,vplane)
  l2=vectorlength(vplane(:,1:3)); pointc=size(vpoint,1); planec=size(vplane,1);
  k = nan(pointc,planec);
  for n = 1:planec
    if (l2(n)!=0)
      k(:,n)=dot([vpoint ones(pointc,1)],ones(pointc,1).*vplane(n,:),2)./l2(n);
    endif
  endfor
endfunction
