# Docker container for benchmarking (graph-based) read mappers
Takes care of all the dependencies of read simualators and the different mappers.

Build docker images by cloning this repo and running:
```
docker build -t graph_mapping_benchmarking .
```

You can now enter the docer container and run benchmarks:
```
docker run -it [container ID]
```