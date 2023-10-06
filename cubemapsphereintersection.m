function [k,d] = cubemapsphereintersection(vpos,vsphere,vres)
  global cmangles cmres; k = {}; d = false; vspherec = size(vsphere,1);
  lvec = vsphere(:,1:3)-vpos; lvecl = vectorlength(lvec);
  if (isempty(cmres)||isempty(cmangles)||(vres!=cmres))
    cmres = vres; cmangles = cubemapangles(vres);
  endif
  lvecli=find(lvecl);lveclin=find(!lvecl);lveclic=size(lvecli,1);lveclinc=size(lveclin,1);
  for n = 1:6
    k{n,1} = nan(vspherec,2); k{n,1}(lveclin,:) = ones(lveclinc,1).*cmangles([1 end]);
    k{n,2} = nan(vspherec,2); k{n,2}(lveclin,:) = ones(lveclinc,1).*cmangles([1 end]);
  endfor
  d(lveclin,1) = true(lveclinc,1);
  if (!isempty(lvecli))
    cmradang = asind(vsphere(lvecli,4)./lvecl(lvecli,1));
    cubedir = [ [ 1 0 0] [3 2]; [0  1  0] [3 1];
                [-1 0 0] [3 2]; [0 -1  0] [3 1];
                [ 0 0 1] [2 1]; [0  0 -1] [2 1]; ];
    for n = 1:6
      cbvecxp=cubedir(n,1:3); cubeind1=cubedir(n,4); cubeind2=cubedir(n,5);
      lvecx1=lvec(lvecli,:);lvecx1(:,cubeind1)=0;lvecx2=lvec(lvecli,:);lvecx2(:,cubeind2)=0;
      lvecx1n = normalizevector(lvecx1); lvecx2n = normalizevector(lvecx2);
      lvecx1a = signnum(lvecx1n(:,cubeind2)).*acosd(dot(lvecx1n,ones(lveclic,1).*cbvecxp,2));
      lvecx2a = signnum(lvecx2n(:,cubeind1)).*acosd(dot(lvecx2n,ones(lveclic,1).*cbvecxp,2));
      lvecx1L = lvecx1a-cmradang; lvecx1H = lvecx1a+cmradang;
      lvecx2L = lvecx2a-cmradang; lvecx2H = lvecx2a+cmradang;
      lvecx1A = [lvecx1L lvecx1H]; lvecx2A = [lvecx2L lvecx2H];
      k{n,1}(lvecli,:) = lvecx1A; k{n,2}(lvecli,:) = lvecx2A;
      lvecx1Ah = sum((cmangles>=lvecx1L)&(cmangles<=lvecx1H),2);
      lvecx2Ah = sum((cmangles>=lvecx2L)&(cmangles<=lvecx2H),2);
      if ((lvecx1Ah>0)||(lvecx2Ah>0)) d(lvecli,1) = true; endif
    endfor
  endif
endfunction
