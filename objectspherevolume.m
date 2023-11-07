function [k] = objectspherevolume(vscene)
  k=[]; vsceneaabb = axisalignedboundingbox(vscene.vertexlist);
  for m = 1:size(vscene.objects,2)
    drawobjtriangles = vscene.objects{m}.triangles;
    cpoints = [drawobjtriangles(:,1,:)(:) drawobjtriangles(:,2,:)(:) drawobjtriangles(:,3,:)(:)];
    csphere = pointcloudcircumsphere(cpoints);
    k(end+1,:) = csphere;
  endfor
endfunction
