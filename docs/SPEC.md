# Original requirements spec (Stage 0)

This is the requirements document written before the first build of this design family; the file it describes became the shipped CAD as `cad/spark-box-v4.scad`.

Owner: the project owner. Lines are the owner's words or numbers unless marked
(design note). "Assumed" means unmeasured and blocks Stage 1.

## Layout (owner, 2026-09-09)

| # | Requirement | Source |
|---|---|---|
| L1 | Two Sparks stacked flat, one above the other | "stacked is fine as long as there is a gap around them" |
| L2 | A gap around the exterior of each Spark; the metal shell dissipates heat and must be cooled | "the exterior of the sparks are metal and are designed to dissipate heat" |
| L3 | Sides solid, no honeycomb | v1 feedback |
| L4 | Front centre strip solid (v1 ribs snapped) | v1 feedback |
| L5 | Sparks held tight, enclosed, not loose | v1 feedback; whpthomas locking bar liked |
| L6 | Power button reachable with the box assembled | v1 feedback; in the stacked layout the rear is open so L6 is met by layout |
| L7 | Fan plug fits its exit; cord exit does not block plugging the Sparks in | v1 feedback |

## Airflow (owner, 2026-09-09)

| # | Requirement | Source |
|---|---|---|
| A1 | Fan: the owner's 140 mm (Arctic P14 Pro) | "the fan is my 140" |
| A2 | Air must exit around the Sparks as well as through them | "We will need air exiting around the sparks" |
| A3 | Opening AREA ratio 70:30, Spark faces to bypass gap (fixed geometry, no shutter) | "Let's just do like 70/30 face to gap ratio" (2026-09-09) |
| A3b | SUPERSEDES A3 (rev 4, later on 2026-09-09): equal gap on every side of the Sparks and between them; with the 141 mm interior that is 17 mm and the area ratio becomes 54:46 | "I want equal space between the sparks as is around them" |
| A4 | The around-path is a thin gap held off the shell by ribs parallel to the airflow | "a thin area around them held out by ribs that are parallel to wind-flow" |
| A5 | Cooling test on v1 decides the bottom-intake positions (v1 plan) | earlier |

## Mating objects

| Object | Dimension | Value | Source | Status |
|---|---|---|---|---|
| Spark | body W x L x H | 45 x 150 x 150 | caliper measurement 2026-09-05 | measured |
| Spark | pedestal height | 6 | jvr0x/dgx-spark-rack README (measured from reference STL; teardowns 51.2 total) | from community STL, verify with a rule |
| Spark | pedestal flare | 111 x 101 at the desk -> 128.6 x 118.6 at the chassis, i.e. ~8.8 mm run per side over the 6 mm height | jvr0x README | from community STL, verify |
| Spark | overall height incl. pedestal | 51.5 | jvr0x README / NVIDIA 50.5 | published |
| Spark | power button | on the BACK, above the USB-C power port | owner, 2026-09-09 | stated |
| Fan plug | standard 4-pin fan plug ("square 4pin"): 2.54 pitch housing ~10.7 x 6.6 mm, ~8 mm tall; cable 400 mm | operator + Arctic spec sheet + Molex KK254 housing dims | housing size from catalog, verify in hand |
| P14 Pro | 140 x 140 x 27 mm, 240 g, 400-2500 rpm, 110 cfm, 5.2 mmH2O, 12 V 0.35 A, cable 400 mm, 4-pin fan plug | Arctic spec sheet PDF | catalog; hole spacing 124.5 assumed (standard 140), verify |

## Open (design note)

- A3 is an AREA ratio by the owner's decision; the resulting flow split is
  unknown until the cooling test (A5). It was flagged that the gap will carry
  more than 30 % of the flow because it has less resistance than the Spark;
  the owner chose the fixed ratio anyway.

## Rev 5 (2026-09-10, owner, after the first full print)

| # | Requirement | Source |
|---|---|---|
| R1 | Screws hold the fan shroud (bezel), not hooks | "screws to hold the fan shroud, not hooks" |
| R2 | The tray (middle layer) must print cleanly, no fused support | "the middle layer print was messed up so we need to do that better next time" |
| R3 | No friction retention; assembled box is one secure unit | "I don't like friction holding something... This needs to act as one secure unit" |
| R4 | Screws: #6-32 (owner wrote "6-29", read as 6-32) | chat |

## Rev 6 (2026-09-10, owner): no tray

| # | Requirement | Source |
|---|---|---|
| R5 | The Sparks are locked in by the ribs on the sides and do not require a support in between them | "the sparks should be locked in by the ribs on the sides and should not require a support in between them" |

## Rev 6b (2026-09-11, owner): reinforce the load-bearing ledge

| # | Requirement | Source |
|---|---|---|
| R6 | Bottom ledges 4 mm thick with an 8 mm 45-degree gusset to the wall | fit feedback on the weight-bearing ledges |

## Rev 8 (2026-09-13): vented lock bar

The solid rear bar blocked the rear exit of the 17 mm gap between the Sparks.
Rev 8 adds a row of seven 20 x 15 mm windows across that band; the 3 mm lips
that retain the Sparks stay solid.
