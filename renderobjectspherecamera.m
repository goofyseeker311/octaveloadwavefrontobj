function [k,d] = renderobjectspherecamera(vscene,vpos,vhres,vvres)
  vplanes=spheremapplanes(vpos,vhres);distlmod=10;vverb=true;upvector=[0 0 1];
  [vhanglelist,vvanglelist] = spheremapangles(vhres,vvres);
  drawbuffer=zeros(vvres,vhres,3);zbuffer=inf(vvres,vhres);
  for m = 1:size(vscene.objects,2)
    if (vverb) printf(['m[' num2str(m) ']: ']); endif
    drawobjtriangles = vscene.objects{m}.triangles;
    drawobjmaterial = vscene.materials{vscene.objects{m}.materialindex};
    drawobjfacecolor = [1 0.5 0.5];
    if (isfield(drawobjmaterial,"facecolor"))
      drawobjfacecolor = drawobjmaterial.facecolor;
    endif
    for n = 1:size(drawobjtriangles,3)
      smtriangle = drawobjtriangles(:,1:3,n); yhits = zeros(1,vhres);
      for L = 1:vhres
        renderplane = vplanes(L,:);
        [pint,phit] = planetriangleintersection(renderplane,smtriangle);
        if (phit) yhits(L)+=1;
          dirvec = cross(upvector,renderplane(1:3));
          pint1=pint(1,:)-vpos; pint2=pint(2,:)-vpos;
          pint3=pint(2,:)-pint(1,:); pint3n=normalizevector(pint3);
          upplane = planefromnormalatpoint(vpos,upvector);
          upplaned1 = pointplanedistance(pint(1,:),upplane);
          upplaned2 = pointplanedistance(pint(2,:),upplane);
          vecang1 = signnum(upplaned1).*vectorangle(pint1,dirvec);
          vecang2 = signnum(upplaned2).*vectorangle(pint2,dirvec);
          [svecang,svecangi] = sort([vecang1 vecang2]);
          stepyf = find((vvanglelist>=svecang(1))&(vvanglelist<=svecang(2)));
          if (!isempty(stepyf))
            alphaang = vectorangle(-pint1,pint3); alphalen = vectorlength(pint2);
            vecmult = alphalen./sind(alphaang); stepanglist = vvanglelist(stepyf)-svecang(1);
            steplenlist = vecmult.*sind(stepanglist); steppointlist = pint(1,:)+steplenlist'.*pint3n;
            stepveclist = steppointlist-vpos; stepdistlist = vectorlength(stepveclist)';
            if (svecangi(1)==2) stepdistlist = fliplr(stepdistlist); endif
            drawind = find(stepdistlist<zbuffer(stepyf,L)');
            if (!isempty(drawind))
              zbuffer(stepyf(drawind),L) = stepdistlist(drawind);
              drawbuffer(stepyf(drawind),L,1) = drawobjfacecolor(1);
              drawbuffer(stepyf(drawind),L,2) = drawobjfacecolor(2);
              drawbuffer(stepyf(drawind),L,3) = drawobjfacecolor(3);
            endif
          endif
        endif
      endfor
      yhitc = sum(yhits);
      if (vverb) printf([' ' num2str(yhitc)]); endif
    endfor
    if (vverb) printf(['\n']); endif
    k = drawbuffer; d = zbuffer;
  endfor
endfunction
