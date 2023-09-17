clear; format long; output_precision(16); hres = 256; vres = 64;
cubemodel = loadwavefrontobjfile("testcubemodel.obj");
[spheremaprays,smr] = equilateralspheremaprays(hres,vres);
campos = [-10 0 0]; camdir = [0.9981 0 0.06105]; triangle = [1 0 0;1 0 1;1 1 0];
trplane = planefrompoints(triangle);
ppdist = pointplanedistance(campos,trplane);
[anglelist,steplist] = cubemapangles(hres);
[cubemaprays,cmr] = unitxyzcubemaprays(vres);
rpdist = rayplanedistance(campos,camdir,trplane);
