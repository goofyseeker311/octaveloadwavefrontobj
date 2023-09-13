function [k] = loadwavefrontobjfile(fname)
  k = []; k.objects = {}; fhandle = fopen(fname);
  fline = []; objectcount = 0; flinecount = 0;
  while((fline=fgets(fhandle))!=-1)
    fline = strtrim(fline);
    if (strncmp(lower(fline),"#",1))
    elseif (strncmp(lower(fline),"mtllib ",7))
      farg = strtrim(substr(fline, 8)); k.mtllib = farg;
      k.materials = loadwavefrontmtlfile(farg).materials;
    elseif (strncmp(lower(fline),"o ",2))
      farg = strtrim(substr(fline, 3));
      objectcount += 1;
      k.objects{objectcount}.object = farg;
      k.objects{objectcount}.vertexlist = [];
      k.objects{objectcount}.facenormals = [];
      k.objects{objectcount}.texturecoords = [];
      k.objects{objectcount}.smoothgroups = {};
    elseif (strncmp(lower(fline),"v ",2))
      farg = strtrim(substr(fline, 3));
      vline = str2num(farg);
      k.objects{objectcount}.vertexlist(end+1,:) = vline;
    elseif (strncmp(lower(fline),"vn ",3))
      farg = strtrim(substr(fline, 4));
      vnline = str2num(farg);
      k.objects{objectcount}.facenormals(end+1,:) = vnline;
    elseif (strncmp(lower(fline),"vt ",3))
      farg = strtrim(substr(fline, 4));
      vtline = str2num(farg);
      k.objects{objectcount}.texturecoords(end+1,:) = vtline;
    elseif (strncmp(lower(fline),"usemtl ",7))
      farg = strtrim(substr(fline, 8));
      k.objects{objectcount}.usemtl = farg;
    elseif (strncmp(lower(fline),"f ",2))
      farg = strtrim(substr(fline, 3));
      fcline = strsplit(farg,{" "});
      fclinemat = {}; flinecount += 1;
      for n = 1:size(fcline,2)
        fclinecol = strsplit(fcline{n},{"/"});
        fclinecolmat = [];
        for m = 1:size(fclinecol,2)
          fclinecolmat(1,m) = str2num(fclinecol{m});
        endfor
        fclinemat{n} = fclinecolmat;
      endfor
      k.objects{objectcount}.faceindex{flinecount} = fclinemat;
    endif
  endwhile
  fclose(fhandle);
endfunction
