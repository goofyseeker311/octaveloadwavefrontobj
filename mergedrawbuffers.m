function [k,d] = mergedrawbuffers(dbuffer1,zbuffer1,dbuffer2,zbuffer2)
  k = dbuffer1; d = zbuffer1; dindex = find(zbuffer2<zbuffer1);
  tdbuffer11 = dbuffer1(:,:,1); tdbuffer21 = dbuffer2(:,:,1);
  tdbuffer12 = dbuffer1(:,:,2); tdbuffer22 = dbuffer2(:,:,2);
  tdbuffer13 = dbuffer1(:,:,3); tdbuffer23 = dbuffer2(:,:,3);
  tdbuffer11(dindex) = tdbuffer21(dindex); k(:,:,1) = tdbuffer11;
  tdbuffer12(dindex) = tdbuffer22(dindex); k(:,:,2) = tdbuffer12;
  tdbuffer13(dindex) = tdbuffer23(dindex); k(:,:,3) = tdbuffer13;
  d(dindex) = zbuffer2(dindex);
endfunction
