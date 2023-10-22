function [k,d] = renderobjectprojectedcamera(vscene,vpos,hres,vres,hfov,vfov)
  [prplanes,prpd,prpu,prpdir]=projectedplanes(vpos,hres,vres,hfov,vfov); distlmod=10;vverb=true;k={};d={};
  [prhanglelist,prhsteplist,prvanglelist,prvsteplist,dasp,aasp]=projectedangles(hres,vres,hfov,vfov);
  renderplanes=prplanes{1,1}; dirvec=prpd{1,1}(1:3); upvector=prpu{1,1}(1:3);
  renderplanesc = size(renderplanes,1); vpdir = cross(renderplanes(:,1:3),ones(renderplanesc,1).*upvector,2);
  vposplane = planefromnormalatpoint(vpos,dirvec); upvectorplane = planefromnormalatpoint(vpos,upvector);
  drawbuffer = 0.5.*ones(vres,hres,3); zbuffer = inf(vres,hres);
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
      [pints,phits,ptuvs,ptinds] = planetriangleintersection(renderplanes,smtriangle);
      [plints,plhits,pldist] = raylineintersection(vpos,upvector,pints);
      cpshitc=sum(phits); cpshitf=find(phits); cpshitfc=size(cpshitf,1); yhits+=cpshitc;
      if (!isempty(cpshitf))
        cpsintvec1 = pints(cpshitf,1:3)-vpos; cpsintvec2 = pints(cpshitf,4:6)-vpos;
        cpsintdist1 = vectorlength(cpsintvec1); cpsintdist2 = vectorlength(cpsintvec2);
        vposplanedist1 = pointplanedistance(pints(cpshitf,1:3),vposplane);
        vposplanedist2 = pointplanedistance(pints(cpshitf,4:6),vposplane);
        upvectorplanedist1 = pointplanedistance(pints(cpshitf,1:3),upvectorplane);
        upvectorplanedist2 = pointplanedistance(pints(cpshitf,4:6),upvectorplane);
        cpsintang1 = atand(upvectorplanedist1./abs(vposplanedist1));
        cpsintang2 = atand(upvectorplanedist2./abs(vposplanedist2));
        cpsintang1f = find(vposplanedist1<0); cpsintang1(cpsintang1f)=180-cpsintang1(cpsintang1f);
        cpsintang2f = find(vposplanedist2<0); cpsintang2(cpsintang2f)=180-cpsintang2(cpsintang2f);
        cpsintang1ist = [cpsintang1 cpsintang2]; cpsintdistlist = [cpsintdist1 cpsintdist2];
        [cpsintangs,cpsintangsi] = sort(cpsintang1ist,2);
        cpsintangmin = cpsintangs(:,1); cpsintangmax = cpsintangs(:,2);
        stepyi = (prvanglelist>=cpsintangmin)&(prvanglelist<=cpsintangmax); stepyfn = find(!stepyi);
        prvanglelista = ones(cpshitfc,1).*prvanglelist; prvanglelista(stepyfn) = nan;
        [stepyimin,stepyimini] = min(prvanglelista,[],2); [stepyimax,stepyimaxi] = max(prvanglelista,[],2);
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
  k = rot90(drawbuffer,2); d = rot90(zbuffer,2);
endfunction
