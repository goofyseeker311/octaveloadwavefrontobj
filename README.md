# octave: load wavefront obj file
load/parse wavefront obj 3d model files in gnu octave. any grouping information is ignored.

objreader.m is the test script file. includes extra related 3d library algorithms.
note: all extra libraries are currently assumed to operate on single vector/point/sphere/etc entity at a time, not arrays.
also assumes that export from blender to wavefront is z-up, y-forward, x-right and that the mesh is triangulated.
all vectors, points, spheres and planes are assumed to be in the form of [x y z], [a b c d], and [z y z r] horizontal vectors.
any arrays of vectors, points, spheres and planes, and normal triangles are assumed to be vertically stacked vectors
in the form of [x1 y1 z1 (r1); x2 y2 z2 (r2); x3 y3 z3 (r3)]. multiple triangles are stacked in the 3rd dimension, triangles(:,:,n).

equilrectangle spheremap 360 degree camera rendered unit cube (every coordinate is unit, side length 2) at 0,0,0 from -2,0.5,1.5 (from left top off-y-axis looking right). note: testing render only.
![spheremaprender6a](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/33155a5a-fa9f-45c3-8d2b-c8e47d9e6258)
