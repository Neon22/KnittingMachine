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

/* [Hidden] */

module spongeBar(width=gauge) { 
	translate([0,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, -1])
		cube([width,SPONGE_BAR - tolerance*2,2], center=true);
}

module frontRail(width=gauge, rounded=false, tolerance=tolerance) {
    translate([0,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, railHeight/2]) {
        if (rounded) {
            roundedRail(width, railDepth - tolerance*2, railHeight);
        } else {
            cube([width, railDepth - tolerance*2, railHeight], center=true);
        }
    }
}


module build_spongeBar() {
	difference() {
		union() {
			translate([(gauge*numNeedles)/2 - gauge/2, 0, 0])
				frontRail(width = (numNeedles) * gauge, rounded = true);
			translate([gauge*numNeedles/2 - gauge/2, 0, 0])
				spongeBar(width = numNeedles*gauge);
		}
		// subtract holes
		needleBedScrews(numNeedles, gauge);
	}
}


build_spongeBar();


