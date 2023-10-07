function [k] = plotobjectsphere(vscene,vpos)
  hold on; [cx,cy,cz]=sphere(10); k = nan;
  plot3(vpos(1),vpos(2),vpos(3),'b+');plot3(vpos(1),vpos(2),vpos(3),'ok');
  for m = 1:size(vscene.objects,2)
    objectm = vscene.objects{m}; drawobjtriangles = objectm.triangles;
    objectx=drawobjtriangles(:,1,:)(:);objecty=drawobjtriangles(:,2,:)(:);objectz=objectm.triangles(:,3,:)(:);
    drawobjmaterial = vscene.materials{vscene.objects{m}.materialindex};
    drawobjfacecolor = [1 1 1]; if (isfield(drawobjmaterial,"facecolor")) drawobjfacecolor = drawobjmaterial.facecolor; endif
    drawobjtx1=drawobjtriangles(1,1,:)(:);drawobjty1=drawobjtriangles(1,2,:)(:);drawobjtz1=drawobjtriangles(1,3,:)(:);
    drawobjtx2=drawobjtriangles(2,1,:)(:);drawobjty2=drawobjtriangles(2,2,:)(:);drawobjtz2=drawobjtriangles(2,3,:)(:);
    drawobjtx3=drawobjtriangles(3,1,:)(:);drawobjty3=drawobjtriangles(3,2,:)(:);drawobjtz3=drawobjtriangles(3,3,:)(:);
    drawobjtxyz = [drawobjtx1 drawobjty1 drawobjtz1 drawobjtx2 drawobjty2 drawobjtz2 drawobjtx3 drawobjty3 drawobjtz3];
    line(drawobjtxyz(:,[1 4 7 1]),drawobjtxyz(:,[2 5 8 2]),drawobjtxyz(:,[3 6 9 3]),'color',drawobjfacecolor);
    vsphere = pointcloudcircumsphere([objectx objecty objectz]);
    mesh(vsphere(4)*cx+vsphere(1),vsphere(4)*cy+vsphere(2),vsphere(4)*cz+vsphere(3),'edgecolor',[0.75 0.75 0.75],'facealpha',0.1,'linewidth',0.1);
  endfor
  hold off;
endfunction
