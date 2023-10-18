function [k] = pointplanedistance(vpoint,vplane)
  k = nan; pointc=size(vpoint,1); planec=size(vplane,1);
  if ((pointc>0)&&(planec>0))
    k = nan(pointc,planec); l2=vectorlength(vplane(:,1:3));
    if (planec>1)
      for n = 1:pointc
        k(n,:)=dot(ones(planec,1).*[vpoint(n,:) 1],vplane,2)./l2;
      endfor
    else
      k(:,1)=dot([vpoint ones(pointc,1)],ones(pointc,1).*vplane,2)./l2;
    endif
  endif
endfunction
