###.mtl loader tags: #,newmtl,map_kd,ns,ka,ks,ke,ni,d,illum
function [k] = loadwavefrontmtlfile(fname)
  k = []; k.materials = {}; fhandle = fopen(fname); ##read only default
  fline = []; materialcount = 0;
  while((fline=fgets(fhandle))!=-1)
    fline = strtrim(fline);
    #fline = substr(fline,1,length(fline));
    #printf("%s\n",fline); #fline
    if (strncmp(lower(fline),"#",1))
      ##comment ignored
    elseif (strncmp(lower(fline),"newmtl ",7))
      farg = strtrim(substr(fline, 8));
      materialcount += 1;
      k.materials{materialcount}.material = farg;
    elseif (strncmp(lower(fline),"map_kd ",7))
      farg = strtrim(substr(fline, 8));
      k.materials{materialcount}.filename = farg;
    endif
  endwhile
  fclose(fhandle);
endfunction
