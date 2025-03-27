include<../modules/params.scad>;
include<../modules/camplate_coords_mk2.scad>;
include<../modules/utils.scad>;
//include<../modules/camPinHoles.scad>;


module tCam() {
    // adjustable tension cams
	color("PeachPuff")
    difference() {
		linear_extrude(height=camHeight - (camClearance + tolerance), convexity=2)
			import("../../SVG/TCam_mk2.svg");
        //
        translate([nutCoords[0] - tCamCoords[0], nutCoords[1] - tCamCoords[1], camHeight - (1 + tolerance*2) - nutHeight])
		linear_extrude(height=nutHeight + tolerance*2 + 1, convexity=2)
			import("../../SVG/Hex_mk2.svg");    
    }
}

module tPivot(tol=0, solid=false) {
    // pivot 
    color("PeachPuff")
	difference() {
        cylinder(camPlateHeight + 3, d=8 + tol , center=true, $fn=cylres50);
        if(solid) {
            translate([0,0,camPlateHeight/2])
				cylinder(camPlateHeight, d = screwDiamSm , center=true, $fn=cylres50);
        }
    }
}


// build one
module build_a_tCam() {
	translate(tCamCoords)
		tCam();
	//
	translate(tPivotCoords)
		tPivot(solid = true);
}

module build_tCams() {
	// build 2, mirrored
	build_a_tCam();
	mirror([1,0,0])
		build_a_tCam();
}


// 
build_tCams();