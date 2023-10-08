function [k,d] = renderobjectcubecamera(vscene,vpos,vres)
  vplanes = cubemapplanes(vpos,vres);distlmod=10;vverb=true;k={};d={};
  [cmanglelist,cmsteplist] = cubemapangles(vres);
  dirvecs=[1 0 0; 0 1 0;-1 0 0;0 -1 0;0 0 1;0 0 -1];
  upvecs=[0 0 1; 0 0 1;0 0 1;0 0 1;-1 0 0;1 0 0];
  for vd = 1:6
    renderplanes = vplanes{vd,2}; upvector = upvecs(vd,:);
    upvectorplane = planefromnormalatpoint(vpos,upvector);
    drawbuffer=0.5.*ones(vres,vres,3);zbuffer=inf(vres,vres);
    for m = 1:size(vscene.objects,2)
      if (vverb) printf(['vd[' num2str(vd) ']m[' num2str(m) ']: ']); endif
      drawobjtriangles = vscene.objects{m}.triangles;
      drawobjmaterial = vscene.materials{vscene.objects{m}.materialindex};
      drawobjfacecolor = [1 1 1];
      if (isfield(drawobjmaterial,"facecolor"))
        drawobjfacecolor = drawobjmaterial.facecolor;
      endif
      for n = 1:size(drawobjtriangles,3)
        smtriangle = drawobjtriangles(:,1:3,n); yhits = zeros(1,vres);
        for L = 1:vres
          renderplane = renderplanes(L,:);
          [pint,phit] = planetriangleintersection(renderplane,smtriangle);
          if (phit) yhits(L)+=1;
            dirvec = dirvecs(vd,:); pint1=pint(1,1:3); pint2=pint(1,4:6);
            vposplane = planefromnormalatpoint(vpos,dirvec);
            vposppdist1 = pointplanedistance(pint1,vposplane);
            vposppdist2 = pointplanedistance(pint2,vposplane);
            if ((vposppdist1>0)||(vposppdist2>0))
              pint1a = pint1; pint2a = pint2;
              if (vposppdist1>0)
                pintv12 = pint2-pint1;
                vposrpdist1 = rayplanedistance(pint1,pintv12,vposplane);
                if ((vposrpdist1>0)&&(vposrpdist1<1))
                  pint2a = vposrpdist1.*pintv12+pint1;
                endif
              elseif (vposppdist2>0)
                pintv21 = pint1-pint2;
                vposrpdist2 = rayplanedistance(pint2,pintv21,vposplane);
                if ((vposrpdist2>0)&&(vposrpdist2<1))
                  pint1a = vposrpdist2.*pintv21+pint2;
                endif
              endif
              vposppdist1a = pointplanedistance(pint1a,vposplane);
              vposppdist2a = pointplanedistance(pint2a,vposplane);
              uvecppdist1a = pointplanedistance(pint1a,upvectorplane);
              uvecppdist2a = pointplanedistance(pint2a,upvectorplane);
              pint1 = pint1a-vpos; pint2 = pint2a-vpos;
              pint3 = pint2a-pint1a; pint3n = normalizevector(pint3);
              vecang1 = atand(uvecppdist1a./vposppdist1a);
              vecang2 = atand(uvecppdist2a./vposppdist2a);
              [svecang,svecangi] = sort([vecang1 vecang2]);
              svecangf = find((cmanglelist>=svecang(1))&(cmanglelist<=svecang(2)));
              if (!isempty(svecangf))
                alphaang = vectorangle(-pint1,pint3); alphalen = vectorlength(pint2);
                vecmult = alphalen./sind(alphaang); stepanglist = cmanglelist(svecangf)-svecang(1);
                steplenlist = vecmult.*sind(stepanglist); steppointlist = pint1+steplenlist'.*pint3n;
                stepveclist = steppointlist-vpos; stepdistlist = vectorlength(stepveclist)';
                if (svecangi(1)==2) stepdistlist = fliplr(stepdistlist); endif
                drawind = find(stepdistlist<zbuffer(svecangf,L)');
                if (!isempty(drawind))
                  zbuffer(svecangf(drawind),L) = stepdistlist(drawind);
                  drawbuffer(svecangf(drawind),L,1) = drawobjfacecolor(1);
                  drawbuffer(svecangf(drawind),L,2) = drawobjfacecolor(2);
                  drawbuffer(svecangf(drawind),L,3) = drawobjfacecolor(3);
                endif
              endif
            endif
          endif
        endfor
        yhitc = sum(yhits);
        if (vverb) printf([' ' num2str(yhitc)]); endif
      endfor
      if (vverb) printf(['\n']); endif
    endfor
    k{vd} = drawbuffer; d{vd} = zbuffer;
  endfor
endfunction
