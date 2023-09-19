function [k,d] = raytriangleintersection(vpos,vdir,vtriangle)
  k = nan(1,3); d = false;
  tplane = planefrompoints(vtriangle);
  tpdist = rayplanedistance(vpos,vdir,tplane);
  if (!any(isnan(tpdist)))
    tpoint = vpos + vdir.*tpdist; k = tpoint;
    tsideplane1 = planefrompoints([vpos;vtriangle([2 1],:)]);
    tsideplane2 = planefrompoints([vpos;vtriangle([3 2],:)]);
    tsideplane3 = planefrompoints([vpos;vtriangle([1 3],:)]);
    tsideplane1a = planefrompoints([vpos;vtriangle([1 2],:)]);
    tsideplane2a = planefrompoints([vpos;vtriangle([2 3],:)]);
    tsideplane3a = planefrompoints([vpos;vtriangle([3 1],:)]);
    tsidepdist1 = pointplanedistance(tpoint,tsideplane1);
    tsidepdist2 = pointplanedistance(tpoint,tsideplane2);
    tsidepdist3 = pointplanedistance(tpoint,tsideplane3);
    tsidepdist1a = pointplanedistance(tpoint,tsideplane1a);
    tsidepdist2a = pointplanedistance(tpoint,tsideplane2a);
    tsidepdist3a = pointplanedistance(tpoint,tsideplane3a);
    if ((tsidepdist1>=0)&&(tsidepdist2>=0)&&(tsidepdist3>=0)|| ...
      (tsidepdist1a>=0)&&(tsidepdist2a>=0)&&(tsidepdist3a>=0)) d = true;
    endif
  endif
endfunction
