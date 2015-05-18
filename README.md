# What is Disque?

Disque is ongoing experiment to build a distributed, in memory, message broker. Its goal is to capture the essence of the "Redis as a jobs queue" use case, which is usually implemented using blocking list operations, and move it into an ad-hoc, self-contained, scalable, and fault tolerant design, with simple to understand properties and guarantees, but still resembling Redis in terms of simplicity, performances, and implementation as a C non-blocking networked server.

Currently (27 April 2015) the project is just an alpha quality preview, that was developed in roughly 120 hours, 244 different commits performed in 72 different days, often at night and during weekends. In short: don't expect much or rock solid production systems here.

**WARNING: This is alpha code NOT suitable for production. The implementation and API will likely change in significant ways during the next months. The code and algorithms are not tested enough. A lot more work is needed.**

> [github.com/antirez/disque](https://github.com/antirez/disque)

# How to use this image

## start a disque instance

    docker run --name disque [-p 7711:7711] [-v /some/directory:/data] -d graanjonlo/disque[:tag]

This image includes `EXPOSE 7711`, so standard container linking will make it automatically available to the linked containers. It also includes `VOLUME ["/data"]` so you can mount a data volume.

