function [k] = pointplanedistance(vpoint,vplane)
  pointc=size(vpoint,1); planec=size(vplane,1); k = nan;
  if ((pointc>0)&&(planec>0))
    k = nan(pointc,planec);
    l2=vectorlength(vplane(:,1:3));
    for n = 1:planec
      if (l2(n)!=0)
        k(:,n)=dot([vpoint ones(pointc,1)],ones(pointc,1).*vplane(n,:),2)./l2(n);
      endif
    endfor
  endif
endfunction
