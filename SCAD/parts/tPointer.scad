include <../modules/camplate_coords_mk2.scad>;

/* [Parameters] */

// Rotate for printing
orientation = false;


module tPointer() {
	color("PeachPuff")
    difference() {
		translate(tPointerCoord)
		linear_extrude(height=2, convexity=2)
			import("../../SVG/TPointer.svg");
		// TODO: this hole needs to match the one in tPivot so it should probably be extracted to a reusable module or something    
		translate(tPivotCoords)
			cylinder(camPlateHeight*4, d = screwDiamSm, center = true, $fn = 20);
    }
}


// build it
if (orientation) {
	translate([-40,-40,0])
	rotate([0,0,120])
		tPointer();
	translate([-10,-40,0])
	rotate([0,0,120])
		tPointer();
} else {  // non printing
	rotate([0,0,0])
		tPointer();
	translate([158,-61.5,0])
	rotate([0,0,-120])
	translate([-25,60,0])
		tPointer();
}