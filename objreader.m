clear all; format long; output_precision(16);
hres = 1024; vres = 256; objfilename = "testcubemodel2.obj";
campos = [-2 0.5 1.5]; camdir = [1 0 0]; triangle = [1 1 0;1 0 1;1 0 0];
veclen = vectorlength(camdir);
normdir = normalizevector(camdir);
cubemodel = loadwavefrontobjfile(objfilename);
[spheremaprays,smr] = equilateralspheremaprays(hres,vres);
trplane = planefrompoints(triangle);
ppdist = pointplanedistance(campos,trplane);
[anglelist,steplist] = cubemapangles(hres);
[cubemaprays,cmr] = unitxyzcubemaprays(vres);
rpdist = rayplanedistance(campos,camdir,trplane);
[trint,trhit,trdist] = raytriangleintersection(campos,camdir,triangle);
[trsphere] = trianglecircumsphere(triangle);
[pcsphere] = pointcloudcircumsphere(cubemodel.vertexlist(1:8,:));
sgn = signnum([-1 0 1]);
[cubeint,cubehit] = cubemapsphereintersection(campos,pcsphere,vres);
vecang = vectorangle(camdir,campos);
