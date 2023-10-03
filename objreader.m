clear all; objfilename="testcubemodel4.obj"; #format long;output_precision(16);
hres = 1920; vres = 1080; hfov = 70; vfov = hfov./(hres./vres);
campos = [-2 0.5 1.5]; camdir = normalizevector([1 0 -0.4]);
camrgt = [0 -1 0]; camup = normalizevector(cross(camrgt,camdir));
camplane = planefromnormalatpoint(campos,camup);
triangle = [1 1 0;1 0 1;1 0 0];
veclen = vectorlength(camdir);
cubemodel = loadwavefrontobjfile(objfilename);
trplane = planefrompoints(triangle);
ppdist = pointplanedistance(campos,trplane);
cpdist1 = pointplanedistance(triangle(1,:),camplane);
cpdist2 = pointplanedistance(triangle(2,:),camplane);
cpdist3 = pointplanedistance(triangle(3,:),camplane);
[cmanglelist,cmsteplist] = cubemapangles(vres);
rpdist = rayplanedistance(campos,camdir,trplane);
[trint,trhit,trdist,truvs,trhits]=raytriangleintersection(campos,camdir,triangle);
[trsphere] = trianglecircumsphere(triangle);
[pcsphere] = pointcloudcircumsphere(cubemodel.vertexlist(1:8,:));
sgn = signnum([-1 0 1]);
[cubeint,cubehit] = cubemapsphereintersection(campos,pcsphere,vres);
vecang = vectorangle(camdir,campos);
[ptint,pthit,ptuvs,pthits] = planetriangleintersection(camplane,triangle);
cmplanes = cubemapplanes(campos,vres);
smplanes = spheremapplanes(campos,hres);
[smhanglelist,smvanglelist] = spheremapangles(hres,vres);
[plint,plhit,pluv] = planelineintersection(camplane,triangle([1 2],:));
[hangles,hstep,vangles,vstep,dasp,aasp]=projectedangles(hres,vres,hfov,vfov);
#spheremaprays = equilateralspheremaprays(hres,vres);
#cubemaprays = unitxyzcubemaprays(vres);

[outdrawbuffers,outzbuffers] = renderobjectcubecamera(cubemodel,campos,vres);
for n=1:6
  outdrawbuffers{n}=fliplr(outdrawbuffers{n});outdrawbuffers{n}=flipud(outdrawbuffers{n});#outdrawbuffers{n}=rot90(outdrawbuffers{n});
  figure(n); clf; imagesc(outdrawbuffers{n}); axis off; axis equal;
  xlim([1 vres]); ylim([1 vres]); daspect([1 1]);
  imwrite(outdrawbuffers{n},['cubemaprenderA' num2str(n) '.png']);
endfor

[outdrawbuffer,outzbuffer] = renderobjectspherecamera(cubemodel,campos,hres,vres);
outdrawbuffer=fliplr(outdrawbuffer);outdrawbuffer=flipud(outdrawbuffer);#outdrawbuffer=rot90(outdrawbuffer);
figure(7); clf; imagesc(outdrawbuffer); axis off; axis equal;
xlim([1 hres]); ylim([1 vres]); daspect([1 1]);
imwrite(outdrawbuffer,['spheremaprenderA.png']);
