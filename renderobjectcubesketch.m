function [k,d] = renderobjectcubesketch(vscene,vpos,vres)
  distlmod=10;vverb=true;k={};d={}; [cmang,cmstep] = cubemapangles(vres);
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
    [cint,chit,cdist] = cubemapsphereintersection(vpos,csphere,vres);
    if (chit)
      for n = 1:6
        cxylines = cint{n};
        if (all(isfinite(cxylines)))
          hcmlines = cxylines(1):cxylines(2); vcmlines = cxylines(3):cxylines(4);
          zbuffer = d{n}(vcmlines,hcmlines); drawindex = find(cdist<zbuffer);
          zbuffer(drawindex) = cdist; d{n}(vcmlines,hcmlines) = zbuffer;
          drawbuffer1=k{n}(vcmlines,hcmlines,1);drawbuffer1(drawindex)=drawobjfacecolor(1);k{n}(vcmlines,hcmlines,1)=drawbuffer1;
          drawbuffer2=k{n}(vcmlines,hcmlines,2);drawbuffer2(drawindex)=drawobjfacecolor(2);k{n}(vcmlines,hcmlines,2)=drawbuffer2;
          drawbuffer3=k{n}(vcmlines,hcmlines,3);drawbuffer3(drawindex)=drawobjfacecolor(3);k{n}(vcmlines,hcmlines,3)=drawbuffer3;
        endif
      endfor
    endif
  endfor
  if (vverb) printf(['\n']); endif
  k{1} = rot90(k{1},2); d{1} = rot90(d{1},2);
  k{2} = fliplr(rot90(k{2},2)); d{2} = fliplr(rot90(d{2},2));
  k{3} = fliplr(rot90(k{3},2)); d{3} = fliplr(rot90(d{3},2));
  k{4} = rot90(k{4},2); d{4} = rot90(d{4},2);
  k{5} = rot90(k{5},-1); d{5} = rot90(d{5},-1);
  k{6} = rot90(flipud(k{6}),1); d{6} = rot90(flipud(d{6}),1);
endfunction
