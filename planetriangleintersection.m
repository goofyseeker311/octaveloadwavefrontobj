function [k,d,u,f] = planetriangleintersection(vplane,vtriangle)
  k = nan; d = false; u = nan(2,1); f = nan(2,1);
  [ptlint1,ptlhit1,ptluv1] = planelineintersection(vplane,vtriangle([1 2],:));
  [ptlint2,ptlhit2,ptluv2] = planelineintersection(vplane,vtriangle([1 3],:));
  [ptlint3,ptlhit3,ptluv3] = planelineintersection(vplane,vtriangle([2 3],:));
  if (ptlhit1||ptlhit2||ptlhit3)
    ptint = [];
    if (ptlhit1) ptint = [ptint;ptlint1 ptluv1 ones(size(ptlint1,1),1)*[1,2]]; endif
    if (ptlhit2) ptint = [ptint;ptlint2 ptluv2 ones(size(ptlint2,1),1)*[1,3]]; endif
    if (ptlhit3) ptint = [ptint;ptlint3 ptluv3 ones(size(ptlint3,1),1)*[2,3]]; endif
    [ptuint,ptuind] = unique(ptint(:,1:4),"rows"); puintf = [ptint(ptuind,:)];
    if (size(puintf,1)) puintf = [puintf;puintf]; endif
    k = puintf(:,1:3); d = true; u = puintf(:,4); f = puintf(:,5:6);
  endif
endfunction
