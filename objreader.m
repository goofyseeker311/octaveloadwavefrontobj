clear all; objfilename="testcubemodel4.obj"; #format long;output_precision(16); #testcubemodel4
hres = 192; vres = 108; hfov = 90; vfov = 67.5; #pvrot = [0 0 0];
campos = [-2 0.5 1.5]; camdir = normalizevector([1 0 -0.4]);
camrgt = [0 -1 0]; camup = normalizevector(cross(camrgt,camdir));
camplane = planefromnormalatpoint(campos,camup);
triangle = [1 1 0;1 0 1;1 0 0];
veclen = vectorlength(camdir);
cubemodel = loadwavefrontobjfile(objfilename);
trplane = planefrompoints(triangle);
ppdist = pointplanedistance(campos,trplane);
rpdist = rayplanedistance(campos,camdir,trplane);
[trsphere] = trianglecircumsphere(triangle);
[pcsphere] = pointcloudcircumsphere(cubemodel.vertexlist(1:8,:));
sgn = signnum([-1 0 1]);
vecang = vectorangle(camdir,campos);
[trint,trhit,trdist,truvs,trhits]=raytriangleintersection(campos,camdir,triangle);
[cubeint,cubehit,cubedist] = cubemapsphereintersection(campos,pcsphere,vres);
[plint,plhit,pluv] = planelineintersection(camplane,triangle([1 2],:));
[ptint,pthit,ptuvs,pthits] = planetriangleintersection(camplane,triangle);
[cmanglelist,cmsteplist] = cubemapangles(vres);
[smhanglelist,smvanglelist] = spheremapangles(hres,vres);
[hangles,hstep,vangles,vstep,dasp,aasp]=projectedangles(hres,vres,hfov,vfov);
[cmplanes,cmpd,cmpu,cmpr] = cubemapplanes(campos,vres);
[smplanes,smpd,smpu] = spheremapplanes(campos,hres);
prplanes = projectedplanes(campos,hres,vres,hfov,vfov);
[dbout,zbout]=mergedrawbuffers(zeros(2,2,3),[1 1;2 2],ones(2,2,3),[0.5 1.5;2.5 1.5]);
projrays = projectedrays(hres,vres,hfov,vfov);
spheremaprays = equilateralspheremaprays(hres,vres);
cubemaprays = unitxyzcubemaprays(vres);
subsrays = subsurfacerays(spheremaprays,trplane);

[csdbuffers,cszbuffers] = renderobjectcubesketch(cubemodel,campos,vres);
for n = 1:6
  figure(n);clf;imagesc(csdbuffers{n});whitebg([0.8 0.8 0.8]);xlim([1 vres]);ylim([1 vres]);axis off;daspect([1 1]);
  imwrite(csdbuffers{n},['cubemapsketchrenderA' num2str(n) '.png']);
endfor
