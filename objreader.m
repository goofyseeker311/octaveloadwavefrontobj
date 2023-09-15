clear; format long; output_precision(16); hres = 256; vres = 64;
cubemodel = loadwavefrontobjfile("testcubemodel.obj");
rays = equilateralspheremaprays(hres,vres);
triangle = [1 0 0;1 0 1;1 1 0]; point = [1 0 0];
plane = planefrompoints(triangle);
dist = pointplanedistance(point,plane);
[anglelist,steplist] = cubemapangles(hres);
