clear all; objfilename="testcubemodel4.obj"; #format long;output_precision(16); #testcubemodel4
hres = 1920; vres = 1080; hfov = 90; vfov = 67.5; #pvrot = [0 0 0];
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

figure(1);clf;whitebg([0.8 0.8 0.8]);plotobjectsphere(cubemodel,campos);view(3);axis equal;
saveas(1,"sceneobjectsrenderA.png");

[csdbuffer,cszbuffer] = renderobjectcubesketch(cubemodel,campos,vres);
for n = 1:6
  figure(n+1);clf;imagesc(csdbuffer{n});whitebg([0.8 0.8 0.8]);xlim([1 vres]);ylim([1 vres]);axis off;daspect([1 1]);
  imwrite(csdbuffer{n},['cubemapsketchrenderA' num2str(n) '.png']);
endfor
[scdbuffer,sczbuffer] = renderobjectspherecamera(cubemodel,campos,hres,vres);
figure(8);clf;imagesc(scdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(scdbuffer,['spheremapplanerenderA.png']);
[cmdbuffers,cmzbuffers] = renderobjectcubecamera(cubemodel,campos,vres);
for n = 1:6
  figure(n+8);clf;imagesc(cmdbuffers{n});whitebg([0.8 0.8 0.8]);xlim([1 vres]);ylim([1 vres]);axis off;daspect([1 1]);
  imwrite(cmdbuffers{n},['cubemapplanerenderA' num2str(n) '.png']);
endfor

[smrdbuffer,smrzbuffer] = renderobjectrayscamera(cubemodel,campos,spheremaprays);
figure(15);clf;imagesc(smrdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(smrdbuffer,['spheremapraysrenderA.png']);
for n = 1:6
  [cmrdbuffer,cmrzbuffer] = renderobjectrayscamera(cubemodel,campos,cubemaprays{n});
  figure(n+15);clf;imagesc(cmrdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 vres]);ylim([1 vres]);axis off;daspect([1 1]);
  imwrite(cmrdbuffer,['cubemapraysrenderA' num2str(n) '.png']);
endfor

[prrdbuffer,prrzbuffer,objbuffer,normbuffer,pointbuffer] = renderobjectrayscamera(cubemodel,campos,projrays);
figure(22);clf;imagesc(prrdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(prrdbuffer,['projectedraysrenderA.png']);
[bordbuffer] = renderobjectraysbouncecamera(cubemodel,pointbuffer,spheremaprays,objbuffer,normbuffer);
figure(23);clf;imagesc(bordbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(bordbuffer,['projectedbounceraysrenderA.png']);
