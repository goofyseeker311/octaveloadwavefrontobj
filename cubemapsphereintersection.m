function [k,d] = cubemapsphereintersection(vpos,vsphere,res)
  global cmangles cmres; k = {}; d = false;
  lvec = vsphere(1:3)-vpos; lvecl = vectorlength(lvec);
  if (isempty(cmres)||isempty(cmangles)||(res!=cmres))
    cmres = res; cmangles = cubemapangles(res);
  endif
  if (lvecl!=0)
    cmradang = asind(vsphere(4)./lvecl);
    cubedir = [ [1 0 0] [3 2]; [-1  0  0] [3 2];
                [0 1 0] [3 1]; [ 0 -1  0] [3 1];
                [0 0 1] [2 1]; [ 0  0 -1] [2 1]; ];
    for n = 1:size(cubedir,1)
      cbvecxp=cubedir(n,1:3); cubeind1=cubedir(n,4); cubeind2=cubedir(n,5);
      lvecx1 = lvec; lvecx1(cubeind1)=0;
      lvecx2 = lvec; lvecx2(cubeind2)=0;
      lvecx1n = normalizevector(lvecx1); lvecx2n = normalizevector(lvecx2);
      lvecx1a = signnum(lvecx1n(cubeind2)).*acosd(dot(lvecx1n,cbvecxp));
      lvecx2a = signnum(lvecx2n(cubeind1)).*acosd(dot(lvecx2n,cbvecxp));
      lvecx1L = lvecx1a-cmradang; lvecx1H = lvecx1a+cmradang;
      lvecx2L = lvecx2a-cmradang; lvecx2H = lvecx2a+cmradang;
      lvecx1I = (cmangles>=lvecx1L) & (cmangles<=lvecx1H);
      lvecx2I = (cmangles>=lvecx2L) & (cmangles<=lvecx2H);
      lvecx1A = cmangles(find(lvecx1I)); lvecx2A = cmangles(find(lvecx2I));
      k{1,n} = lvecx1A; k{2,n} = lvecx2A;
      if ((!isempty(lvecx2A))&&(!isempty(lvecx1A))) d = true; endif;
    endfor
  else
    k = {cmangles}; d = true;
  endif
endfunction
