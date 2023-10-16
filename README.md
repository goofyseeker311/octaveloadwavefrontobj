# octave: load wavefront obj file
load/parse wavefront obj 3d model files in gnu octave. any grouping information is ignored.

objreader.m is the test script file. includes extra related 3d library algorithms.
note: all extra libraries are currently assumed to operate on single vector/point/sphere/etc entity at a time, not arrays.
also assumes that export from blender to wavefront is z-up, y-forward, x-right and that the mesh is triangulated, with texture coordinates, colors and normals output.
all vectors, points, spheres and planes are assumed to be in the form of [x y z], [a b c d], and [z y z r] horizontal vectors.
any arrays of vectors, points, spheres and planes, and normal triangles are assumed to be vertically stacked vectors
in the form of [x1 y1 z1 (r1); x2 y2 z2 (r2); x3 y3 z3 (r3)]. multiple triangles are stacked in the 3rd dimension, triangles(:,:,n).

object plotting figure, with sphere boundary volumes around the objects:
![plottingtest2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/72c9e8f2-4f8e-4d0e-9880-9631982be965)

objects sphere boundary volume sketch render with plane-sphere intersection line scan:
![spheremaplinesketchrender27A8](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/0c33eb4f-aa39-4db4-99ad-4fe013717c3d)

equirectangular spheremap 360 degree camera high resolution plane-triangle intersection testing render only:
![spheremaprender46A](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/1e374fc3-d20e-475f-90ec-963f7bac4fb2)

all cubemap side views rendered using plane-triangle intersections:
![cubemaprender46A1](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/69070172-258e-4dc5-8003-100a11ce8c4d)
![cubemaprender46A2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/15cf459f-f948-44b1-82c0-b1cde706c7b4)
![cubemaprender46A3](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/2660e187-40e4-401f-b1c8-dc046b1a4ba3)
![cubemaprender46A4](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/200e068e-fcf3-43e1-8e9e-b00aacdb6f1f)
![cubemaprender46A5](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/9f050b03-92ba-49fb-b581-846a4200c86c)
![cubemaprender46A6](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/40d2f362-501a-4fa3-86e0-98d652123727)
