function [k,d] = renderobjectspherelinesketch(vscene,vpos,hres,vres)
  distlmod=10;vverb=true;k=[];d=[]; [smhanglelist,smvanglelist] = spheremapangles(hres,vres);
  [csplanes,cspd,cspu] = spheremapplanes(vpos,hres); #smvanglelista = ones(hres,1).*smvanglelist;
  k = 0.5.*ones(vres,hres,3); d = inf(vres,hres);
  if (vverb) printf(['m:']); endif
  for m = 1:size(vscene.objects,2)
    if (vverb) printf([' ' num2str(m)]); endif
    drawobjtriangles = vscene.objects{m}.triangles;
    drawobjmaterial = vscene.materials{vscene.objects{m}.materialindex};
    drawobjfacecolor = [1 1 1];
    if (isfield(drawobjmaterial,"facecolor"))
      drawobjfacecolor = drawobjmaterial.facecolor;
    endif
    cpoints = [drawobjtriangles(:,1,:)(:) drawobjtriangles(:,2,:)(:) drawobjtriangles(:,3,:)(:)];
    csphere = pointcloudcircumsphere(cpoints); cspheredist = vectorlength(csphere(1:3)-vpos);
    [cpsint,cpshit,cpsdist,cpsrad] = planesphereintersection(csplanes,csphere);
    cpshitc = sum(cpshit); cpshitf = find(cpshit); cpshitfc = size(cpshitf,1);
    if (!isempty(cpshitf))
      cpsintvec = cpsint(cpshitf,:)-vpos; cpsintdist = vectorlength(cpsintvec);
      cpsintvech = cpsintvec; cpsintvech(:,3)=0;
      cpsintang = signnum(cpsintvec(:,3)).*vectorangle(cpsintvec,cpsintvech);
      cpsintdir = vectorangle(cspd(cpshitf,1:3),cpsintvech); cpsintdirf = cpsintdir<=90;
      cpsang = asind(cpsrad(cpshitf,:)./cpsintdist);
      cpsintangmin = cpsintang-cpsang; cpsintangmax = cpsintang+cpsang;
      stepyi = (smvanglelist>=cpsintangmin)&(smvanglelist<=cpsintangmax); stepyfn = find(!stepyi);
      vvanglelista = ones(cpshitfc,1).*smvanglelist; vvanglelista(stepyfn) = nan;
      [stepyimin,stepyimini] = min(vvanglelista,[],2);
      [stepyimax,stepyimaxi] = max(vvanglelista,[],2);
      stepyi2 = find(isfinite(stepyimini)&isfinite(stepyimaxi));
      stepyi2c = size(stepyi2,1);
      for n = 1:stepyi2c
        Lv = stepyi2(n); L = cpshitf(Lv);
        if (cpsintdirf(n))
          drawind = stepyimini(Lv):stepyimaxi(Lv);
          drawindex = find(cpsintdist(Lv)<d(drawind,L));
          d(drawind(drawindex),L) = cpsintdist(Lv);
          k(drawind(drawindex),L,1) = drawobjfacecolor(1);
          k(drawind(drawindex),L,2) = drawobjfacecolor(2);
          k(drawind(drawindex),L,3) = drawobjfacecolor(3);
        endif
      endfor
    endif
  endfor
  if (vverb) printf(['\n']); endif
  k=rot90(k,2); d=rot90(d,2);
endfunction
