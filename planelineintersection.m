function [k,d,u] = planelineintersection(vplane,vpos)
  k = nan; d = false; u = nan;
  plpos1 = vpos(1,:); plpos2 = vpos(2,:); plvec = plpos2-plpos1;
  plvecd = vectorlength(plvec); plvecn = normalizevector(plvec);
  pdist1 = pointplanedistance(plpos1,vplane);
  pdist2 = pointplanedistance(plpos2,vplane);
  [pdist,pdisti] = sort([pdist1 pdist2]);
  if ((pdist(1)<=0)&&(pdist(2)>=0))
    if ((pdist(1)==0)&&(pdist(2)==0))
      k = vpos; d = 2; u = [0;1];
    else
      pdistd = abs(pdist(1))./(abs(pdist(1))+abs(pdist(2)));
      pdistv = vpos(pdisti(2),:)-vpos(pdisti(1),:);
      ppos = vpos(pdisti(1),:)+pdistd.*pdistv;
      pposuv = pdistd; if (pdisti(1)==2) pposuv = 1-pdistd; endif
      k = ppos; d = 1; u = pposuv;
    endif
  endif
endfunction
