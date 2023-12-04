function [k,f] = rayrayintersection2d(vpos1,vdir1,vpos2,vdir2)
  vpos1c=size(vpos1,1);vdir1c=size(vdir1,1);vpos2c=size(vpos2,1);vdir2c=size(vdir2,1);
  k = [];
  if ((vpos1c>=0)&&(vpos1c==vpos2c)&&(vpos1c==vdir1c)&&(vpos2c==vdir2c))
    k = nan(vpos1c,2);
    top1 = (vpos1(:,1)-vpos2(:,1)).*vdir1(:,2) + (vpos2(:,2)-vpos1(:,2)).*vdir1(:,1);
    bottom1 = vdir2(:,1).*vdir1(:,2) - vdir2(:,2).*vdir1(:,1) - vpos2(:,1);
    top2 = (vpos2(:,1)-vpos1(:,1)).*vdir2(:,2) + (vpos1(:,2)-vpos2(:,2)).*vdir2(:,1);
    bottom2 = vdir1(:,1).*vdir2(:,2) - vdir1(:,2).*vdir2(:,1) - vpos1(:,1);
    k1 = top2./bottom2;
    k2 = top1./bottom1;
    kp1 = vpos1+k1.*vdir1;
    kp2 = vpos2+k2.*vdir2;
    khit = isfinite(k1)&isfinite(k2)&sum(kp1!=kp2,2)==0;
    kf = find(khit);
    k(kf,:) = kp1(kf,1:2);
    f = khit;
  endif
endfunction
