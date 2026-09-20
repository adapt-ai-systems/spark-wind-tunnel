# Print notes — what failed, what finally worked

Distilled from the full print/fit log of this project. Machine identifiers,
material lot labels, and printer-queue details are stripped; the failures and
the settings that fixed them are kept verbatim in substance.

All parts are PLA, printed on a Creality K2 (enclosed, 260 mm square plate).
Orientation per part: body and lock bar print with their rear face on the
bed; the bezel prints front face down.

## The problems we hit

### 1. Corner lifting on tall, flat-footed parts (the big one)
- First full body print was cancelled after ~25 min: one thin isolated inner
  rib fin near a corner had a strand curling off its tip. That fin had an
  outside-only brim and no foot of its own.
  **Lesson: every thin isolated piece needs a brim that anchors it on both
  sides (outer AND inner), not just around the outside.**
- A flat slab part (the later-abandoned tray) printed directly on the plate
  lifted its front corners at ~33%. The fix that held:

  | Setting | Value |
  |---|---|
  | Brim width | 15 mm, outer and inner |
  | Bed temperature | 65 C |
  | Part cooling fan | max 30 %, min 15 % |
  | Part fan first 5 layers | off |
  | Auxiliary fan | 0 |

  We call this the **warp recipe** below. A re-slice of the same geometry with
  this recipe completed with dead-flat corners.
- The first body re-slice (rev 6, no-tray design) still used the old cooling
  defaults (bed 60, fan 50/30, brim 8) and lifted its two rear corners about
  30 minutes in — the rear face is the whole 198 x 147 mm print footprint, so
  it is the worst place for a corner to lift. Re-sliced with the warp recipe
  plus the inner+outer brim, the body then printed ~12 h twice in black and
  once in white with no pause and no error.

### 2. Small screw-tab features popping off mid-print
- Printing the bezel and lock bar on one plate failed at ~21 min: a
  screw-hole ring came off the plate. The tab is a 4 mm strip with a hole and
  a tiny cross-section foot.
  **Lesson: print these parts individually, and give small screw lugs an
  inner+outer brim.** Printed alone with the right brim, both finished clean.

### 3. First-layer adhesion on white in a cold room
- A white bezel attempt never stuck on the first layer (classic spaghetti).
  A second attempt laid the first brim line as a loose rope instead of
  squished flat, even at 65 C bed.
- Root cause found by inspection: a **blob on the nozzle tip** fouled the
  strain-gauge Z probe, so the probe reported a plate position that was too
  low and the first layer printed too high. Fix: heat the nozzle to ~200 C,
  wipe the blob off, wash the plate (soap and water or IPA), close the door
  to kill drafts. Third attempt: brim pressed flat and wide, part completed.
- Note: the same bezel gcode succeeded in black with conservative settings
  and failed in white in a colder garage. When in doubt, use the warp recipe
  — it worked for both colors.

### 4. Horizontal screw pilots bridged badly
- The lock-bar screw pilot drilled horizontally into its pad (a 2.9 mm hole
  lying flat when the body prints rear-down) failed the slicer's bridge check
  at its crown. **Fix: teardrop the pilot** — pointed apex toward the front
  (which is "up" in the print orientation), pad extended to keep the apex
  inside the part. The slicer then showed only a 0.13 mm residual on the apex
  tip layer, which the screw taps through anyway.
- A ledge taper was also steepened from 45 to 56 degrees to pass the same
  gate; it was not the actual cause but was kept.

## The recipe that finally worked

| Part | Orientation | Recipe | Result |
|---|---|---|---|
| body (rev 6b, r7c) | rear face down | warp recipe + inner/outer brim 15 mm | ~11.9 h, ~720 g PLA, three clean prints |
| bezel (r6/r7w) | front face down | warp recipe (mandatory for white / cold garage) | 58–69 min, ~50 g |
| lock bar (r8 vented) | rear face down | inner/outer brim 8 mm, normal fan | ~30 min, ~20 g |

- One part per plate.
- Check the first layer around the 5–10 minute mark. Clean plate, drafts off.
- If the first layer looks like rope instead of flat ribbons, look at the
  nozzle before blaming the plate.

## Fit feedback the geometry absorbed

- Earlier tray-era builds: the tray stack was 2–3 mm too thick and one Spark's
  bottom cover had to be removed to fit the second machine. The no-tray rev 6
  design removes this entirely. The 45 mm Spark thickness used in the CAD was
  confirmed with calipers with the bottom cover installed.
- Completed rev 6b set (Sep 12): "turned out perfect". White set with the
  vented rev 8 bar completed Sep 13; second black set Sep 15.
- Manual pilot-drilling option for the four bezel screws, if you skip the
  printed pilots: on the front rim of the body, at x = 13.75 and 176.25 mm
  from the left outer face, z = 33.5 and 113.5 mm from the bottom outer face;
  2.9 mm (7/64 in) bit, 12 mm deep, straight in. Or use the printed bezel
  itself as the drill template.
