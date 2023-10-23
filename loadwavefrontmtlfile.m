function [k] = loadwavefrontmtlfile(fname)
  k = []; k.materials = {}; fhandle = fopen(fname);
  fline = []; materialcount = 0;
  while((fline=fgets(fhandle))!=-1)
    fline = strtrim(fline);
    if (strncmp(lower(fline),"#",1))
    elseif (strncmp(lower(fline),"newmtl ",7))
      farg = strtrim(substr(fline, 8));
      materialcount += 1;
      k.materials{materialcount}.material = farg;
    elseif (strncmp(lower(fline),"map_kd ",7))
      farg = strtrim(substr(fline, 8));
      k.materials{materialcount}.filename = farg;
      k.materials{materialcount}.fileimage = imread(farg);
    elseif (strncmp(lower(fline),"kd ",3))
      farg = strtrim(substr(fline, 4));
      k.materials{materialcount}.facecolor = str2num(farg);
    endif
  endwhile
  fclose(fhandle);
endfunction
