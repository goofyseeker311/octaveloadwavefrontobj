function [k] = parsetrianglemesh(modelstruct)
  k = modelstruct;
  vlist = k.vertexlist; tlist = k.texturecoords; nlist = k.facenormals;
  for n = 1:size(k.objects,2)
    k.objects{n}.triangles = [];
    for m = 1:size(k.objects{n}.faceindex,3)
      flist = k.objects{n}.faceindex(:,:,m);
      v1=vlist(flist(1,1),:);v2=vlist(flist(2,1),:);v3=vlist(flist(3,1),:);
      t1=tlist(flist(1,2),:);t2=tlist(flist(2,2),:);t3=tlist(flist(3,2),:);
      n1=nlist(flist(1,3),:);n2=nlist(flist(2,3),:);n3=nlist(flist(3,3),:);
      k.objects{n}.triangles(:,:,m) = [v1 t1 n1;v2 t2 n2;v3 t3 n3];
    endfor
  endfor
endfunction
