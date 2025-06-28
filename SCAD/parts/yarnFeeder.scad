include<../modules/params.scad>;
use<../modules/carriageScrews.scad>;

/* [Parameters] */

// 3D printer slop margin
tolerance = 0.2;
// Rotate for printing
orientation = false;

module yarnFeeder() {
    // yarn guide
    translate([0, YARN_DEPOSIT_Y, YARN_DEPOSIT_Z + 1.5 + tolerance])
    rotate([0,0, -90 + 15])
    rotate_extrude(convexity=4, $fn=cylres100)
    translate([3, 0, 0])
    // cone
    hull() {
        circle(r = 1.5, $fn=cylres100);
        translate([6,6,0])
            circle(r = 1.5, $fn=cylres100);
    }
}

// The gap in the unit for yarn to go through
module yarnSlot() {
    translate([CAM_PLATE_WIDTH/2, YARN_DEPOSIT_Y-15, 0])
        cube([1.5,30,20], center=true);
}

module yarnFeederPlate() {
    plate_depth1 = NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight*1.5;
    plate_depth2 = NEEDLE_BED_DEPTH - COMB + 6 + tolerance;
    plate_width = 55;
    camplate_z = camPlateHeight/2;
    camplate_halfwidth = CAM_PLATE_WIDTH/2;
    difference() {
        translate([0,0,2])
        color("orange") {
            union() {
                translate([plate_width/2, YARN_DEPOSIT_Y + 2 + tolerance, camplate_z])
                    cube([plate_width, plate_depth1-plate_depth2, camPlateHeight], center=true);
                translate([CAM_PLATE_WIDTH - plate_width/2, YARN_DEPOSIT_Y + 2 + tolerance, camplate_z])
                    cube([plate_width, plate_depth1-plate_depth2, camPlateHeight], center=true);
                // central plate
                hull() {
                    translate([camplate_halfwidth, -(NEEDLE_BED_DEPTH - COMB + 11 + tolerance), camplate_z])
                        cube([camplate_halfwidth, 10, camPlateHeight], center=true);
                    translate([camplate_halfwidth, YARN_DEPOSIT_Y, camplate_z])
                        cylinder(h=camPlateHeight, d=25 , center=true, $fn=cylres50);
                }
            }
        }
        // hole for yarnfeeder
        translate([camplate_halfwidth, YARN_DEPOSIT_Y, 2])
            cylinder(h=5*2, d=19 , center=true);
    }
}

//
module build_yarn_feeder() {
    difference() {
        // The plate
        union() {
            yarnFeederPlate();
            // cone
            translate([CAM_PLATE_WIDTH/2, 0, 0])
                yarnFeeder();
        }
        // subtract the slot
        yarnSlot();
        // and the screw holes
        carriageScrews();
    }
}

if (orientation)
    rotate([180,0,0])
        build_yarn_feeder();
else
    build_yarn_feeder();
