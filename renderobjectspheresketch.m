function [k,d] = renderobjectspheresketch(vscene,vpos,hres,vres)
  distlmod=10;vverb=false;k=[];d=[]; [smhanglelist,smvanglelist] = spheremapangles(hres,vres);
  k = 0.5.*ones(vres,hres,3); d = inf(vres,hres);
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
    [cint,chit,cdist] = spheremapsphereintersection(vpos,csphere,hres,vres);
    if (chit)
        cxylines = cint;
        if (all(isfinite(cxylines)))
          hcmlines = cxylines(1):cxylines(2); vcmlines = cxylines(3):cxylines(4);
          if (cxylines(1)>cxylines(2)) hcmlines =[1:cxylines(2) cxylines(1):hres]; endif
          zbuffer = d(vcmlines,hcmlines); drawindex = find(cdist<zbuffer);
          zbuffer(drawindex) = cdist; d(vcmlines,hcmlines) = zbuffer;
          drawbuffer1=k(vcmlines,hcmlines,1);drawbuffer1(drawindex)=drawobjfacecolor(1);k(vcmlines,hcmlines,1)=drawbuffer1;
          drawbuffer2=k(vcmlines,hcmlines,2);drawbuffer2(drawindex)=drawobjfacecolor(2);k(vcmlines,hcmlines,2)=drawbuffer2;
          drawbuffer3=k(vcmlines,hcmlines,3);drawbuffer3(drawindex)=drawobjfacecolor(3);k(vcmlines,hcmlines,3)=drawbuffer3;
        endif
    endif
    if (vverb) printf(['\n']); endif
  endfor
endfunction
