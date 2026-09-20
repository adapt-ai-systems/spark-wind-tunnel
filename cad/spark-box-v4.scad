// Spark box v2 — two DGX Sparks stacked flat inside a ducted box, 140 mm fan at the front, open rear.
// rev 8 (2026-09-13): lock bar vented. The solid bar blocked the rear exit of the 17 mm gap between the Sparks; it now has a row of windows across that band, the 3 mm lips that retain the Sparks stay solid.
// rev 6 (2026-09-10): NO tray. Each Spark is locked in by C-channel ribs on the side walls: a bottom ledge it sits on, a top ledge over it, the lateral side ribs between. Nothing between the Sparks but air.
// rev 5 (2026-09-10, after the first full print): bezel screwed on (4 x #6-32 into the fan rails, hooks gone); lock bar screwed down (#6-32 through a handle tab into a pad on the right wall); tray underside is a flat slab (no support).
// Spec: ../docs/SPEC.md (2026-09-09). Parts: body, bezel, lockbar (rev 6: no tray). Render views at the bottom.
// Every number here is either from SPEC.md or a design choice marked (design note).
$fn = 48; eps = 0.01;

// ---- mating objects (SPEC "Mating objects") ----
sw = 150;  sl = 150;  st = 45;          // Spark body: width, depth (face->rear), thickness (measured 2026-09-05)
ped_h = 6;                              // pedestal height (jvr0x, verify)
ped_top = [128.6, 118.6];  ped_bot = [111, 101];   // pedestal flare, chassis -> desk (jvr0x, verify)
fan = 140; fan_t = 27; fan_hole = 124.5; fan_bore = 134; fan_screw = 5.2;   // P14 Pro spec sheet; hole spacing = standard 140 (verify)

// ---- design choices (design note) ----
wall  = 3;      // all walls
plen_ih = fan + 1;   // interior height 141: fan pocket + clearance (rev 4: one height end to end - simple and smooth)
IH = plen_ih;
g     = (IH - 2*st)/3;   // 17: EQUAL gap everywhere — floor, between the Sparks, ceiling, and both sides (rev 4)
rib_w = 2;      // flow-parallel ribs holding each Spark off the walls (ledge and side rib thickness)
ledge_reach = g + 6;   // (rev 6) 23: side ledges run from the wall to 6 mm under each Spark edge, 4.7 mm outside the 128.6 pedestal flare (same reach as the old rib_x)
ch_cl = 1.0;    // (rev 6) channel height = st + ch_cl: top ledge sits 1.0 above the Spark (printed rib heights stack up)
seat_t = 4;     // (rev 6b: reinforce the ledge carrying the weight) bottom ledge thickness
gus = 8;        // (rev 6b) 45 deg gusset under each bottom ledge: gus down the wall, gus out along the ledge
bezel_t = 3;    // front bezel plate
fan_cl = 0.5;   // fan pocket clearance
stop_d = 4;     // fan rear stop blocks
mix_d = 10;     // fan exhaust -> chamfer start
plen_d = bezel_t + fan_t + fan_cl + stop_d + mix_d;   // plenum depth (44.5)
r_out = 8; r_in = 5;   // outer / inner corner radii (smooth exterior)
hook_w = 10; hook_t = 1.5; hook_l = 9; barb = 1.0;   // bezel snap hooks (4)
rear_d = 10;    // room behind the Sparks for the lock bar and cables
scr_pilot = 2.9; scr_clr = 3.7; scr_x = 13.75;   // (rev 5) #6-32 screws: pilot in plastic, clearance in the part; bezel screws sit in the fan-rail centres x = 13.75 / OW-13.75
bar_t = 5; bar_lip = 3;   // lock bar: thickness, VERTICAL overlap onto each Spark's rear edge (rev 4c: bar_h derived so BOTH Sparks get the full lip; it was 20 = only 0.3 on Spark 2)
vent_w = 20; vent_strut = 3; vent_m = 1.0;   // (rev 8) lock bar vent windows: width, strut between windows, solid margin kept above/below the window inside the inter-Spark gap (windows are vent_h = g - 2*vent_m = 15 tall; lips stay solid)
bar_gap = 0.5;  // slot starts this far behind the Spark rears (bar face 0.8 behind them: fore-aft play, spec L5 "held tight")
stop_h = 3;     // front stop tabs on the rib ends

// ---- derived ----
IW = sw + 2*g;                 // interior width 184
OW = IW + 2*wall;              // 190
OH = IH + 2*wall;              // body outer height 147, front to rear
PH = OH;                       // (plenum outer height = body height)
ch = 0;                        // no chamfer any more
z_floor = wall;
stack_h = st + g + st;   // (rev 6) Spark 1 + air gap + Spark 2 = 107
z_s1 = wall + (IH - stack_h)/2;  // Spark 1 body bottom = wall + g (20); pedestal hangs in the floor gap
gb = z_s1 - z_floor;           // floor gap = g (floor ribs this tall)
z_s2 = z_s1 + st + g;          // Spark 2 body bottom (rev 6: one clear gap g between the Sparks, no tray)
bar_h = (z_s2 - (z_s1 + st)) + 2*bar_lip;   // 23: spans the inter-Spark gap plus bar_lip onto each rear edge
z_ceil = OH - wall;            // ceiling underside
gt = z_ceil - (z_s2 + st);     // ceiling gap = g
y_face = plen_d;               // Spark faces at the end of the plenum
y_rear_s = y_face + sl;        // Spark rears
L = y_rear_s + rear_d;         // body length 204.5
bar_y = y_rear_s + bar_gap + 0.3; bar_z0 = z_s1 + st - bar_lip + 0.3;   // lock bar front face / bottom
pad_z0 = bar_z0 + bar_h + 1.5; pad_h = 12;   // (rev 5) screw pad above the slot
cx = OW/2; cz = OH/2;          // fan axis
side_rib_dz = [10, st - 10 - rib_w];   // side-wall ribs per Spark (above its body bottom)

// ---- opening-area check (SPEC A3: 70:30 by area) ----
a_face = 2 * sw * st;
a_floor = IW*gb - 2*(seat_t*ledge_reach + gus*gus/2);   // (rev 6b) two reinforced bottom ledges + gussets of Spark 1 lie in the floor gap
a_mid = IW*g - 2*rib_w*ledge_reach - 2*(seat_t*ledge_reach + gus*gus/2);   // (rev 6b) Spark 1 top ledges + Spark 2 reinforced bottom ledges
a_top = IW*gt - 2*rib_w*ledge_reach;
a_side = 4 * g * st - 8*rib_w*(g - 0.3);              // 8 lateral side ribs
a_gap = a_floor + a_mid + a_top + a_side;
echo(str("face area ", a_face, "  gap area ", a_gap, "  face:gap = ", round(100*a_face/(a_face+a_gap)), ":", round(100*a_gap/(a_face+a_gap))));

module wedge(x0, y0, w, d) { polygon([[x0, y0], [x0 + w, y0], [x0 + w, y0 + d], [x0, y0 + d + w]]); }   // XY profile: full width for d, then a 45 deg taper back to the wall
rib_len = L - y_face;   // (rev 4b) ribs run to the rear face so they start on the bed when the body prints rear-down
module ledge_xy(full) {   // (rev 6) side ledge plan (XY), from y_face. full: to the rear face. Otherwise (the two ledges inside the lock bar's z band) it ends at the Spark rear with a taper back into the wall, so it clears the bar slot and still prints rear-face-down without support
  if (full) translate([0, y_face]) square([ledge_reach, rib_len]);
  else polygon([[0, y_face], [ledge_reach, y_face], [ledge_reach, y_rear_s - 1.5*ledge_reach], [0, y_rear_s]]);   // taper rises 1.5x its run (56 deg): a 45 deg one failed the bridge gate on its first layer
}
module ledge(full, t = rib_w) { linear_extrude(t) ledge_xy(full); }
module seat(full) {   // (rev 6b) weight-bearing bottom ledge: seat_t thick with a 45 deg gusset underneath (XZ triangle, cut to the ledge's plan so its rear end follows the same taper). Origin = ledge top's underside corner at the wall, z up = ledge
  translate([0, 0, -seat_t]) ledge(full, seat_t);
  intersection() {
    translate([0, 0, -seat_t - gus]) linear_extrude(seat_t + gus) ledge_xy(full);
    rotate([90, 0, 0]) translate([0, 0, -L]) linear_extrude(L) polygon([[0, -seat_t - gus], [gus, -seat_t], [0, -seat_t]]);
  }
}
module tab(h, w = rib_w) { translate([0, y_face - 3, 0]) hull() { cube([w, 3, h]); cube([w, eps, h + stop_h]); } }   // front stop tab (rev 4e): the stop face is a 45 deg ramp rising from the rib top at y_face to h+stop_h at y_face-3, so rear-face-down it is self-supporting (the old square 2 x 3 mm tab made the slicer stand a 160 mm support sheet under it)
module rail_wedge(extra = 0) { wedge(wall - extra, bezel_t, cx - fan/2 - fan_cl - wall + extra, fan_t + fan_cl); }
module rrect(w, h, r) { offset(r) offset(-r) square([w, h], center = true); }

module spark(i) {   // lying flat, pedestal down, face at y_face
  z = (i == 0) ? z_s1 : z_s2;
  translate([wall + g, y_face, z]) {
    color([0.78, 0.66, 0.42]) cube([sw, sl, st]);
    color([0.55, 0.55, 0.58]) translate([sw/2, sl/2, 0]) mirror([0, 0, 1])
      hull() { linear_extrude(eps) rrect(ped_top[0], ped_top[1], 8); translate([0, 0, ped_h - eps]) linear_extrude(eps) rrect(ped_bot[0], ped_bot[1], 8); }
  }
}
module fan_model() {   // sits in the pocket behind the bezel; hub + blade disc are for the renders only
  color([0.3, 0.3, 0.32]) translate([cx - fan/2, bezel_t + fan_cl/2, cz - fan/2]) {
    difference() { cube([fan, fan_t, fan]); translate([fan/2, -1, fan/2]) rotate([-90, 0, 0]) cylinder(d = fan_bore, h = fan_t + 2); }
    translate([fan/2, 0, fan/2]) rotate([-90, 0, 0]) { cylinder(d = 45, h = fan_t); translate([0, 0, fan_t/2 - 1]) cylinder(d = fan_bore - 2, h = 2); }
  }
}

module slab(y0, y1, w, h, r) { translate([cx, y1, cz]) rotate([90, 0, 0]) linear_extrude(y1 - y0) rrect(w, h, r); }   // rounded-rect prism along Y
module shell_outer() {
  slab(bezel_t, L, OW, OH, r_out);   // one smooth prism from behind the bezel to the rear
}
module shell_inner() {
  slab(-1, L + 1, IW, IH, r_in);   // one cavity: open at the front (bezel closes it) and at the rear
}
module hook_channels() {   // through the fan rails along each side wall: hook slides in, barb drops into the groove at the end
  ch_w = hook_t + 0.4 + barb;   // (rev 4d) channel is barb deeper toward the fan so the hook can flex inward while the barb rides the wall (earlier 0.2 mm allowance was not enough)
  for (sx = [-1, 1]) for (sz = [-1, 1]) translate([cx + sx*(IW/2) - (sx > 0 ? ch_w : 0), -1, cz + sz*40 - hook_w/2 - 0.3]) {
    cube([ch_w, bezel_t + hook_l + 1.5, hook_w + 0.6]);
    translate([sx > 0 ? ch_w - 0.3 : -1.2 + 0.3, 1 + bezel_t + hook_l - 2.5 - 0.3, 0]) cube([1.2, 3.2, hook_w + 0.6]);   // barb groove 1.2 deep into the wall (+1: parent translate starts at y = -1)
  }
}
module body() {
  difference() {
    union() {
      difference() { shell_outer(); shell_inner(); }
      // fan pocket: side rails centre the fan, corner blocks behind it stop it. Both taper rearward at 45 deg
      // (rev 4b) so nothing hangs in the air when the body prints rear-face-down (the slicer had filled the cavity with support)
      for (m = [0, 1]) translate([m ? OW : 0, 0, 0]) mirror([m, 0, 0]) {
        translate([0, 0, wall]) linear_extrude(IH) rail_wedge();
        for (z0 = [cz - fan/2, cz + fan/2 - 8]) translate([0, 0, z0]) linear_extrude(8) wedge(wall, bezel_t + fan_t + fan_cl, cx - fan/2 + 8 - wall, stop_d);
      }
      translate([OW - eps, bar_y - 9, pad_z0]) cube([8 + eps, L - (bar_y - 9), pad_h]);   // (rev 6) pad starts 6 mm further forward so the teardrop pilot apex stays inside it   // (rev 5) lock bar screw pad on the outside of the right wall, above the slot
      // (rev 6) C-channels on both walls for both Sparks: bottom ledge (with a front stop ramp) the Spark sits on,
      // top ledge ch_cl above it, and the two lateral side ribs between them. All run front->rear (flow-parallel,
      // vertical fins when the body prints rear-face-down: no support). Sparks slide in from the rear.
      for (s = [0, 1], z = (s == 0 ? z_s1 : z_s2), m = [0, 1]) translate([m ? OW : 0, 0, 0]) mirror([m, 0, 0]) {
        translate([wall, 0, z]) { seat(s == 0); translate([0, 0, -seat_t]) tab(seat_t, ledge_reach); }   // (rev 6b) reinforced bottom ledge + gusset + stop (Spark 2's stops short of the lock bar)
        translate([wall, 0, z + st + ch_cl]) ledge(s == 1);   // top ledge (Spark 1's stops short of the lock bar)
        for (dz = side_rib_dz) translate([wall, y_face, z + dz]) cube([g - 0.3, rib_len, rib_w]);   // lateral ribs
      }
    }
    for (sx = [0, 1]) for (sz = [-1, 1]) translate([sx ? OW - scr_x : scr_x, -1, cz + sz*40]) rotate([-90, 0, 0]) cylinder(d = scr_pilot, h = 1 + bezel_t + 12);   // (rev 5) 4 bezel screw pilots, 12 deep into the solid fan rails
    for (x0 = [-1, OW - wall - 1]) translate([x0, y_rear_s + bar_gap, z_s1 + st - bar_lip]) cube([wall + 2, bar_t + 0.6, bar_h + 0.6]);   // lock-bar slot through BOTH walls (rev 5b: bar passes through and rests flush with the left face)
    translate([OW + 4, bar_y + 1, pad_z0 + pad_h - 10]) hull() { cylinder(d = scr_pilot, h = 11); translate([0, -scr_pilot*2, 0]) cylinder(d = 0.1, h = 11); }   // (rev 5) lock bar screw pilot, down into the pad. (rev 6) teardrop, apex toward the front = print-up when the body lies rear-face-down: the round crown failed the bridge gate (0.27 mm uncovered)
  }
}
module bezel() {   // smooth front plate: rounded profile, 2 mm edge chamfer, fan bore, 4 snap hooks into the plenum walls
  difference() {
    hull() { slab(bezel_t - 1, bezel_t, OW, PH, r_out); slab(0, 1, OW - 4, PH - 4, r_out - 2); }
    translate([cx, -1, cz]) rotate([-90, 0, 0]) cylinder(d = fan_bore, h = bezel_t + 2);
    for (sx = [0, 1]) for (sz = [-1, 1]) translate([sx ? OW - scr_x : scr_x, -1, cz + sz*40]) rotate([-90, 0, 0]) cylinder(d = scr_clr, h = bezel_t + 2);   // (rev 5) 4 screw clearance holes, no hooks
  }
}
module hooks_unused(deflect = 0) {   // (rev 5) retired, kept for reference
   // the 4 snap hooks; deflect > 0 = bent toward the fan by that much (used by chk_hook_path)
  for (sx = [-1, 1]) for (sz = [-1, 1]) translate([cx + sx*(IW/2 - 0.2 - deflect) - (sx > 0 ? hook_t : 0), bezel_t, cz + sz*40 - hook_w/2]) {
    cube([hook_t, hook_l, hook_w]);
    translate([sx > 0 ? hook_t - eps : eps, hook_l - 2.5, 0]) mirror([sx > 0 ? 0 : 1, 0, 0]) linear_extrude(hook_w) polygon([[0, 0], [barb, 0], [0, 2.5]]);   // (rev 4d) the barb IS a ramp: full depth (square retaining face) 2.5 mm from the tip, tapering to zero at the tip so it cams the hook inward
  }
}
module lockbar() {   // slides in through the right wall, behind both Sparks' rear faces
  difference() {
    union() {
      translate([0, bar_y, bar_z0]) cube([OW + 14.5, bar_t, bar_h]);   // (rev 5b) left end flush with the left outer face, through both wall slots
      translate([OW + 8.5, bar_y - 3, bar_z0 - 3]) cube([6, bar_t + 3, pad_z0 + pad_h + 0.3 + 4 - (bar_z0 - 3)]);   // (rev 5) handle block, taller: rises past the pad
      translate([OW + 0.3, bar_y - 3, pad_z0 + pad_h + 0.3]) cube([8.2 + 6, bar_t + 3, 4]);   // (rev 5) tab over the screw pad
    }
    translate([OW + 4, bar_y + 1, pad_z0 + pad_h - 1]) cylinder(d = scr_clr, h = 10);   // (rev 5) screw clearance through the tab
    bar_vents();   // (rev 8) air windows across the inter-Spark gap
  }   // handle/stop outside the wall; flush with the bar's REAR face (rev 4d) so the bar prints lying on that face
}

module assembly(show_sparks = true, show_fan = true) {
  color([0.2, 0.2, 0.22]) body(); color([0.25, 0.25, 0.28]) bezel(); color([0.8, 0.3, 0.2]) lockbar();
  if (show_sparks) for (i = [0, 1]) spark(i);
  if (show_fan) fan_model();
}
module cutaway() { difference() { assembly(); translate([cx, -100, -50]) cube([200, 400, 300]); } }
module front_open() { assembly(show_sparks = false); }

// ---- fit-gate check parts ----
module sparks() { for (i = [0, 1]) spark(i); }
module chk_spark_body()  { intersection() { sparks(); body(); } }
module chk_spark_bar()   { intersection() { sparks(); lockbar(); } }
module chk_fan_body()    { intersection() { fan_model(); body(); } }
module chk_bar_body()    { intersection() { lockbar(); body(); } }
module chk_fan_bezel()   { intersection() { fan_model(); bezel(); } }
module chk_bezel_body()  { intersection() { bezel(); body(); } }
module chk_fan_captive() { intersection() { fan_model(); translate([wall, bezel_t, wall]) cube([IW, fan_t + fan_cl, plen_ih]); } }   // NON-EMPTY: fan fully inside its pocket
module chk_hook_path()  { }   // (rev 5) no hooks any more   // EMPTY: hooks, bent inward by the barb depth, sweep the whole insertion path without hitting the rails or walls (rev 4d)
module chk_seat(i) { z = (i == 0) ? z_s1 : z_s2; intersection() { body(); translate([wall + g, y_face, z - seat_t]) cube([sw, sl, seat_t]); } }   // NON-EMPTY: ledges reach under both edges of Spark i (bbox x from the Spark side to 6 mm in, both sides)
module chk_lid(i)  { z = (i == 0) ? z_s1 : z_s2; intersection() { body(); translate([wall + g, y_face, z + st + ch_cl]) cube([sw, sl, rib_w]); } }   // NON-EMPTY: top ledges reach over both edges of Spark i
module chk_bar_covers()  { intersection() { lockbar(); translate([wall, y_rear_s, z_s1 + st - bar_lip]) cube([IW, 5, bar_h]); } }   // NON-EMPTY: bar sits right behind the Spark rears

// ---- print orientations (rear face on the bed) ----
module body_print() { rotate([-90, 0, 0]) translate([0, -L, 0]) body(); }
module bezel_print() { rotate([90, 0, 0]) bezel(); }   // front face (y = 0) down on the bed, hooks up
module bar_vents() {   // (rev 8) windows through the bar (Y) in the band between the Sparks: z from Spark 1 top + vent_m to Spark 2 bottom - vent_m, spread evenly across the interior width with vent_strut between them and at each wall
  vent_h = g - 2*vent_m;
  span = IW - 2*vent_strut;                       // usable width between the walls' inner faces minus a strut at each end
  n = floor((span + vent_strut) / (vent_w + vent_strut));
  pitch = vent_w + vent_strut;
  x0 = wall + vent_strut + (span - (n*pitch - vent_strut))/2;   // centre the row
  for (i = [0 : n - 1]) translate([x0 + i*pitch, bar_y - 1, z_s1 + st + vent_m]) cube([vent_w, bar_t + 2, vent_h]);
}
module chk_bar_vent() { difference() { translate([wall, bar_y, z_s1 + st]) cube([IW, bar_t, g]); lockbar(); } }   // NON-EMPTY: the bar does not fill the inter-Spark gap; volume = open window area x bar_t
module lockbar_print() { rotate([-90, 0, 0]) translate([0, -(y_rear_s + bar_gap + 0.3 + bar_t), 0]) lockbar(); }   // (rev 4d) rear face down: the whole 199 x 23 face is on the bed (was standing on the handle with the bar 3 mm in the air)

part = "assembly";
if (part == "assembly") assembly();
else if (part == "cutaway") cutaway();
else if (part == "body") body_print();
else if (part == "lockbar") lockbar_print();
else if (part == "bezel") bezel_print();
else if (part == "bezel_view") bezel();
else if (part == "front_open") front_open();
else if (part == "fan_view") fan_model();
else if (part == "body_view") body();
else if (part == "chk_spark_body") chk_spark_body();
else if (part == "chk_seat0") chk_seat(0);
else if (part == "chk_seat1") chk_seat(1);
else if (part == "chk_lid0") chk_lid(0);
else if (part == "chk_lid1") chk_lid(1);
else if (part == "chk_spark_bar") chk_spark_bar();
else if (part == "chk_fan_body") chk_fan_body();
else if (part == "chk_bar_body") chk_bar_body();
else if (part == "chk_bar_covers") chk_bar_covers();
else if (part == "chk_bar_vent") chk_bar_vent();
else if (part == "chk_hook_path") chk_hook_path();
else if (part == "chk_fan_bezel") chk_fan_bezel();
else if (part == "chk_bezel_body") chk_bezel_body();
else if (part == "chk_fan_captive") chk_fan_captive();
