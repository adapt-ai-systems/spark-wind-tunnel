# Cooling evidence — one short load test, honestly bounded

## Finding

A September 9 sample run shows a **10.2 °C sample-average GPU-temperature
difference** between the two machine pairs: the pair installed in an
enclosure ran cooler than the pair outside one. This is consistent with the
owner's recollection of roughly 10–15 ° cooler operation.

**Caveat up front:** the test predates the version-four case in this repo,
and the tested case revision is not recorded. Treat this as evidence for the
wind-tunnel project overall, not a validation of the exact design here.

## Method as recorded

- Date: September 9, 15:32 UTC. Four NVIDIA DGX Spark machines had their
  1989 MHz clock lock removed for the test and restored afterwards.
- Load: five minutes of parallel inference requests against one shared
  model endpoint served by the four machines as a tensor-parallel ring —
  not four independent workloads.
- Sampling: the four machines were queried sequentially with
  `nvidia-smi` (GPU temperature, graphics clock, reported GPU power,
  utilization) with a 15 s sleep between rounds; 21 rounds, 84
  observations. The labels 0s–300s are nominal: query overhead adds time,
  readings are not simultaneous. This is an *intended five-minute load
  test*, not a timed steady-state experiment.

## Results

Machines relabeled; the original pairing is preserved.

| Unit | Group | First recorded °C | Last recorded °C | Peak recorded °C | Mean of 21 samples °C |
|---|---|---:|---:|---:|---:|
| Tunnel A | Enclosed | 36 | 53 | 53 | 50.38 |
| Tunnel B | Enclosed | 35 | 51 | 54 | 47.95 |
| Compare A | Open | 43 | 63 | 66 | 57.95 |
| Compare B | Open | 45 | 65 | 69 | 60.86 |

| Statistic | Value | Note |
|---|---:|---|
| Pair means, all 21 rounds | 49.17 °C vs 59.40 °C | difference **10.24 °C**; unweighted sample average, includes warm-up |
| Final five rounds (nominal 240–300 s) | difference **12.80 °C** | descriptive late-window subset, not an independently defined steady state |
| Final recorded round | 53/51 °C vs 63/65 °C | difference **12.0 °C** |
| Per-machine peaks | 53/54 °C vs 66/69 °C | difference of peak means **14.0 °C**; peaks are a different statistic, do not substitute for the average |

## What the raw record does **not** support

- **Not identical operating points.** Across the record, graphics clocks
  span 2405–2528 MHz and reported GPU power spans 12.08–40.72 W; the warmer
  pair generally drew more reported power.
- **No demonstrated steady state** for every machine; one unit was still
  climbing at the end.
- **No throttle-reason data** in the samples — absence of recorded
  throttling was not verifiable per machine throughout.
- **Throughput figures** quoted in a contemporary chat summary were derived
  by dividing generated output by a hard-coded 300 s window; no
  case-on/case-off speed experiment was performed. Do not use them as
  cooling evidence.

## Limits on causal claims

- This is a **cross-machine comparison, not a controlled before/after
  crossover**. The first recorded pair-mean gap is already 8.5 °C; the first
  sample is not a documented equivalent bare-machine baseline, and the
  enclosed pair may already have benefited from the case at sample one.
- Room temperature, intake-air temperature, placement, fan RPM/duty, exact
  fan model in the tested case, enclosure revision, and repeat trials are
  not documented. Power readings are GPU telemetry, not wall power. One
  short run gives no error bars and no statistical significance.
- The current design's rear ventilation and retention changes happened
  after this test.

## Qualitative update (September 17)

The owner reports the version-four cases run the Sparks at full load without
underclocking, after choosing a higher-speed fan running at roughly half
throttle from two options; noise and airflow comparisons were qualitative.
Reported throughput is unchanged with lower temperatures near 1900 MHz,
without matching clock/workload records. These are user observations, not
measurements included here.
