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
      smtriangle = drawobjtriangles(:,1:3,n); yhits = 0;
      linvrays = reshape(vrays,vhres*vvres,3);
      [lintrint,lintrhit,lintrdist,lintruvs,lintrhits]=raytriangleintersection(vpos,linvrays,smtriangle);
      yhits = sum(lintrhit); drawindex = find((lintrhit==true)&(lintrdist>=0));
      drawzindex = find(lintrdist(drawindex)<zbuffer(drawindex)); drawzcombindex = drawindex(drawzindex);
      zbuffer(drawzcombindex) = lintrdist(drawzcombindex);
      drawbuffer1=drawbuffer(:,:,1);drawbuffer2=drawbuffer(:,:,2);drawbuffer3=drawbuffer(:,:,3);
      drawbuffer1(drawzcombindex)=drawobjfacecolor(1); #./(lintrdist(drawzcombindex)./distlmod);
      drawbuffer2(drawzcombindex)=drawobjfacecolor(2); #./(lintrdist(drawzcombindex)./distlmod);
      drawbuffer3(drawzcombindex)=drawobjfacecolor(3); #./(lintrdist(drawzcombindex)./distlmod);
      drawbuffer(:,:,1)=drawbuffer1;drawbuffer(:,:,2)=drawbuffer2;drawbuffer(:,:,3)=drawbuffer3;
      if (vverb) printf([' ' num2str(yhits)]); endif
    endfor
    if (vverb) printf(['\n']); endif
  endfor
  k = drawbuffer; d = zbuffer;
endfunction
