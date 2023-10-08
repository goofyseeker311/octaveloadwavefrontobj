function [k] = subsurfacerays(vrays,vnormal)
  vhres = size(vrays,2); vvres = size(vrays,1); subsufracerays = zeros(vhres,vvres);
  linvrays = reshape(vrays,vhres*vvres,3); linvraysc = size(linvrays,1);
  if ((!isempty(vnormal))&&(!isnan(vnormal)))
    linvraysang = vectorangle(linvrays,ones(linvraysc,1).*vnormal(1:3));
    subsufracerays = reshape(linvraysang>=90,vvres,vhres);
  endif
  k = subsufracerays;
endfunction
