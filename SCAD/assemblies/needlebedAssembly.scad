include<../modules/params.scad>;
use<../parts/needleBed.scad>;
use<../parts/backCover.scad>;
use<../parts/spongeBar.scad>;
use<../parts/carriageRest.scad>;

/* 
Full bed assembly for layout and debugging
See individual files to export models
*/

/* [Parameters] */

// Knitting machine Bed Size
gauge = 4.5;  // [4.5:STANDARD_GAUGE, 6.5:MID_GAUGE, 9.0:BULKY_GAUGE]
// Number of Needles
numNeedles = 25;
// 3D printer slop margin
tolerance = 0.2;
// Show Needle bed
Show_bed = true;
Show_back_cover = true;
back_cover_rounded = true;
Show_spongebar = true;
Show_clamps = true;
/* [Hidden] */




// Show assembly
if (Show_bed) {
	build_needle_bed();
}
if (Show_back_cover) {
	color("lightblue")
		build_backCover(back_cover_rounded);
}
if (Show_spongebar) {
	color("orange")
		build_spongeBar();
}
// if (Show_clamps) {
	// color("cyan")
		// build_clamps();
// }
color("red")
translate([0,40,0])
rotate([00,0,0]) {
	text("Do not print from this file.");
	translate([0,-20,0])
	text("Assembly Visualisation only.");
	}
	
// Note:
// - Need to mod a few files to pass gauge,numNeedles through for this to work.
// - Will also need to calc widths to space if allow multiple needle beds (for small printers/large beds)