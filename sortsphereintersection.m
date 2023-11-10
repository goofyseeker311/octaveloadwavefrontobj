function [k] = sortsphereintersection(vsphere)
  k={}; xss=vsphere(:,1); yss=vsphere(:,2); zss=vsphere(:,3); rss=vsphere(:,4);
  xssL=[xss-rss xss+rss]; yssL=[yss-rss yss+rss]; zssL=[zss-rss zss+rss];
  xssA=xssL(:); yssA=yssL(:); zssA=zssL(:); rssc=size(rss,1);
  [xssAs,xssAsi]=sort(xssA); [yssAs,yssAsi]=sort(yssA); [zssAs,zssAsi]=sort(zssA);
  xssAsi2=xssAsi; xssAsi2f=find(xssAsi2>rssc); xssAsi2(xssAsi2f)-=rssc;
  yssAsi2=yssAsi; yssAsi2f=find(yssAsi2>rssc); yssAsi2(yssAsi2f)-=rssc;
  zssAsi2=zssAsi; zssAsi2f=find(zssAsi2>rssc); zssAsi2(zssAsi2f)-=rssc;
  xssAsLi=lookup(xssAs,xssA); xssAsLir=reshape(xssAsLi,rssc,2);
  yssAsLi=lookup(yssAs,yssA); yssAsLir=reshape(yssAsLi,rssc,2);
  zssAsLi=lookup(zssAs,zssA); zssAsLir=reshape(zssAsLi,rssc,2);
  for n = 1:rssc
    xssAsLif = xssAsi2(xssAsLir(n,1):xssAsLir(n,2));
    yssAsLif = yssAsi2(yssAsLir(n,1):yssAsLir(n,2));
    zssAsLif = zssAsi2(zssAsLir(n,1):zssAsLir(n,2));
    k{n} = setdiff(intersect(intersect(xssAsLif,yssAsLif),zssAsLif),n);
  endfor
endfunction
