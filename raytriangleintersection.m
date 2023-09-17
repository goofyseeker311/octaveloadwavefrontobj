function [k,d] = raytriangleintersection(vpos,vdir,vtriangle)
  k = []; d = [];
  tplane = planefrompoints(vtriangle);
  tpdist = rayplanedistance(vpos,vdir,tplane);
  if (!isempty(tpdist))
    tpoint = vpos + vdir.*tpdist; k = tpoint;
    tsideplane1 = planefrompoints([vpos;vtriangle([2 1],:)]);
    tsideplane2 = planefrompoints([vpos;vtriangle([3 2],:)]);
    tsideplane3 = planefrompoints([vpos;vtriangle([1 3],:)]);
    tsidepdist1 = pointplanedistance(tpoint,tsideplane1);
    tsidepdist2 = pointplanedistance(tpoint,tsideplane2);
    tsidepdist3 = pointplanedistance(tpoint,tsideplane3);
    if ((tsidepdist1>=0)&&(tsidepdist2>=0)&&(tsidepdist3>=0)) d = true; endif
  endif
endfunction
