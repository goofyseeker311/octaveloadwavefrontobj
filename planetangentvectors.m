function [k] = planetangentvectors(vpos,vplane)
  v1=vplane(:,[2 3 1]);
  s1=planefromnormalatpoint(vpos,normalizevector(cross(v1,vplane(:,1:3),2)));
  s2=planefromnormalatpoint(vpos,normalizevector(cross(s1(:,1:3),vplane(:,1:3),2)));
  k=s1; k(:,:,2)=s2;
endfunction
