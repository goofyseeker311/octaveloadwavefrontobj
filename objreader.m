clear all; format long; output_precision(16);
hres = 1024; vres = 1024; objfilename = "testcubemodel4.obj";
campos = [-2 0.5 1.5]; camdir = normalizevector([1 0 -0.4]);
camrgt = [0 -1 0]; camup = normalizevector(cross(camrgt,camdir));
camplane = planefromnormalatpoint(campos,camup);
triangle = [1 1 0;1 0 1;1 0 0];
veclen = vectorlength(camdir);
cubemodel = loadwavefrontobjfile(objfilename);
[spheremaprays,smr] = equilateralspheremaprays(hres,vres);
trplane = planefrompoints(triangle);
ppdist = pointplanedistance(campos,trplane);
cpdist1 = pointplanedistance(triangle(1,:),camplane);
cpdist2 = pointplanedistance(triangle(2,:),camplane);
cpdist3 = pointplanedistance(triangle(3,:),camplane);
[cmanglelist,cmsteplist] = cubemapangles(hres);
[cubemaprays,cmr] = unitxyzcubemaprays(vres);
rpdist = rayplanedistance(campos,camdir,trplane);
[trint,trhit,trdist] = raytriangleintersection(campos,camdir,triangle);
[trsphere] = trianglecircumsphere(triangle);
[pcsphere] = pointcloudcircumsphere(cubemodel.vertexlist(1:8,:));
sgn = signnum([-1 0 1]);
[cubeint,cubehit] = cubemapsphereintersection(campos,pcsphere,vres);
vecang = vectorangle(camdir,campos);
[ptint,pthit] = planetriangleintersection(camplane,triangle);
cmplanes = cubemapplanes(campos,vres);
smplanes = spheremapplanes(campos,hres);
[smhanglelist,smvanglelist] = spheremapangles(hres,vres);
