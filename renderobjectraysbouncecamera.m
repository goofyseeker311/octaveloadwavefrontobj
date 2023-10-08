function [k] = renderobjectraysbouncecamera(vscene,vpos,vrays,vobj)
  vhres = size(vrays,2); vvres = size(vrays,1); distlmod=10;vverb=true;
  zbuffercolors = zeros(vvres,vhres,3); pixc = vhres*vvres;
  for x = 1:vhres
    if (vverb) printf(['x[' num2str(x) ']:']); endif
    for y = 1:vvres
    if (vverb) printf([' ' num2str(y)]); endif
      if (all(isfinite(vpos(y,x,:))))
        drawobjtriangles=vscene.objects{vobj(y,x,1)}.triangles; smtriangle=drawobjtriangles(:,:,vobj(y,x,2));
        hitnormal = planefromnormalatpoint(smtriangle(1,1:3),smtriangle(1,6:8));
        [outdrawbuffer2,outzbuffer2,outobjbuffer2,outnormbuffer2,outpointbuffer2] = renderobjectrayscamera(vscene,vpos(y,x,:)(:)',vrays);
        outsubsrays2 = subsurfacerays(vrays,hitnormal);
        outdrawbuffer2x=outdrawbuffer2(:,:,1);outdrawbuffer2y=outdrawbuffer2(:,:,2);outdrawbuffer2z=outdrawbuffer2(:,:,3);
        zindex = find(isfinite(outzbuffer2)&(outsubsrays2==0)); zbuffercolors(y,x,1) = sum(outdrawbuffer2x(zindex))./pixc;
        zbuffercolors(y,x,2) = sum(outdrawbuffer2y(zindex))./pixc; zbuffercolors(y,x,3) = sum(outdrawbuffer2z(zindex))./pixc;
      endif
    endfor
    if (vverb) printf(['\n']); endif
  endfor
  k = zbuffercolors;
endfunction
