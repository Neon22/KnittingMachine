include<../modules/params.scad>;
use<../modules/needlebedScrews.scad>;
use<../modules/roundedRail.scad>;

/* [Parameters] */

// Knitting machine Bed Size
gauge = 4.5;  // [4.5:STANDARD_GAUGE, 6.5:MID_GAUGE, 9.0:BULKY_GAUGE]
// Number of Needles
numNeedles = 25;
// 3D printer slop margin
tolerance = 0.2;
// Rounded ends
Rounded = true;  // [true,false]

/* [Hidden] */


module backCover(width=gauge) { 
    translate([0,-BACK_COVER/2, -((screwHeadHeight + 1) - tolerance)/2])
        cube([width, BACK_COVER - tolerance, (screwHeadHeight + 1) - tolerance], center=true);
}

module backRail(width=gauge, rounded=false, tolerance=tolerance) {
    translate([0,-BACK_COVER/2, railHeight/2]) {
        if (rounded) {
            roundedRail(width, railDepth - tolerance*2, railHeight);
        } else {
            cube([width, railDepth - tolerance*2, railHeight], center=true);
        }
    }
}

//
module build_backCover(round_ends=true) {
    difference() {
        translate([gauge*numNeedles/2 - gauge/2, 0, 0])
            backCover(width = numNeedles*gauge);
        // subtract screw holes
        needleBedScrews(numNeedles, gauge);
    }
    // add backrail
    translate([(gauge*numNeedles)/2 - gauge/2, 0, 0]) 
        backRail(width=numNeedles * gauge, rounded=round_ends);
}

build_backCover(Rounded);