# octave: load wavefront obj file
load/parse wavefront obj 3d model files in gnu octave. any grouping information is ignored.

objreader.m is the test script file. includes extra related 3d library algorithms.
note: all extra libraries are currently assumed to operate on single vector/point/sphere/etc entity at a time, not arrays.
also assumes that export from blender to wavefront is z-up, y-forward, x-right and that the mesh is triangulated.
all vectors, points, spheres and planes are assumed to be in the form of [x y z], [a b c d], and [z y z r] horizontal vectors.
any arrays of vectors, points, spheres and planes, and normal triangles are assumed to be vertically stacked vectors
in the form of [x1 y1 z1 (r1); x2 y2 z2 (r2); x3 y3 z3 (r3)]. multiple triangles are stacked in the 3rd dimension, triangles(:,:,n).

equirectangular spheremap 360 degree camera rendered unit cube (every coordinate is unit, side length 2) at 0,0,0 from -2,0.5,1.5 (from left top off-y-axis looking right).
note: high resolution plane-triangle intersection testing render only.
![spheremaprender30A5](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/519329f9-07f8-4e6c-b2de-e2e0ca376692)

same image in 3d image viewer.
![spheremaprender30A5a](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/af0c874b-441e-489d-b0fd-deaf85515da0)

cubemap camera right face view render.
![spheremaprender29A6](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/ceb9cf48-086b-451d-93e7-6553a150cc91)
