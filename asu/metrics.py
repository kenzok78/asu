from prometheus_client.core import CounterMetricFamily, GaugeMetricFamily


class BuildCollector(object):
    def __init__(self, connection=None):
        self.connection = connection

    def collect(self):
        stats_builds = CounterMetricFamily(
            "builds",
            "Total number of built images",
            labels=["branch", "version", "target", "profile"],
        )
        for build, count in self.connection.hgetall("stats-builds").items():
            stats_builds.add_metric(build.decode().split("#"), count)

        yield stats_builds

        hits = self.connection.get("stats-cache-hit")
        if hits:
            hits = int(hits.decode())
        else:
            hits = 0

        misses = self.connection.get("stats-cache-miss")
        if misses:
            misses = int(misses.decode())
        else:
            misses = 0

        if (hits + misses) > 0:
            yield GaugeMetricFamily(
                "cache_hits_percentage",
                "Cache hits of build images in percent",
                value=hits / (hits + misses),
            )
