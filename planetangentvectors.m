function [k] = planetangentvectors(vpos,vplane)
  v1=vplane(:,[2 3 1]);s1 = planefromnormalatpoint(vpos,v1);
  v2=vplane(:,[3 1 2]);s2 = planefromnormalatpoint(vpos,v2);
  k = s1; k(:,:,2) = s2;
endfunction
