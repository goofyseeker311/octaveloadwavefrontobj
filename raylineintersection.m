function [k,d,f] = raylineintersection(vpos,vdir,vline)
  vdirc = size(vdir,1); vlinec = size(vline,1);
  k=nan;d=false;f=nan;p1=vline(:,1:3);p2=vline(:,4:6);v1=p2-p1;
  v2=v1(:,[2 3 1]); s1 = planefromnormalatpoint(p1,v2);
  v3=v1(:,[3 1 2]); s2 = planefromnormalatpoint(p1,v3);
  d1=rayplanedistance(vpos,vdir,s1);d2=rayplanedistance(vpos,vdir,s2);
  darray=[d1 d2]; darraynums=min(darray,[],2);
  k=nan(vlinec,3,vdirc);d=false(vlinec,vdirc);f=nan(vlinec,vdirc);
  darraynansf=find((sum(isnan(darray),2)>0)&isfinite(darraynums));
  darrayhitsf=find((darray(:,1)==darray(:,2))&(darray(:,2)!=inf));
  f(darraynansf)=darraynums(darraynansf);f(darrayhitsf)=darraynums(darrayhitsf);
  d(darraynansf)=true; d(darrayhitsf)=true;
  k(darraynansf,:)=vpos+vdir.*f(darraynansf,:);
  k(darrayhitsf,:)=vpos+vdir.*f(darrayhitsf,:);
endfunction
