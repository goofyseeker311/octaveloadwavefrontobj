function [k,d] = renderobjectspherecamera(vscene,vpos,vhres,vvres,vvrot)
  [vplanes,vpdir,vpup]=spheremapplanes(vpos,vhres,vvrot);distlmod=10;vverb=true;upvector=vpup(1:3);
  [vhanglelist,vvanglelist] = spheremapangles(vhres,vvres);
  drawbuffer=0.5.*ones(vvres,vhres,3);zbuffer=inf(vvres,vhres);
  for m = 1:size(vscene.objects,2)
    if (vverb) printf(['m[' num2str(m) ']: ']); endif
    drawobjtriangles = vscene.objects{m}.triangles;
    drawobjmaterial = vscene.materials{vscene.objects{m}.materialindex};
    drawobjfacecolor = [1 1 1];
    if (isfield(drawobjmaterial,"facecolor"))
      drawobjfacecolor = drawobjmaterial.facecolor;
    endif
    for n = 1:size(drawobjtriangles,3)
      smtriangle = drawobjtriangles(:,1:3,n); yhits = 0;
      [pints,phits,ptuvs,ptinds] = planetriangleintersection(vplanes,smtriangle);
      [plints,plhits,pldist] = raylineintersection(vpos,upvector,pints);
      cpshitc=sum(phits); cpshitf=find(phits); cpshitfc=size(cpshitf,1); yhits+=cpshitc;
      if (!isempty(cpshitf))
        cpsintvec1 = pints(cpshitf,1:3)-vpos; cpsintvec2 = pints(cpshitf,4:6)-vpos;
        cpsintdist1 = vectorlength(cpsintvec1); cpsintdist2 = vectorlength(cpsintvec2);
        cpsintang1 = signnum(cpsintvec1(:,3)).*vectorangle(cpsintvec1,vpdir(cpshitf,1:3));
        cpsintang2 = signnum(cpsintvec2(:,3)).*vectorangle(cpsintvec2,vpdir(cpshitf,1:3));
        cpsintang1ist = [cpsintang1 cpsintang2]; cpsintdistlist = [cpsintdist1 cpsintdist2];
        [cpsintangs,cpsintangsi] = sort(cpsintang1ist,2);
        cpsintangmin = cpsintangs(:,1); cpsintangmax = cpsintangs(:,2);
        stepyi = (vvanglelist>=cpsintangmin)&(vvanglelist<=cpsintangmax); stepyfn = find(!stepyi);
        vvanglelista = ones(cpshitfc,1).*vvanglelist; vvanglelista(stepyfn) = nan;
        [stepyimin,stepyimini] = min(vvanglelista,[],2); [stepyimax,stepyimaxi] = max(vvanglelista,[],2);
        stepyi2 = find(isfinite(stepyimin)&isfinite(stepyimax));
        stepyi2c = size(stepyi2,1); if (isempty(stepyi2)&&(stepyi2c>0)) stepyi2c=0; endif
        for n = 1:stepyi2c
          Lv = stepyi2(n); L = cpshitf(Lv);
          drawind = stepyimini(Lv):stepyimaxi(Lv); drawindc = size(drawind,2);
          drawdistmin = cpsintdistlist(cpsintangsi(Lv,1)); drawdistmax = cpsintdistlist(cpsintangsi(Lv,2));
          drawdist = ones(1,drawindc)*drawdistmin;
          if (drawindc>1)
            drawdistdif = drawdistmax-drawdistmin; drawdiststep = drawdistdif./(drawindc-1);
            drawdist = (drawdistmin:drawdiststep:drawdistmax)';
          endif
          drawindex = find(drawdist<zbuffer(drawind,L));
          zbuffer(drawind(drawindex),L) = drawdist(drawindex);
          drawbuffer(drawind(drawindex),L,1) = drawobjfacecolor(1);
          drawbuffer(drawind(drawindex),L,2) = drawobjfacecolor(2);
          drawbuffer(drawind(drawindex),L,3) = drawobjfacecolor(3);
        endfor
      endif
      yhitc = sum(yhits);
      if (vverb) printf([' ' num2str(yhitc)]); endif
    endfor
    if (vverb) printf(['\n']); endif
  endfor
  k=drawbuffer; d=zbuffer;
  k=rot90(k,2); d=rot90(d,2);
endfunction
