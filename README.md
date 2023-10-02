# octave: load wavefront obj file
load/parse wavefront obj 3d model files in gnu octave. any grouping information is ignored.

objreader.m is the test script file. includes extra related 3d library algorithms.
note: all extra libraries are currently assumed to operate on single vector/point/sphere/etc entity at a time, not arrays.
also assumes that export from blender to wavefront is z-up, y-forward, x-right and that the mesh is triangulated.
all vectors, points, spheres and planes are assumed to be in the form of [x y z], [a b c d], and [z y z r] horizontal vectors.
any arrays of vectors, points, spheres and planes, and normal triangles are assumed to be vertically stacked vectors
in the form of [x1 y1 z1 (r1); x2 y2 z2 (r2); x3 y3 z3 (r3)]. multiple triangles are stacked in the 3rd dimension, triangles(:,:,n).

equirectangular spheremap 360 degree camera high resolution plane-triangle intersection testing render only.
![spheremaprender30A9](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/39538d49-7a03-482e-85e9-39fc2ff6105c)

same image in 3d image viewer.
![spheremaprender30A9a](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/37978ed2-4984-440c-8290-52208ea22a02)

cubemap camera right face view render using plane-triangle intersections.
![spheremaprender29A6](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/ceb9cf48-086b-451d-93e7-6553a150cc91)

reference pixel-by-pixel ray cast render of cubemap right side view.
![spheremaprender32A](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/b19c55de-86a7-4d1d-ac9c-26a9a61f0f06)

all cubemap side views rendered:
![cubemaprender46A1](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/69070172-258e-4dc5-8003-100a11ce8c4d)
![cubemaprender46A2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/15cf459f-f948-44b1-82c0-b1cde706c7b4)
![cubemaprender46A3](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/2660e187-40e4-401f-b1c8-dc046b1a4ba3)
![cubemaprender46A4](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/200e068e-fcf3-43e1-8e9e-b00aacdb6f1f)
![cubemaprender46A5](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/9f050b03-92ba-49fb-b581-846a4200c86c)
![cubemaprender46A6](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/40d2f362-501a-4fa3-86e0-98d652123727)
