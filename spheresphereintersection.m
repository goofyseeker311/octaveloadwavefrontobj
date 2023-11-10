function [k,d,f] = spheresphereintersection(vspheresA,vspheresB)
  vspheresAc = size(vspheresA,1); vspheresBc = size(vspheresB,1);
  k = nan; d = nan; f = false;
  if ((vspheresAc>0)&&(vspheresBc>0))
    k = nan(vspheresAc,vspheresBc); d = false(vspheresAc,vspheresBc);
    if (vspheresBc==1)
      vspherevec = vspheresA(:,1:3)-vspheresB(1:3);
      vspheredif = vectorlength(vspherevec);
      d = vspheredif-(vspheresA(:,4)+vspheresB(4));
      f = d<=0;
    else
    endif
  endif
endfunction
