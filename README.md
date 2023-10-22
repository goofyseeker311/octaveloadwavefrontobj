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
![cubemapsketchrender32A4](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/1a4a570a-193e-43c3-aa48-300d36d388d7)

objects sphere boundary volume sketch cubemap camera render with plane-sphere intersection line scan:
![cubemaplinesketchrender35A2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/925f4afd-bac3-482f-8175-099fda4e3c59)

unit-xyz cubemap camera high resolution plane-triangle intersection render:
![cubemapplanerender32A5](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/cc3f3e37-c825-4a63-b594-1ae31cfb3283)

objects sphere boundary volume sketch cubemap camera low resolution ray-triangle intersection reference render:
![cubemapraysrender32A3](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/0387dd3f-a952-41ab-ba98-d5c0395e23b2)

variable fov projected camera 32:9 high resolution plane-triangle intersection render:
![projectedplanerender36A2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/fce2ab36-46cd-4478-94d0-f51a372838fa)

variable fov projected camera 32:9 high resolution ray-triangle intersection reference render:
![projectedraysrender37A](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/dbc3ed38-dbdb-48d2-9984-0ec348c28893)

variable fov rotated projected camera 32:9 high resolution plane-triangle intersection render:
![projectedplanerender36A6](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/ea73ec5b-d2b1-43a5-99d1-fb3fcefe3d03)

variable fov projected camera 16:9 very low resolution ray-triangle intersection reference render:
![projectedraysrender35A2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/08306cbc-5437-407c-b285-dae0f9a5c805)

combined bounce spheremap rays 2x added on top of variable fov projected camera 16:9 render:
![projectedcomboraysrender35A2](https://github.com/goofyseeker311/octaveloadwavefrontobj/assets/19920254/8e245c3f-1072-43e3-96ae-84e959906144)
