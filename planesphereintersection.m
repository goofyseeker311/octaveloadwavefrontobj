function [k,d,f,g] = planesphereintersection(vplane,vsphere)
  k=nan; d=false; f=nan; g=nan;
  vplanec = size(vplane,1); vspherec = size(vsphere,1);
  if ((vplanec>0)&&(vspherec>0))
    k=nan(vplanec,3,vspherec); d=false(vplanec,vspherec);
    f=nan(vplanec,vspherec); g=nan(vplanec,vspherec);
    for n = 1:vspherec
      f(:,n) = pointplanedistance(vsphere(n,1:3),vplane);
      d(:,n) = (abs(f(:,n))<=vsphere(n,4)); df = find(d(:,n));
      if (!isempty(df))
        k(df,:,n) = vsphere(n,1:3)-f(df,n).*vplane(df,1:3);
        g(df,n) = sqrt(vsphere(n,4).^2-f(df,n).^2);
      endif
    endfor
  endif
endfunction
