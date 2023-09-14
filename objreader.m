clear; format long; output_precision(16);
cubemodel = loadwavefrontobjfile("testcubemodel.obj");
hres = 256; vres = 64;
rays = equilateralspheremaprays(hres,vres);
triangle = [1 0 0;1 0 1;1 1 0];
plane = planefrompoints(triangle);
