function [k,d,f] = raytriangleintersection(vpos,vdir,vtri)
  k = nan(1,3); d = false; tplane = planefrompoints(vtri);
  tpdist = rayplanedistance(vpos,vdir,tplane); f = tpdist;
  if ((!any(isnan(tpdist)))&&(tpdist>=0))
    p4 = vpos + vdir.*tpdist; k = p4; p1=vtri(1,:); p2=vtri(2,:); p3=vtri(3,:);
    v12 = p2-p1; v13 = p3-p1; v21 = -v12; v23 = p3-p2; v31 = -v13; v32 = -v23;
    a1=vectorangle(v12,v13); a2=vectorangle(v21,v23); a3=vectorangle(v31,v32);
    t1 = p4-p1; t2 = p4-p2; t3 = p4-p3;
    h12 = vectorangle(v12,t1); h13 = vectorangle(v13,t1);
    h21 = vectorangle(v21,t2); h23 = vectorangle(v23,t2);
    h31 = vectorangle(v31,t3); h32 = vectorangle(v32,t3);
    if ((h12<=a1)&&(h13<=a1)&&(h21<=a2)&&(h23<=a2)&&(h31<=a3)&&(h32<=a3))
      d = true;
    endif
  endif
endfunction
