# jmx_exporter
[Prometheus](https://prometheus.io/) [jmx_exporter](https://github.com/prometheus/jmx_exporter) in a container.

## Use
To run:

```
docker run -t jmx_exporter -p 80:80 -v jmx_exporter.yaml:/etc/jmx_exporter/jmx_exporter.yaml frontporch/jmx_exporter 
```

The image assumes the default location of the config file to be at `/etc/jmx_exporter/jmx_exporter.yaml`.
Mount your own config there to initialize the export accordingly.  Samples are provided [here](https://github.com/prometheus/jmx_exporter/tree/master/example_configs).
If configured properly the container should begin serving metrics on `http://localhost/metrics`.

## Notes
We started from the Maven image since we needed to compile the repo, but we could seriousy slim down this image if we could get
our hands on a precompied binary and just add it to an Alpine container.
