function [k,d] = pointcloudcircumsphere(vpointlist)
  k = mean(vpointlist); d = max(vectorlength(k-vpointlist));
endfunction
