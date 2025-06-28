include<params.scad>;

module carriageScrews() {
    // attach to back of camplate
    x_offset_1 = 10.5; // dist from left edge
    y_offset_1 = -6;   // dist from rear edge
    zpos_1 = camHeight + camPlateHeight/2 + 6;  // clear the front plate top
    color("Gold")
    translate([0, y_offset_1, zpos_1]) {
        translate([x_offset_1, 0, 0])
            Screw3(extra_length=8);
        translate([CAM_PLATE_WIDTH/2, 0, 0])
            Screw3(extra_length=8);
        translate([CAM_PLATE_WIDTH-x_offset_1, 0, 0])
            Screw3(extra_length=8);
    }
    // attach Yarncarrier cover to front of camplate
    y_offset_2 = COMB - NEEDLE_BED_DEPTH + 6;  // dist from front edge
    color("Gold")
    translate([0, y_offset_2, zpos_1]) {
        translate([x_offset_1, 0, 0])
            Screw3(extra_length=3);
        translate([CAM_PLATE_WIDTH/2, 0, 0])
            Screw3(extra_length=3);
        translate([CAM_PLATE_WIDTH-x_offset_1, 0, 0])
            Screw3(extra_length=3);
    }
    // attach stripper plate 
    // this spot is tiny so we need to use smaller (#4) screws for this!
    x_offset_3 = 8.5;  // dist from left edge
    ypos_3 = 0.25 - (NEEDLE_EXTENSION + camPlateHeight + NEEDLE_BED_DEPTH);
    zpos_3 = 4.5;  // dist to get inset on top
    gap = 35;
    color("Gold")
    translate([0, ypos_3, zpos_3]) {
        translate([x_offset_3, 0, 2])
            Screw2();
        translate([x_offset_3+35, 0, 2])
            Screw2(); 
        translate([CAM_PLATE_WIDTH - x_offset_3, 0, 2])
            Screw2();
        translate([CAM_PLATE_WIDTH - x_offset_3-35, 0, 2])
            Screw2();
        }       
    // attach yarn feeder plate from underneath
    ypos_4 = -(NEEDLE_BED_DEPTH - COMB/2);
    x_offset_4 = 10.5;
    color("Gold")
    translate([0, ypos_4, gauge]) {
        // LHS pair
        translate([x_offset_4, 0, 0.5])
        rotate([0,180,0])
            Screw2();
        translate([x_offset_4 + gap, 0, 0.5])
        rotate([0,180,0])
            Screw2();
        // RHS pair
        translate([CAM_PLATE_WIDTH - x_offset_4, 0, 0.5])
        rotate([0,180,0])
            Screw2();
        translate([CAM_PLATE_WIDTH - x_offset_4 - gap, 0, 0.5])
        rotate([0,180,0])
            Screw2(); 
    }          
}


carriageScrews();