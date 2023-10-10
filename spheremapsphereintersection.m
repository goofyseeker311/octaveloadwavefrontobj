function [k,d,f] = spheremapsphereintersection(vpos,vsphere,hres,vres)
  global smhangles smvangles smvres smhres; vspherec=size(vsphere,1); k=[]; d=false(vspherec,1);
  lvec = vsphere(:,1:3)-vpos; lvecl = vectorlength(lvec); f = lvecl;
  if (isempty(smhres)||(hres!=smhres)|isempty(smvres)||(vres!=smvres)||isempty(smhangles)||isempty(smvangles))
    smhres=hres; smvres=vres; [smhangles,smvangles] = spheremapangles(hres,vres);
  endif
  lvecli=find(lvecl);lveclin=find(!lvecl);lveclic=size(lvecli,1);lveclinc=size(lveclin,1);
  smhanglesa = ones(lveclic,1).*smhangles; smvanglesa = ones(lveclic,1).*smvangles;
  k = nan(vspherec,4); k(lveclin,:) = ones(lveclinc,1).*[1 hres 1 vres];
  d(lveclin,1) = true(lveclinc,1);
  if (!isempty(lvecli))
    smradang = real(asind(vsphere(lvecli,4)./lvecl(lvecli,1)));
    lookatdir = [0 1 0]; lvech = lvec; lvech(:,3)=0;
    hvecang = signnum(lvech(lvecli,1)).*vectorangle(lvech(lvecli,:),ones(lveclic,1).*lookatdir(1:3));
    vvecang = signnum(lvec(lvecli,3)).*vectorangle(lvech(lvecli,:),lvec);
    hvecangmin = hvecang-smradang;hvecangmax = hvecang+smradang;
    vvecangmin = vvecang-smradang;vvecangmax = vvecang+smradang;
    hvangles = [hvecangmin hvecangmax vvecangmin vvecangmax];
    hvangles(find(hvangles(:,1)<=-180),1)+=360; hvangles(find(hvangles(:,2)>=180),2)-=360;
    hvanglesi = abs(hvangles(:,2)-hvangles(:,1))<=180;
    hvanglesf=find(hvanglesi); hvanglesfi=find(!hvanglesi);
    hangl = (smhanglesa(lvecli(hvanglesf),:)>=hvangles(hvanglesf,1))&(smhanglesa(lvecli(hvanglesf),:)<=hvangles(hvanglesf,2));
    hangli = (smhanglesa(lvecli(hvanglesfi),:)>=hvangles(hvanglesfi,1))|(smhanglesa(lvecli(hvanglesfi),:)<=hvangles(hvanglesfi,2));
    hangln = smhanglesa(lvecli(hvanglesf),:); hangln(find(!hangl)) = nan;
    hanglin = smhanglesa(lvecli(hvanglesfi),:); hanglin(find(hangli)) = nan;
    [hanglnmin,hanglnmini] = min(hangln,[],2); [hanglnmax,hanglnmaxi] = max(hangln,[],2);
    [hanglinmin,hanglinmini] = min(hanglin,[],2); [hanglinmax,hanglinmaxi] = max(hanglin,[],2);
    vangl = (smvanglesa(lvecli,:)>=vvecangmin)&(smvanglesa(lvecli,:)<=vvecangmax);
    vangln = smvanglesa(lvecli,:); vangln(find(!vangl)) = nan;
    [vanglnmin,vanglnmini] = min(vangln,[],2); [vanglnmax,vanglnmaxi] = max(vangln,[],2);
    k(lvecli(hvanglesf),1:2) = [hanglnmini hanglnmaxi];
    k(lvecli(hvanglesfi),1:2) = [hanglinmaxi+1 hanglinmini-1];
    k(lvecli,3:4) = [vanglnmini vanglnmaxi];
    d(lvecli(hvanglesf)) = sum(hangl,2)>0;
    d(lvecli(hvanglesfi)) = sum(hangli,2)>0;
  endif
endfunction
