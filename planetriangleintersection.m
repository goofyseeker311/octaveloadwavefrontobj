function [k,d,u,f] = planetriangleintersection(vplane,vtriangle)
  k={}; d=[]; u={}; f={}; vplanec=size(vplane,1); vtrianglec=size(vtriangle,3);
  array12=ones(vplanec,1).*[1 2];array13=ones(vplanec,1).*[1 3];array23=ones(vplanec,1).*[2 3];
  for n = 1:vtrianglec
    vtri12=vtriangle(2,:,n)-vtriangle(1,:,n);vtri13=vtriangle(3,:,n)-vtriangle(1,:,n);vtri23=vtriangle(3,:,n)-vtriangle(2,:,n);
    ptd1=rayplanedistance(vtriangle(1,:,n),vtri12,vplane)';ptlint1=vtriangle(1,:,n)+ptd1.*vtri12;ptlhit1=(ptd1>0)&(ptd1<1);
    ptd2=rayplanedistance(vtriangle(1,:,n),vtri13,vplane)';ptlint2=vtriangle(1,:,n)+ptd2.*vtri13;ptlhit2=(ptd2>0)&(ptd2<1);
    ptd3=rayplanedistance(vtriangle(2,:,n),vtri23,vplane)';ptlint3=vtriangle(2,:,n)+ptd3.*vtri23;ptlhit3=(ptd3>0)&(ptd3<1);
    pthit = ptlhit1|ptlhit2|ptlhit3; pthitf = find(pthit); phits = [ptlhit1 ptlhit2 ptlhit3];
    ptlint = nan(vplanec,6); ptluv = nan(vplanec,2); ptlind = nan(vplanec,4);
    if (!isempty(pthitf))
      phitsa=phits(pthitf,:);
      phitsa12=find(phitsa(:,1)&phitsa(:,2));phitsa13=find(phitsa(:,1)&phitsa(:,3));phitsa23=find(phitsa(:,2)&phitsa(:,3));
      ptlint(pthitf(phitsa12),1:3) = ptlint1(pthitf(phitsa12),:); ptlint(pthitf(phitsa12),4:6) = ptlint2(pthitf(phitsa12),:);
      ptlint(pthitf(phitsa13),1:3) = ptlint1(pthitf(phitsa13),:); ptlint(pthitf(phitsa13),4:6) = ptlint3(pthitf(phitsa13),:);
      ptlint(pthitf(phitsa23),1:3) = ptlint2(pthitf(phitsa23),:); ptlint(pthitf(phitsa23),4:6) = ptlint3(pthitf(phitsa23),:);
      ptluv(pthitf(phitsa12),1) = ptd1(pthitf(phitsa12),:); ptluv(pthitf(phitsa12),2) = ptd2(pthitf(phitsa12),:);
      ptluv(pthitf(phitsa13),1) = ptd1(pthitf(phitsa13),:); ptluv(pthitf(phitsa13),2) = ptd3(pthitf(phitsa13),:);
      ptluv(pthitf(phitsa23),1) = ptd2(pthitf(phitsa23),:); ptluv(pthitf(phitsa23),2) = ptd3(pthitf(phitsa23),:);
      ptlind(pthitf(phitsa12),1:2) = array12(pthitf(phitsa12),:); ptlind(pthitf(phitsa12),3:4) = array13(pthitf(phitsa12),:);
      ptlind(pthitf(phitsa13),1:2) = array12(pthitf(phitsa13),:); ptlind(pthitf(phitsa13),3:4) = array23(pthitf(phitsa13),:);
      ptlind(pthitf(phitsa23),1:2) = array13(pthitf(phitsa23),:); ptlind(pthitf(phitsa23),3:4) = array23(pthitf(phitsa23),:);
    endif
    k{n} = ptlint; d(:,n) = pthit; u{n} = ptluv; f{n} = ptlind;
  endfor
  if (vtrianglec==1)
    k = k{1}; u = u{1}; f = f{1};
  endif
endfunction
