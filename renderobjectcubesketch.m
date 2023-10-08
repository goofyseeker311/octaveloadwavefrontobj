function [k,d] = renderobjectcubesketch(vscene,vpos,vres)
  distlmod=10;vverb=false;k={};d={}; [cmang,cmstep] = cubemapangles(vres);
  for n = 1:6
    k{n} = 0.5.*ones(vres,vres,3); d{n} = inf(vres,vres);
  endfor
  for m = 1:size(vscene.objects,2)
    if (vverb) printf(['m[' num2str(m) ']: ']); endif
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
    if (vverb) printf(['\n']); endif
  endfor
endfunction
