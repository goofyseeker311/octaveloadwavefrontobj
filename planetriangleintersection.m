function [k,d] = planetriangleintersection(vplane,vtriangle)
  k = nan; d = false;
  tdist1 = pointplanedistance(vtriangle(1,:),vplane);
  tdist2 = pointplanedistance(vtriangle(2,:),vplane);
  tdist3 = pointplanedistance(vtriangle(3,:),vplane);
  tdistL = [tdist1 tdist2 tdist3]; [tdistlist,tdistinds] = sort(tdistL);
  mintdist = tdistlist(1); maxtdist = tdistlist(3); medtdist = tdistlist(2);
  mintdind = tdistinds(1); maxtdind = tdistinds(3); medtdind = tdistinds(2);
  if ((mintdist<=0)&&(maxtdist>=0))
    rootind = mintdind; if (medtdist<0) rootind = maxtdind; endif
    otherind = setdiff([1 2 3],rootind); rootpoint = vtriangle(rootind,:);
    tv1 = vtriangle(otherind(1),:)-rootpoint;
    tv2 = vtriangle(otherind(2),:)-rootpoint;
    tvrd = abs(tdistL(rootind));
    tv1d = abs(tdistL(otherind(1))); tv2d = abs(tdistL(otherind(2)));
    tv1m = (tvrd./(tvrd + tv1d)); tv2m = (tvrd./(tvrd + tv2d));
    tv1p = tv1m.*tv1 + rootpoint; tv2p = tv2m.*tv2 + rootpoint;
    k = [tv1p; tv2p]; d = true;
  endif
endfunction
