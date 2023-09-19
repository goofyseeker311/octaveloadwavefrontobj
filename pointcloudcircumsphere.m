function [k] = pointcloudcircumsphere(vpointlist)
  minlimits = min(vpointlist); maxlimits = max(vpointlist);
  spherecenter = mean([minlimits;maxlimits]);
  sphereradius = max(vectorlength(spherecenter-vpointlist));
  k = [spherecenter sphereradius];
endfunction
