function [k,d,f,g,p] = renderobjectrayscamera(vscene,vpos,vrays)
  vhres = size(vrays,2); vvres = size(vrays,1); distlmod=10;vverb=false;
  linvrays = reshape(vrays,vhres*vvres,3);
  drawbuffer=zeros(vvres,vhres,3);zbuffer=inf(vvres,vhres);
  obuffer=nan(vvres,vhres);tbuffer=nan(vvres,vhres);nbuffer=nan(vvres,vhres,3);
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
      [lintrint,lintrhit,lintrdist,lintruvs,lintrhits]=raytriangleintersection(vpos,linvrays,smtriangle);
      yhits = sum(lintrhit); drawindex = find((lintrhit==true)&(lintrdist>0));
      drawzindex = find(lintrdist(drawindex)<zbuffer(drawindex)); drawzcombindex = drawindex(drawzindex);
      zbuffer(drawzcombindex)=lintrdist(drawzcombindex);obuffer(drawzcombindex)=m;tbuffer(drawzcombindex)=n;
      drawbuffer1=drawbuffer(:,:,1);drawbuffer2=drawbuffer(:,:,2);drawbuffer3=drawbuffer(:,:,3);
      drawbuffer1(drawzcombindex)=drawobjfacecolor(1);
      drawbuffer2(drawzcombindex)=drawobjfacecolor(2);
      drawbuffer3(drawzcombindex)=drawobjfacecolor(3);
      drawbuffer(:,:,1)=drawbuffer1;drawbuffer(:,:,2)=drawbuffer2;drawbuffer(:,:,3)=drawbuffer3;
      if (vverb) printf([' ' num2str(yhits)]); endif
    endfor
    if (vverb) printf(['\n']); endif
  endfor
  k = drawbuffer; d = zbuffer; f = obuffer; f(:,:,2) = tbuffer; g = nbuffer;
  p=ones(vvres,vhres).*vpos(1);p(:,:,2)=vpos(2);p(:,:,3)=vpos(3);p+=zbuffer.*vrays;
endfunction
