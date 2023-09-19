clear; format long; output_precision(16);
hres = 256; vres = 64; objfilename = "testcubemodel2.obj";
campos = [0 0 0]; camdir = [1 0 0]; triangle = [1 1 0;1 0 1;1 0 0];
veclen = vectorlength(camdir);
normdir = normalizevector(camdir);
cubemodel = loadwavefrontobjfile(objfilename);
[spheremaprays,smr] = equilateralspheremaprays(hres,vres);
trplane = planefrompoints(triangle);
ppdist = pointplanedistance(campos,trplane);
[anglelist,steplist] = cubemapangles(hres);
[cubemaprays,cmr] = unitxyzcubemaprays(vres);
rpdist = rayplanedistance(campos,camdir,trplane);
[intsect,inthit] = raytriangleintersection(campos,camdir,triangle);
[trsphere] = trianglecircumsphere(triangle);
[pcsphere] = pointcloudcircumsphere(cubemodel.vertexlist(1:8,:));
