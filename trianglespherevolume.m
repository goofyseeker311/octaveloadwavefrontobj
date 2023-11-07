function [k] = trianglespherevolume(vscene)
  k=[]; vsceneaabb = axisalignedboundingbox(vscene.vertexlist);
  for m = 1:size(vscene.objects,2)
    drawobjtriangles = vscene.objects{m}.triangles;
    trspherelist = trianglecircumsphere(drawobjtriangles(:,1:3,:));
    trspherelistc = size(trspherelist,1);
    trspherelistind = [trspherelist m.*ones(trspherelistc,1) (1:trspherelistc)'];
    k(end+1:end+trspherelistc,:) = trspherelistind;
  endfor
endfunction
