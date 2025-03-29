include<../modules/params.scad>;
use<../modules/carriageScrews.scad>;
use<../parts/stripperPlate.scad>;


module yarnCarrierCover() {
    roundedge_y = -(NEEDLE_BED_DEPTH - COMB + 6 + tolerance + camPlateHeight/2);
    // main screw tab
    hull() {
        translate([0,-(NEEDLE_BED_DEPTH - COMB + 6),camHeight + camPlateHeight])
            cube([CAM_PLATE_WIDTH, SPONGE_BAR + 6, camPlateHeight]);
        // rounded edge
        translate([CAM_PLATE_WIDTH/2, roundedge_y, camHeight + camPlateHeight * 1.5])
        rotate([0,90,0])
            cylinder(CAM_PLATE_WIDTH, d=camPlateHeight, center=true, $fn=cylres30);
    }
    // build slope by hulling between three pieces
    hull() {
        // overhang
        translate([0,-(NEEDLE_BED_DEPTH),2])
            cube([CAM_PLATE_WIDTH, COMB - 6 - tolerance, camPlateHeight]);
        // rounded edge
        translate([CAM_PLATE_WIDTH/2, roundedge_y, camHeight + camPlateHeight * 1.5])
            rotate([0,90,0])
            cylinder(CAM_PLATE_WIDTH, d=camPlateHeight, center=true, $fn=cylres30);
        // flat nose edge
        translate([CAM_PLATE_WIDTH/2, -(NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight), camPlateHeight/2 + 2.25])
            cube([CAM_PLATE_WIDTH, camPlateHeight, camPlateHeight+1], center=true);
    }
}

module build_yarn_carrier_cover() {
    color("orchid", 0.5)
    difference() {
        yarnCarrierCover();
        // subtract cutout
        yarnCarrierCutout();
        // trim bottom of plate
        translate([CAM_PLATE_WIDTH/2, YARN_DEPOSIT_Y + 2 + tolerance, camPlateHeight/2 + 1])
            cube([CAM_PLATE_WIDTH + 2, (NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight*1.5)-(NEEDLE_BED_DEPTH - COMB + 6 + tolerance) + 2, camPlateHeight + 2], center=true);        
        // subtract holes
        carriageScrews();
    }
}


build_yarn_carrier_cover();