# octave: load wavefront obj file
load/parse wavefront obj 3d model files in gnu octave. any grouping information is ignored.

objreader.m is the test script file. includes extra related 3d library algorithms.
note: most extra libraries are currently assumed to operate on stacked multiple vector/point/sphere/etc entity at a time, not only single values.
also assumes that export from blender to wavefront is z-up, y-forward, x-right and that the mesh is triangulated, with texture coordinates, colors and normals output.
all vectors, points, spheres and planes are assumed to be in the form of [x y z], [a b c d], and [z y z r] horizontal vectors.
any arrays of vectors, points, spheres and planes, and normal triangles are assumed to be vertically stacked vectors
in the form of [x1 y1 z1 (r1); x2 y2 z2 (r2); x3 y3 z3 (r3)]. multiple triangles are stacked in the 3rd dimension, triangles(:,:,n).

object plotting figure, with sphere boundary volumes around the objects:
![plottingtest2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/72c9e8f2-4f8e-4d0e-9880-9631982be965)

objects sphere boundary volume sketch spheremap camera render with angle limit rectangle plot:
![spheremapsketchrender27A3](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/6744cbaa-d7e9-4bbc-a0af-021466de0211)

objects sphere boundary volume sketch spheremap camera render with plane-sphere intersection line scan:
![spheremaplinesketchrender27A11](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/166387ee-6851-4ce6-a537-28ac7eb69348)

equirectangular spheremap 360 degree camera high resolution plane-triangle intersection render:
![spheremapplanerender29A22](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/10c58fc5-1c20-4322-8ed2-d57d96e90a5b)

equirectangular spheremap 360 degree camera low resolution ray-triangle intersection reference render:
![spheremapraysrender32A5](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/7d0811d1-ed1e-4540-b1f5-d534a280ed9d)

objects sphere boundary volume sketch cubemap camera render with angle limit rectangle plot:
![cubemapsketchrender32A2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/d15343df-6968-41b0-97f2-5b9c08509cb9)

objects sphere boundary volume sketch cubemap camera low resolution ray-triangle intersection reference render:
![cubemapraysrender32A3](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/0387dd3f-a952-41ab-ba98-d5c0395e23b2)

all cubemap side views rendered using plane-triangle intersections:
![cubemapplanerender27A1](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/c99edb2b-cd8a-41a6-8515-d1bb8378f246)
![cubemapplanerender27A2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/d3c91bf1-8d92-4c31-abf4-0145a13e5edf)
![cubemapplanerender27A3](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/b39850d7-50d5-4186-89ef-5c7c9bd6296a)
![cubemapplanerender27A4](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/d7daa34b-6018-493a-a186-de4c60dccbd9)
![cubemapplanerender27A5](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/df065fe3-b7b3-4b25-9eca-f8a66055cc8b)
![cubemapplanerender27A6](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/2d9b29a0-c22f-4048-80e0-7c673ca1b457)
