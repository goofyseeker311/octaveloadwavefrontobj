clear all; objfilename="testcubemodel4.obj"; #format long;output_precision(16);
hres = 7680; vres = 2160; hfov = 90; vfov = 67.5; #pvrot = [0 0 0];
campost = [-2 0.5 1.5]; camdir = normalizevector([1 0 -0.4]);
camrgt = [0 -1 0]; camup = normalizevector(cross(camrgt,camdir));
camplane = planefromnormalatpoint(campost,camup);
triangle = [1 1 0;1 0 1;1 0 0];
veclen = vectorlength(camdir);
cubemodel = loadwavefrontobjfile(objfilename);
trplane = planefrompoints(triangle);
ppdist = pointplanedistance(campost,trplane);
rpdist = rayplanedistance(campost,camdir,trplane);
[trsphere] = trianglecircumsphere(triangle);
[pcsphere] = pointcloudcircumsphere(cubemodel.vertexlist(1:8,:));
sgn = signnum([-1 0 1]);
vecang = vectorangle(camdir,campost);
[trint,trhit,trdist,truvs,trhits]=raytriangleintersection(campost,camdir,triangle);
[cubeint,cubehit,cubedist] = cubemapsphereintersection(campost,pcsphere,vres);
[sphereint,spherehit,spheredist] = spheremapsphereintersection(campost,pcsphere,hres,vres);
[ptint,pthit,ptuvs,pthits] = planetriangleintersection(camplane,triangle);
[rlint,rlhit,rldist] = raylineintersection([0 0 -0.1],[1 0 0],[triangle(2,1:3) triangle(3,1:3)]);
[psint,pshit,psdist,psrad] = planesphereintersection(camplane,pcsphere+[0 0 2 0]);
[cmanglelist,cmsteplist] = cubemapangles(vres);
[smhanglelist,smvanglelist] = spheremapangles(hres,vres);
[hangles,hstep,vangles,vstep,dasp,aasp]=projectedangles(hres,vres,hfov,vfov);
[cmplanes,cmpd,cmpu,cmpr] = cubemapplanes(campost,vres);
[smplanes,smpd,smpu] = spheremapplanes(campost,hres);
prplanes = projectedplanes(campost,hres,vres,hfov,vfov);
camptvecs = planetangentvectors(campost,camplane);
[dbout,zbout]=mergedrawbuffers(zeros(2,2,3),[1 1;2 2],ones(2,2,3),[0.5 1.5;2.5 1.5]);
projrays = projectedrays(hres,vres,hfov,vfov);
spheremaprays = equilateralspheremaprays(hres,vres);
cubemaprays = unitxyzcubemaprays(vres);
subsrays = subsurfacerays(spheremaprays,trplane);

figure(1);clf;whitebg([0.8 0.8 0.8]);plotobjectsphere(cubemodel,campost);view(3);axis equal;
saveas(1,"sceneobjectsrenderA.png");

[ssdbuffer,sszbuffer] = renderobjectspheresketch(cubemodel,campost,hres,vres);
figure(2);clf;imagesc(ssdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(ssdbuffer,['spheremapsketchrenderA.png']);

[csdbuffer,cszbuffer] = renderobjectcubesketch(cubemodel,campost,vres);
for n = 1:6
  figure(n+2);clf;imagesc(csdbuffer{n});whitebg([0.8 0.8 0.8]);xlim([1 vres]);ylim([1 vres]);axis off;daspect([1 1]);
  imwrite(csdbuffer{n},['cubemapsketchrenderA' num2str(n) '.png']);
endfor

[sldbuffer,slzbuffer] = renderobjectspherelinesketch(cubemodel,campost,hres,vres);
figure(9);clf;imagesc(sldbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(sldbuffer,['spheremaplinesketchrenderA.png']);

[scdbuffer,sczbuffer] = renderobjectspherecamera(cubemodel,campost,hres,vres);
figure(10);clf;imagesc(scdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(scdbuffer,['spheremapplanerenderA.png']);
[cmdbuffers,cmzbuffers] = renderobjectcubecamera(cubemodel,campost,vres);
for n = 1:6
  figure(n+10);clf;imagesc(cmdbuffers{n});whitebg([0.8 0.8 0.8]);xlim([1 vres]);ylim([1 vres]);axis off;daspect([1 1]);
  imwrite(cmdbuffers{n},['cubemapplanerenderA' num2str(n) '.png']);
endfor

[smrdbuffer,smrzbuffer] = renderobjectrayscamera(cubemodel,campost,spheremaprays);
figure(17);clf;imagesc(smrdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(smrdbuffer,['spheremapraysrenderA.png']);
for n = 1:6
  [cmrdbuffer,cmrzbuffer] = renderobjectrayscamera(cubemodel,campost,cubemaprays{n});
  figure(n+17);clf;imagesc(cmrdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 vres]);ylim([1 vres]);axis off;daspect([1 1]);
  imwrite(cmrdbuffer,['cubemapraysrenderA' num2str(n) '.png']);
endfor

[prrdbuffer,prrzbuffer,objbuffer,normbuffer,pointbuffer] = renderobjectrayscamera(cubemodel,campost,projrays);
figure(24);clf;imagesc(prrdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(prrdbuffer,['projectedraysrenderA.png']);
bordbuffer = renderobjectraysbouncecamera(cubemodel,pointbuffer,spheremaprays,objbuffer,normbuffer);
figure(25);clf;imagesc(bordbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(bordbuffer,['projectedbounceraysrenderA.png']);
