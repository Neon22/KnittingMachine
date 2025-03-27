include<../modules/params.scad>;
include<../modules/camplate_coords_mk2.scad>;
include<../modules/utils.scad>;
use<backCover.scad>;
use<spongeBar.scad>;
use<tCam.scad>;
use<../modules/carriageScrews.scad>;

/* [Parameters] */

// Rotate for printing
orientation = false;


// cut into backplate
module tSlots() {
    // curved cutout for tension adjustment screws
	linear_extrude(height=camPlateHeight + 2, convexity=2)
		import("../../SVG/TSlot.svg");
}

module backPlate() {
    color("Plum")
    difference() {
		// main plate
        translate([0,-CAM_PLATE_DEPTH,camHeight])
			cube([CAM_PLATE_WIDTH, CAM_PLATE_DEPTH, camPlateHeight]);
        // slots
        translate(tSlotCoords)
			tSlots();
        translate(flip(tSlotCoords))
        mirror([1,0,0])
			tSlots();
        // pivot holes for tCam
        translate(tPivotCoords)
			tPivot(tol = tolerance);
        translate(flip(tPivotCoords))
        mirror([1,0,0])
			tPivot(tol = tolerance);
        
        // tension adjustment marks
        translate([flip(tPivotCoords)[0], tPivotCoords[1], camHeight + camPlateHeight - 1 + tolerance]) {
            for (i = [0:2:8]) {
                mirror([1,0,0])
                rotate([0,0,360-30.06 - i*tensionAngleInc])
                translate([tensionMarksDist,0,0])               
					#cube([6,0.5,1], center = false); 
            }
        }
		// mirror marks
        translate([tPivotCoords[0], tPivotCoords[1], camHeight + camPlateHeight - 1 + tolerance]) {
            for (i = [0:2:8]) {
                rotate([0,0,360-30.06 - i*tensionAngleInc])
                translate([tensionMarksDist,0,0])
					#cube([6,0.5,1], center = false); 
            }
        } 
    }
}

module camRails() {
    color("Violet") {
		// Rearmost slot fits over backrail
        difference() {
			// solid block
            translate([0, -BACK_COVER, 0.5])
				cube([CAM_PLATE_WIDTH, BACK_COVER, camHeight]);
			// subtract LHS flange
            translate([0, -BACK_COVER/2, 0.5])
				camRailsInlet();
			// subtract RHS flange
            translate([CAM_PLATE_WIDTH, -BACK_COVER/2, 0.5])
            mirror([1,0,0])
				camRailsInlet();
			// subtract backrail
            backRail(width = CAM_PLATE_WIDTH*2 +1, tolerance = -tolerance);
        }
        // Front slot fits over backrail
        difference() {
			// solid block
            translate([0, -CAM_PLATE_DEPTH, 0.5])
				cube([CAM_PLATE_WIDTH, SPONGE_BAR + 6, camHeight]);
			// subtract LHS flange
            translate([0,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, 0.5])
				camRailsInlet();
			// subtract RHS flange
            translate([CAM_PLATE_WIDTH, -(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, 0.5])
            mirror([1,0,0])
				camRailsInlet();
			// subtract frontRail
            frontRail(width = CAM_PLATE_WIDTH*2 +1, tolerance = -tolerance);
        }
    }
}

module camRailsInlet() {
    // negative shape to round off (ease) entry to rail tracks
    difference() {
		// main block
        cube([railDepth/2,railDepth*2, camHeight + railDepth/2], center=true);
		// subtract cylinder 1
        translate([railDepth/2,railDepth - tolerance * 2, 0])
			cylinder(h=camHeight + 8, d=railDepth, center=true, $fn=cylres50);
        // subtract cylinder 3
		translate([railDepth/2,-railDepth + tolerance*2, 0])
			cylinder(h=camHeight + 8, d=railDepth, center=true, $fn=cylres50);
        // subtract cylinder 3 (top)
        rotate([90,0,0])
        translate([railDepth/2 - tolerance, camHeight - railDepth/2, 0])
			cylinder(h=CAM_PLATE_DEPTH, d=railDepth + tolerance * 2, center=true, $fn=cylres50);
    }
}

//negative shaped "rounded sides" for entire plate
module rounded_sides() {
	difference() {
		// outer block
		union() {
			translate([-camHeight/2, -CAM_PLATE_DEPTH, 0])
				cube([camHeight, CAM_PLATE_DEPTH, camHeight/2]);
			translate([CAM_PLATE_WIDTH-camHeight/2, -CAM_PLATE_DEPTH, 0])
				cube([camHeight, CAM_PLATE_DEPTH, camHeight/2]);
		}
		//subtract cylindrical edges
		// LHS rounded form
		translate([camHeight/2, -CAM_PLATE_DEPTH/2, camHeight/2])
		rotate([90,0,0])
			cylinder(h=CAM_PLATE_DEPTH, d=camHeight, center=true, $fn=cylres50);
		// RHS rounded form
		translate([CAM_PLATE_WIDTH - camHeight/2,-CAM_PLATE_DEPTH/2,camHeight/2])
		rotate([90,0,0])
			cylinder(h=CAM_PLATE_DEPTH, d=camHeight, center=true, $fn=cylres50);
	}
}

//
module build_back_plate() {
	color("Plum")
	difference() {
		union() {
			// top plate
			backPlate();
			// front and rear rail slides
			camRails();
			// Bumpers and guides
			// front left guide
			translate(frontWallCoords)
			linear_extrude(camHeight)
				import("../../SVG/FrontWall_mk2.svg");
			// front right guide
			translate(flip(frontWallCoords))
			mirror([1,0,0])
			linear_extrude(camHeight)
				import("../../SVG/FrontWall_mk2.svg");
			// left central bumper
			translate(bumperCoords)
			linear_extrude(camHeight)
				import("../../SVG/BumperCam_mk2.svg");
			// right central bumper
			translate(flip(bumperCoords))
			mirror([1,0,0])
			linear_extrude(camHeight)
				import("../../SVG/BumperCam_mk2.svg");
			// left rear bumper
			translate(backWallCoords)
			linear_extrude(camHeight)
				import("../../SVG/BackWall_mk2.svg");
			// right rear bumper
			translate(flip(backWallCoords))
			mirror([1,0,0])
			linear_extrude(camHeight)
				import("../../SVG/BackWall_mk2.svg");
		}
		// subtract rounded sides
		rounded_sides();
		// subtract screwholes
		carriageScrews();
	}
}

//
if (orientation)
	rotate([180,0,0])
	build_back_plate();  // mk2
else
	build_back_plate();  // mk2
// camRails();
// camRailsInlet();
// rounded_sides();