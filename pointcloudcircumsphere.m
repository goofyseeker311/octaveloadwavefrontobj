function [k,d] = pointcloudcircumsphere(vpointlist)
  minlimits = min(vpointlist); maxlimits = max(vpointlist);
  k = mean([minlimits;maxlimits]); d = max(vectorlength(k-vpointlist));
endfunction
