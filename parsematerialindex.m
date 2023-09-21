function [k] = parsematerialindex(modelstruct)
  k = modelstruct;
  for n = 1:size(k.objects,2)
    usemtl = k.objects{n}.usemtl; matind = nan;
    for m = 1:size(k.materials,2)
      if (isequaln(k.materials{m}.material,usemtl))
        matind = m;
      endif
    endfor
    k.objects{n}.materialindex = matind;
  endfor
endfunction
