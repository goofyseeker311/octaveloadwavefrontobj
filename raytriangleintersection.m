function [k,d,f,u,g] = raytriangleintersection(vpos,vdir,vtri)
  vdirc=size(vdir,1);vtric=size(vtri,3);k=nan;d=nan;f=nan;u=nan;g=nan;onem=ones(vdirc,1);
  if (!isempty(vpos)&&(!isempty(vdir))&&(!isempty(vtri)))
    tplanes=planefrompoints(vtri); k=nan(vdirc,3,vtric); d=false(vdirc,vtric);
    f=nan(vdirc,vtric); u=nan(vdirc,2,vtric); g=nan(vdirc,4,vtric);
    for n = 1:vtric
      tplane=tplanes(n,:);tpdist=rayplanedistance(vpos,vdir,tplane);f(:,n)=tpdist;
      vi = find((!isnan(tpdist))&(tpdist>=0));
      if (!isempty(vi))
        p4=vpos+vdir(vi,:).*tpdist(vi,:);k(vi,:,n)=p4;
        p1=vtri(1,:,n);p2=vtri(2,:,n);p3=vtri(3,:,n);
        v12=p2-p1; v13=p3-p1; v21=-v12; v23=p3-p2; v31=-v13; v32=-v23;
        v12n=normalizevector(v12);v13n=normalizevector(v13);v23n=normalizevector(v23);
        v12L = vectorlength(v12); v13L=vectorlength(v13);v23L=vectorlength(v23);
        a1=vectorangle(v12,v13); a2=vectorangle(v21,v23); a3=vectorangle(v31,v32);
        t1 = p4-p1; t2 = p4-p2; t3 = p4-p3; onem2 = onem(vi,1);
        h12 = vectorangle(onem2.*v12,t1); h13 = vectorangle(onem2.*v13,t1);
        h21 = vectorangle(onem2.*v21,t2); h23 = vectorangle(onem2.*v23,t2);
        h31 = vectorangle(onem2.*v31,t3); h32 = vectorangle(onem2.*v32,t3);
        ci=find((h12<=a1)&(h13<=a1)&(h21<=a2)&(h23<=a2)&(h31<=a3)&(h32<=a3));
        if(!isempty(ci))
          vci = vi(ci);
          tv12 = dot(onem2.*v12n,t1,2); tv12q = tv12./v12L;
          tv13 = dot(onem2.*v13n,t1,2); tv13q = tv13./v13L;
          d(vci,n)=true; u(vci,:,n)=[tv12q(ci) tv13q(ci)]; g(vci,:,n)=onem(vci,1).*[1 2 1 3];
        endif
      endif
    endfor
  endif
endfunction
