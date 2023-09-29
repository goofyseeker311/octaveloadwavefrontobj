# octave: load wavefront obj file
load/parse wavefront obj 3d model files in gnu octave. any grouping information is ignored.

objreader.m is the test script file. includes extra related 3d library algorithms.
note: all extra libraries are currently assumed to operate on single vector/point/sphere/etc entity at a time, not arrays.
also assumes that export from blender to wavefront is z-up, y-forward, x-right and that the mesh is triangulated.
all vectors, points, spheres and planes are assumed to be in the form of [x y z], [a b c d], and [z y z r] horizontal vectors.
any arrays of vectors, points, spheres and planes, and normal triangles are assumed to be vertically stacked vectors
in the form of [x1 y1 z1 (r1); x2 y2 z2 (r2); x3 y3 z3 (r3)]. multiple triangles are stacked in the 3rd dimension, triangles(:,:,n).

equirectangular spheremap 360 degree camera rendered unit cube (every coordinate is unit, side length 2) at 0,0,0 from -2,0.5,1.5 (from left top off-y-axis looking right).
note: low resolution pixel-by-pixel testing render only.
![spheremaprender6a](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/33155a5a-fa9f-45c3-8d2b-c8e47d9e6258)

test render image in 360 degree image viewer (or in virtual reality goggles headset spheremap image viewer).
![spheremaprender6b](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/1ed0e2a7-1de1-43a0-89dd-74f0af7dba91)

adding more cubes in the scene.
![spheremaprender9e](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/4937afd4-1e35-4685-9eb5-72cfafa673f5)

same image in 3d image viewer.
![spheremaprender9f](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/1efdb76b-58fe-4ad6-98c7-625deb86592f)

added color usage in a test image.
![spheremaprender17](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/5591065b-772c-47dc-a33d-a96a00ffc662)

same image in 3d image viewer.
![spheremaprender17a](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/d655b185-d33a-4922-ac32-025dbd8ca73b)

right view cubemap camera face render.
![spheremaprender29A5](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/fb04da33-7252-4273-b3cc-2ea72c480b3a)
