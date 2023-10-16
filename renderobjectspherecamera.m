function [k,d] = renderobjectspherecamera(vscene,vpos,vhres,vvres)
  [vplanes,vpdir,vpup]=spheremapplanes(vpos,vhres);distlmod=10;vverb=true;upvector=[0 0 1];
  [vhanglelist,vvanglelist] = spheremapangles(vhres,vvres);
  drawbuffer=zeros(vvres,vhres,3);zbuffer=inf(vvres,vhres);
  for m = 1:size(vscene.objects,2)
    if (vverb) printf(['m[' num2str(m) ']: ']); endif
    drawobjtriangles = vscene.objects{m}.triangles;
    drawobjmaterial = vscene.materials{vscene.objects{m}.materialindex};
    drawobjfacecolor = [1 1 1];
    if (isfield(drawobjmaterial,"facecolor"))
      drawobjfacecolor = drawobjmaterial.facecolor;
    endif
    for n = 1:size(drawobjtriangles,3)
      smtriangle = drawobjtriangles(:,1:3,n); yhits = zeros(1,vhres);
      [pints,phits,ptuvs,ptinds] = planetriangleintersection(vplanes,smtriangle);
      [plints,plhits,pldist] = raylineintersection(vpos,upvector,pints);
      for L = 1:vhres
        pint = pints(L,:); phit = phits(L); renderplane = vplanes(L,:);
        if (phit) yhits(L)+=1;
          dirvec = vpdir(L,1:3); pintv1 = pint(1,1:3); pintv2 = pint(1,4:6);
          pint1=pintv1-vpos; pint2=pintv2-vpos; pint3=pintv2-pintv1; pint3n=normalizevector(pint3);
          vecang1 = signnum(pint1(3)).*vectorangle(pint1,dirvec);
          vecang2 = signnum(pint2(3)).*vectorangle(pint2,dirvec);
          [svecang,svecangi] = sort([vecang1 vecang2]);
          stepyi = (vvanglelist>=svecang(1))&(vvanglelist<=svecang(2)); stepyfn = find(!stepyi);
          vvanglelista = vvanglelist; vvanglelista(stepyfn) = nan;
          [stepyimin,stepyimini] = min(vvanglelista,[],2);
          [stepyimax,stepyimaxi] = max(vvanglelista,[],2);
          stepyf = stepyimini:stepyimaxi;
          if (!isempty(stepyf))
            alphaang = vectorangle(-pint1,pint3); alphalen = vectorlength(pint2);
            vecmult = alphalen./sind(alphaang); stepanglist = vvanglelist(stepyf)-svecang(1);
            steplenlist = vecmult.*sind(stepanglist); steppointlist = pintv1+steplenlist'.*pint3n;
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
