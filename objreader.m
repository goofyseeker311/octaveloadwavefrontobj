clear all; objfilename="testcubemodel4.obj"; #format long;output_precision(16);
hres = 384; vres = 108; hfov = 90; vfov = 67.5; #pvrot = [0 0 0];
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
[csdbuffer,cszbuffer] = renderobjectcubesketch(cubemodel,campost,vres); csdbufferL = zeros(3*vres,vres*4,3);
csdbufferL(vres*1+(1:vres),vres*(3-1)+(1:vres),:) = csdbuffer{1};
csdbufferL(vres*1+(1:vres),vres*(2-1)+(1:vres),:) = csdbuffer{2};
csdbufferL(vres*1+(1:vres),vres*(1-1)+(1:vres),:) = csdbuffer{3};
csdbufferL(vres*1+(1:vres),vres*(4-1)+(1:vres),:) = csdbuffer{4};
csdbufferL(vres*0+(1:vres),vres*(3-1)+(1:vres),:) = csdbuffer{5};
csdbufferL(vres*2+(1:vres),vres*(3-1)+(1:vres),:) = csdbuffer{6};
figure(3);clf;imagesc(csdbufferL);whitebg([0.8 0.8 0.8]);xlim([1 vres*4]);ylim([1 vres*3]);axis off;daspect([1 1]);
imwrite(csdbufferL,['cubemapsketchrenderA.png']);

[sldbuffer,slzbuffer] = renderobjectspherelinesketch(cubemodel,campost,hres,vres);
figure(4);clf;imagesc(sldbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(sldbuffer,['spheremaplinesketchrenderA.png']);
[cldbuffer,clzbuffer] = renderobjectcubelinesketch(cubemodel,campost,vres); cldbuffersL = zeros(3*vres,vres*4,3);
cldbuffersL(vres*1+(1:vres),vres*(3-1)+(1:vres),:) = cldbuffer{1};
cldbuffersL(vres*1+(1:vres),vres*(2-1)+(1:vres),:) = cldbuffer{2};
cldbuffersL(vres*1+(1:vres),vres*(1-1)+(1:vres),:) = cldbuffer{3};
cldbuffersL(vres*1+(1:vres),vres*(4-1)+(1:vres),:) = cldbuffer{4};
cldbuffersL(vres*0+(1:vres),vres*(3-1)+(1:vres),:) = cldbuffer{5};
cldbuffersL(vres*2+(1:vres),vres*(3-1)+(1:vres),:) = cldbuffer{6};
figure(5);clf;imagesc(cldbuffersL);whitebg([0.8 0.8 0.8]);xlim([1 vres*4]);ylim([1 vres*3]);axis off;daspect([1 1]);
imwrite(cldbuffersL,['cubemaplinesketchrenderA.png']);

[scdbuffer,sczbuffer] = renderobjectspherecamera(cubemodel,campost,hres,vres);
figure(6);clf;imagesc(scdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(scdbuffer,['spheremapplanerenderA.png']);
[cmdbuffers,cmzbuffers] = renderobjectcubecamera(cubemodel,campost,vres); cmdbuffersL = zeros(3*vres,vres*4,3);
cmdbuffersL(vres*1+(1:vres),vres*(3-1)+(1:vres),:) = cmdbuffers{1};
cmdbuffersL(vres*1+(1:vres),vres*(2-1)+(1:vres),:) = cmdbuffers{2};
cmdbuffersL(vres*1+(1:vres),vres*(1-1)+(1:vres),:) = cmdbuffers{3};
cmdbuffersL(vres*1+(1:vres),vres*(4-1)+(1:vres),:) = cmdbuffers{4};
cmdbuffersL(vres*0+(1:vres),vres*(3-1)+(1:vres),:) = cmdbuffers{5};
cmdbuffersL(vres*2+(1:vres),vres*(3-1)+(1:vres),:) = cmdbuffers{6};
figure(7);clf;imagesc(cmdbuffersL);whitebg([0.8 0.8 0.8]);xlim([1 vres*4]);ylim([1 vres*3]);axis off;daspect([1 1]);
imwrite(cmdbuffersL,['cubemapplanerenderA.png']);

[smrdbuffer,smrzbuffer] = renderobjectrayscamera(cubemodel,campost,spheremaprays);
figure(8);clf;imagesc(smrdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(smrdbuffer,['spheremapraysrenderA.png']);
cmrdbuffers = {}; cmrzbuffers = {};
for n = 1:6; [cmrdbuffers{n},cmrzbuffers{n}] = renderobjectrayscamera(cubemodel,campost,cubemaprays{n}); endfor
cmrdbuffersL = zeros(3*vres,vres*4,3);
cmrdbuffersL(vres*1+(1:vres),vres*(3-1)+(1:vres),:) = fliplr(rot90(cmrdbuffers{1},-1));
cmrdbuffersL(vres*1+(1:vres),vres*(2-1)+(1:vres),:) = fliplr(rot90(cmrdbuffers{2},-1));
cmrdbuffersL(vres*1+(1:vres),vres*(1-1)+(1:vres),:) = fliplr(rot90(cmrdbuffers{3},-1));
cmrdbuffersL(vres*1+(1:vres),vres*(4-1)+(1:vres),:) = fliplr(rot90(cmrdbuffers{4},-1));
cmrdbuffersL(vres*0+(1:vres),vres*(3-1)+(1:vres),:) = fliplr(rot90(cmrdbuffers{6},-1));
cmrdbuffersL(vres*2+(1:vres),vres*(3-1)+(1:vres),:) = fliplr(rot90(cmrdbuffers{5},-1));
figure(9);clf;imagesc(cmrdbuffersL);whitebg([0.8 0.8 0.8]);xlim([1 vres*4]);ylim([1 vres*3]);axis off;daspect([1 1]);
imwrite(cmrdbuffersL,['cubemapraysrenderA.png']);

[prrdbuffer,prrzbuffer,objbuffer,normbuffer,pointbuffer] = renderobjectrayscamera(cubemodel,campost,projrays);
figure(10);clf;imagesc(prrdbuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(prrdbuffer,['projectedraysrenderA.png']);
bordbuffer = renderobjectraysbouncecamera(cubemodel,pointbuffer,spheremaprays,objbuffer,normbuffer);
combobuffer = prrdbuffer+bordbuffer.*2;
figure(11);clf;imagesc(combobuffer);whitebg([0.8 0.8 0.8]);xlim([1 hres]);ylim([1 vres]);axis off;daspect([1 1]);
imwrite(combobuffer,['projectedcomboraysrenderA.png']);
