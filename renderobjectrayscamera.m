function [k,d] = renderobjectrayscamera(vscene,vpos,vrays)
  vhres = size(vrays,2); vvres = size(vrays,1); distlmod=10;vverb=true;
  drawbuffer=0.5.*ones(vvres,vhres,3);zbuffer=inf(vvres,vhres);
  for m = 1:size(vscene.objects,2)
    if (vverb) printf(['m[' num2str(m) ']: ']); endif
    drawobjtriangles = vscene.objects{m}.triangles;
    drawobjmaterial = vscene.materials{vscene.objects{m}.materialindex};
    drawobjfacecolor = [1 1 1];
    if (isfield(drawobjmaterial,"facecolor"))
      drawobjfacecolor = drawobjmaterial.facecolor;
    endif
    ntriangles = size(drawobjtriangles,3);
    for n = 1:ntriangles
      smtriangle = drawobjtriangles(:,1:3,n); yhits = zeros(1,ntriangles);
      for Ly = 1:vvres
        for Lx = 1:vhres
          [trint,trhit,trdist,truvs,trhits]=raytriangleintersection(vpos,vrays(Ly,Lx,:)(:)',smtriangle);
          if (trhit) yhits(n)+=1;
            if ((trdist>0)&&(trdist<zbuffer(Ly,Lx)))
              zbuffer(Ly,Lx) = trdist;
              drawbuffer(Ly,Lx,:) = drawobjfacecolor./(trdist./distlmod);
            endif
          endif
        endfor
      endfor
      yhitc = sum(yhits);
      if (vverb) printf([' ' num2str(yhitc)]); endif
    endfor
    if (vverb) printf(['\n']); endif
  endfor
  k = drawbuffer; d = zbuffer;
endfunction
