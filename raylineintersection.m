function [k,d,f] = raylineintersection(vpos,vdir,vline)
  vdirc = size(vdir,1); vlinec = size(vline,1);
  k=nan(vlinec,3,vdirc);d=false(vlinec,vdirc);f=nan(vlinec,vdirc);
  p1=vline(:,1:3);p2=vline(:,4:6);v1=p2-p1;
  v2=v1(:,[2 3 1]);s1 = planefromnormalatpoint(p1,v2);
  v3=v1(:,[3 1 2]);s2 = planefromnormalatpoint(p1,v3);
  if ((vdirc>0)&&(vlinec>0))
    for n = 1:vdirc
      d1=rayplanedistance(vpos,vdir(n,:),s1)';d2=rayplanedistance(vpos,vdir(n,:),s2)';
      darray=[d1 d2];darraynums=min(darray,[],2);
      darraynansf=find((sum(isnan(darray),2)>0)&isfinite(darraynums));
      darrayhitsf=find((darray(:,1)==darray(:,2))&(darray(:,2)!=inf));
      f(darraynansf,n)=darraynums(darraynansf);f(darrayhitsf,n)=darraynums(darrayhitsf);
      d(darraynansf,n)=true; d(darrayhitsf,n)=true;
      k(darraynansf,:,n)=vpos+vdir(n,:).*f(darraynansf,n);
      k(darrayhitsf,:,n)=vpos+vdir(n,:).*f(darrayhitsf,n);
    endfor
  endif
endfunction
