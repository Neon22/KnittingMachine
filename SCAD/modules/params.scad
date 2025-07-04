
use <screws.scad>
/*

Values in `camelCase` are user-variable (within reason); 
values like numNeedles and screwDiam, etc.,  can be modified to
accommodate user preference or hardware subsitution. 

Values in `ALL_CAPS` should be considered CONSTANTS and should
only be modified with *extreme caution* as they will affect the 
relationship between the needles and the cams, which could
prevent stitches from forming correctly.

I recommend only modifying these constants if you are also 
making changes to the cam design in the technical sketch.
*/

// sphere and cylinder facet counts
$fn = 50;
cylres30 = 30;  // roundedrail
cylres25 = 25;  // connector
cylres50 = 50;  // yarnfeeder, 
cylres100 = 100;  // Yarnfeeder

STANDARD_GAUGE = 4.5;
MID_GAUGE = 6.5;
BULKY_GAUGE = 9.0;

gauge = STANDARD_GAUGE; // I recommend using one of the predefined gauges above
numNeedles = 25;
tolerance = 0.2; // allows a bit of room for parts that have to fit together; adjust according to your printer's precision

// ---
// Hardware dimensions 
// (actual measurements, no tolerances)

// - pan head 6-32 machine screws
screwDiam = 3.45;
screwHeight = 18;
screwHeadDiam = 6.75 + tolerance * 2; 
screwHeadHeight = 2.55 + tolerance * 2;
nutWidth = 7.9;

// - pan head 4-40 machine screws (M3 should also work where these are used)
screwDiamSm = 2.79;
screwHeightSm = 14.62;
screwHeadHeightSm = 2.41 + tolerance * 2;
screwHeadDiamSm = 5.21 + tolerance * 2;
nutHeight = 2.8;

// ---
// Needle dimensions
// - Brother needles
BUTT_HEIGHT = 15;
NEEDLE_WIDTH = 1.25;
NEEDLE_LEG_HEIGHT = 1.85;
HOOK_DIAM = 3.5;

// ---
// Needle Bed Zones
BACK_COVER = 45;
OOW_TRACK = 8;
B_TRACK = 42; // will divvy up working tracks (B & C position) later
C_TRACK = 0;
WORKING_TRACK = B_TRACK + C_TRACK;
HOLD_TRACK = 8;
SPONGE_BAR = 12;
COMB = 29;
NEEDLE_EXTENSION = 34.5;

// ---
// Needle bed dimensions
NEEDLE_BED_DEPTH = BACK_COVER + OOW_TRACK + WORKING_TRACK + HOLD_TRACK + SPONGE_BAR + COMB;
needleBedHeight = screwHeight + 2;
needleSlotHeight = NEEDLE_LEG_HEIGHT * 2 + screwHeadHeight;
needleSlotWidth = NEEDLE_WIDTH + 0.25; // add a small amount of clearance
combWidth = gauge*2/3; // width of cutouts for stitch formation; this gives room for the thickness of the yarn looped around the needle when it pulls back into the slot, but has to balance leaving enough material for the remaining "teeth" to not be too fragile
spongeThickness = 2.5;
spongeBarThickness = needleSlotHeight - NEEDLE_LEG_HEIGHT - spongeThickness;
YARN_DEPOSIT_Y = -155.1;
YARN_DEPOSIT_Z = -needleSlotHeight + HOOK_DIAM;
connectorOffset = 20;

screwPlacement = 3; // how many needles from edge of bed; min 2, max floor(numNeedles/2)

// ---
// Carriage dimensions
// refer to technical sketch
camHeight = BUTT_HEIGHT; // thickness of the tracks the needles ride along
camPlateHeight = 4; // plate behind the cams
CAM_PLATE_WIDTH = 91 * 2; 
CAM_PLATE_DEPTH = NEEDLE_BED_DEPTH - COMB + 6;

railDepth = 8;
railHeight = 8; // ???
xOffset = 16.5;
//vCamScrews = [[34-xOffset, -90.25, 0],[58-xOffset, -74.25, 0],[86-xOffset,-90.25, 0]];

// Screw selection:
// Needlebed Spongebar (4-40 x 3/4in long)
module Screw1(extra_cap=2, extra_length=0) {
    screw_4_40_A(extra_cap, extra_length);
    }

// Carriage plate (smaller 1/2in long)
module Screw2(extra_cap=1, extra_length=0) {
    screw_4_40_B(extra_cap, extra_length);
    }

// Carriage stripper plate (smaller 1/4in long)
module Screw4(extra_cap=1, extra_length=0) {
    screw_4_40_C(extra_cap, extra_length);
    }

// Carriage screws and Carriage rest (6-32 x 1/2in (12mm))
module Screw3(extra_cap=1, extra_length=0) {
    screw_6_32_A(extra_cap, extra_length);
    }






