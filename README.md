Alpine Linux GLIBC 32 bit docker image
======================================

A glibc 32 bit docker image for Alpine Linux

Alpine Linux has musl libc and if you have requirements to run software that depend on the 32 bit glibc (GNU c) version such as Oracle JDK 32 bit, this image can be used. The x86 glibc binary is used to build the image.


## Apr '19

I made a quick hack to update for new Arch linux packages.  The image
could be slimmed down (now 84MB > twice the size of vimalathithen's one).  - justi
