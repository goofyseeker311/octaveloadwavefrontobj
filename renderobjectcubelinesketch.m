function [k,d] = renderobjectcubelinesketch(vscene,vpos,vres)
  distlmod=10;vverb=true;k={};d={}; [cmanglelist,cmsteplist] = cubemapangles(vres);
  [cvplanes,cvpd,cvpup] = cubemapplanes(vpos,vres);
  for n = 1:6
    k{n} = 0.5.*ones(vres,vres,3); d{n} = inf(vres,vres);
  endfor
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
    csphere = pointcloudcircumsphere(cpoints);
    for vd = 1:6
      cpsplanes = cvplanes{vd,2}; vposplane = cvpd{vd,2}; upvectorplane = cvpup{vd,2};
      [cpsint,cpshit,cpsdist,cpsrad] = planesphereintersection(cpsplanes,csphere);
      cpshitc = sum(cpshit); cpshitf = find(cpshit); cpshitfc = size(cpshitf,1);
      if (!isempty(cpshitf))
        cpsintvec = cpsint(cpshitf,:)-vpos; cpsintdist = vectorlength(cpsintvec);
        vposplanedist = pointplanedistance(cpsint(cpshitf,:),vposplane);
        upvectorplanedist = pointplanedistance(cpsint(cpshitf,:),upvectorplane);
        cpsintang = atand(upvectorplanedist./abs(vposplanedist));
        cpsintangf = find(vposplanedist<0); cpsintang(cpsintangf)=180-cpsintang(cpsintangf);
        cpsang = asind(cpsrad(cpshitf,:)./cpsintdist);
        cpsintangmin = cpsintang-cpsang; cpsintangmax = cpsintang+cpsang;
        stepyi = (cmanglelist>=cpsintangmin)&(cmanglelist<=cpsintangmax); stepyfn = find(!stepyi);
        vvanglelista = ones(cpshitfc,1).*cmanglelist; vvanglelista(stepyfn) = nan;
        [stepyimin,stepyimini] = min(vvanglelista,[],2);
        [stepyimax,stepyimaxi] = max(vvanglelista,[],2);
        stepyi2 = find(isfinite(stepyimin)&isfinite(stepyimax));
        stepyi2c = size(stepyi2,1); if (isempty(stepyi2)&&(stepyi2c>0)) stepyi2c=0; endif
        for n = 1:stepyi2c
          Lv = stepyi2(n); L = cpshitf(Lv);
          drawind = stepyimini(Lv):stepyimaxi(Lv);
          drawindex = find(cpsintdist(Lv)<d{vd}(drawind,L));
          d{vd}(drawind(drawindex),L) = cpsintdist(Lv);
          k{vd}(drawind(drawindex),L,1) = drawobjfacecolor(1);
          k{vd}(drawind(drawindex),L,2) = drawobjfacecolor(2);
          k{vd}(drawind(drawindex),L,3) = drawobjfacecolor(3);
        endfor
      endif
    endfor
  endfor
  if (vverb) printf(['\n']); endif
  ks = k{5}; k{5} = k{6}; k{6} = ks; ds = d{5}; d{5} = d{6}; d{6} = ds;
  k{1} = fliplr(k{1}); d{1} = fliplr(d{1});
  k{2} = fliplr(k{2}); d{2} = fliplr(d{2});
  k{3} = fliplr(k{3}); d{3} = fliplr(d{3});
  k{4} = fliplr(k{4}); d{4} = fliplr(d{4});
  k{5} = fliplr(k{5}); d{5} = fliplr(d{5});
  k{6} = rot90(flipud(k{6}),2); d{6} = rot90(flipud(d{6}),2);
endfunction
