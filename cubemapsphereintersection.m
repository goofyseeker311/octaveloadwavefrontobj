function [k,d,f] = cubemapsphereintersection(vpos,vsphere,vres)
  global cmangles cmres; vspherec=size(vsphere,1); k={}; d=false(vspherec,1);
  lvec = vsphere(:,1:3)-vpos; lvecl = vectorlength(lvec); f = lvecl;
  if (isempty(cmres)||isempty(cmangles)||(vres!=cmres))
    cmres = vres; cmangles = cubemapangles(vres);
  endif
  lvecli=find(lvecl);lveclin=find(!lvecl);lveclic=size(lvecli,1);lveclinc=size(lveclin,1);
  cmanglesa = ones(lveclic,1).*cmangles;
  for n = 1:6
    k{n,1} = nan(vspherec,4); k{n,1}(lveclin,:) = ones(lveclinc,1).*[1 vres 1 vres];
  endfor
  d(lveclin,1) = true(lveclinc,1);
  if (!isempty(lvecli))
    cmradang = real(asind(vsphere(lvecli,4)./lvecl(lvecli,1)));
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
      lvecx1I = (cmangles>=lvecx1L)&(cmangles<=lvecx1H);
      lvecx2I = (cmangles>=lvecx2L)&(cmangles<=lvecx2H);
      lvecx1If = find(lvecx1I); lvecx1Ifn = find(!lvecx1I);
      lvecx2If = find(lvecx2I); lvecx2Ifn = find(!lvecx2I);
      lvecx1Ia=cmanglesa; lvecx1Ia(lvecx1Ifn)=nan;
      lvecx2Ia=cmanglesa; lvecx2Ia(lvecx2Ifn)=nan;
      [lvecx1Iamin,lvecx1Iamini] = min(lvecx1Ia,[],2);
      [lvecx1Iamax,lvecx1Iamaxi] = max(lvecx1Ia,[],2);
      [lvecx2Iamin,lvecx2Iamini] = min(lvecx2Ia,[],2);
      [lvecx2Iamax,lvecx2Iamaxi] = max(lvecx2Ia,[],2);
      lvecxIaf = find(isfinite(lvecx1Iamin)&isfinite(lvecx1Iamax)&isfinite(lvecx2Iamin)&isfinite(lvecx2Iamax));
      k{n,1}(lvecli(lvecxIaf),:) = [lvecx1Iamini(lvecxIaf) lvecx1Iamaxi(lvecxIaf) lvecx2Iamini(lvecxIaf) lvecx2Iamaxi(lvecxIaf)];
      lvecx1Ah = sum(lvecx1I,2); lvecx2Ah = sum(lvecx2I,2);
      lvechiti = find((lvecx1Ah>0)|(lvecx2Ah>0));
      if (!isempty(lvechiti)) d(lvecli(lvechiti),1) = true; endif
    endfor
  endif
endfunction
