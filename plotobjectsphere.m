function [k] = plotobjectsphere(vscene,vpos)
  hold on; [cx,cy,cz]=sphere(10); k = nan;
  plot3(vpos(1),vpos(2),vpos(3),'b+');plot3(vpos(1),vpos(2),vpos(3),'ok');
  for m = 1:size(vscene.objects,2)
    objectm = vscene.objects{m}; drawobjtriangles = objectm.triangles;
    objectx=drawobjtriangles(:,1,:)(:);objecty=drawobjtriangles(:,2,:)(:);objectz=objectm.triangles(:,3,:)(:);
    drawobjmaterial = vscene.materials{vscene.objects{m}.materialindex};
    drawobjfacecolor = [1 1 1]; if (isfield(drawobjmaterial,"facecolor")) drawobjfacecolor = drawobjmaterial.facecolor; endif
    objectxyz = [objectx objecty objectz]; vsphere = pointcloudcircumsphere(objectxyz);
    line("xdata",objectxyz(:,1),"ydata",objectxyz(:,2),"zdata",objectxyz(:,3),'color',drawobjfacecolor);
    mesh(vsphere(4)*cx+vsphere(1),vsphere(4)*cy+vsphere(2),vsphere(4)*cz+vsphere(3),'edgecolor',[0.75 0.75 0.75],'facealpha',0.1,'linewidth',0.1);
  endfor
  hold off;
endfunction
