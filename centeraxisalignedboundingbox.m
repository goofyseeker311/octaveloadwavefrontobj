function [k] = centeraxisalignedboundingbox(vvertexlist)
  vaabb=axisalignedboundingbox(vvertexlist);
  vcenteraabb = (vaabb(1:3)+vaabb(4:6))./2;
  vcenteraabbL = (vaabb(4:6)-vaabb(1:3))./2;
  k = [vcenteraabb vcenteraabbL];
endfunction
