# Ooh Na Na PostgreSQL Container

This repository has the Dockerfile and setup necessary to prepare
a pre-loaded PostgreSQL container and push it back to dockerhub for
reuse.

This repository completely relies on the [PyOBO](https://github.com/pyobo/pyobo)
python package for generating the names and alternative identifiers database.
If there is a special build locally, it is used. Otherwise, it's the names are
grabbed from 
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4020486.svg)](https://doi.org/10.5281/zenodo.4020486)
and the alternate identifiers from
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4021476.svg)](https://doi.org/10.5281/zenodo.4021476)
before loading into the PostgreSQL database. For more information, read the blog post at
https://cthoyt.com/2020/04/18/ooh-na-na.html.

You can run with:

```bash
git clone https://github.com/pyobo/oohnana-docker
sh setup.sh
```

Finally, the docker images get pushed to https://hub.docker.com/repository/docker/pyobo/oohnana.
Each one is tagged with the hash of this repository. Maybe in the future that will switch to
proper versioning.

Tutorials followed to get this far:

- https://nickjanetakis.com/blog/docker-tip-79-saving-a-postgres-database-in-a-docker-image
- https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html
