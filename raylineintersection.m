function [k,d,f] = raylineintersection(vpos,vdir,vline)
  vdirc = size(vdir,1); vlinec = size(vline,1); k=nan;d=nan;f=nan;
  if ((vdirc>0)&&(vlinec>0))
    k=nan(vlinec,3,vdirc);d=false(vlinec,vdirc);f=nan(vlinec,vdirc);
    p1=vline(:,1:3);p2=vline(:,4:6);v1=p2-p1;
    v2=v1(:,[2 3 1]);s1 = planefromnormalatpoint(p1,v2);
    v3=v1(:,[3 1 2]);s2 = planefromnormalatpoint(p1,v3);
    for n = 1:vdirc
      d1=rayplanedistance(vpos,vdir(n,:),s1)';d2=rayplanedistance(vpos,vdir(n,:),s2)';
      darray=[d1 d2];darraynums=min(darray,[],2);
      darraynansf=find((sum(isnan(darray),2)>0)&isfinite(darraynums));
      darrayhitsf=find((darray(:,1)==darray(:,2))&(darray(:,2)!=inf));
      darraynansfc = union(darraynansf,darrayhitsf);
      if (!isempty(darraynansfc))
        f(darraynansfc,n)=darraynums(darraynansfc);
        k(darraynansfc,:,n)=vpos+vdir(n,:).*f(darraynansfc,n);
        darraynansdif = (k(darraynansfc,:,n)-p1(darraynansfc,:))./v1(darraynansfc,:);
        darraynansdiff = ones(size(darraynansdif,1),1);
        darraynansdifc1 = find(!isnan(darraynansdif(:,1)));
        darraynansdifc2 = find(!isnan(darraynansdif(:,2)));
        darraynansdifc3 = find(!isnan(darraynansdif(:,3)));
        darraynansdiff(darraynansdifc1) = darraynansdif(darraynansdifc1,1);
        darraynansdiff(darraynansdifc2) = darraynansdif(darraynansdifc2,2);
        darraynansdiff(darraynansdifc3) = darraynansdif(darraynansdifc3,3);
        darraynansff = find((darraynansdiff>=0)&(darraynansdiff<=1));
        d(darraynansfc(darraynansff),n)=true;
      endif
    endfor
  endif
endfunction
