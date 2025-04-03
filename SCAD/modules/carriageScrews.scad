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
    
    // ORIG
    //translate([screwHeadDiam*1.5,-6,camHeight + camPlateHeight/2]) 
    //cylinder(h= 12*2, d = screwDiam, center = true);
    
    //translate([CAM_PLATE_WIDTH/2,-6,camHeight + camPlateHeight/2]) 
    //cylinder(h= 12*2, d = screwDiam, center = true);
    
    //translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,-6,camHeight + camPlateHeight/2]) 
    //cylinder(h= 12*2, d = screwDiam, center = true);

    // attach to front of camplate
    //translate([screwHeadDiam*1.5,-(NEEDLE_BED_DEPTH - COMB - 6),camHeight + camPlateHeight/2]) 
    //#cylinder(h= 12*2, d = screwDiam, center = true);
    
    //translate([CAM_PLATE_WIDTH/2,-(NEEDLE_BED_DEPTH - COMB - 6),camHeight + camPlateHeight/2]) 
    //cylinder(h= 12*2, d = screwDiam, center = true);
    
    //translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,-(NEEDLE_BED_DEPTH - COMB - 6),camHeight + //camPlateHeight/2]) 
    //cylinder(h= 12*2, d = screwDiam, center = true);
    
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
    // ORIG
    //translate([0,-(NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight - 0.25),0]) {
        // screw hole
    //    translate([0,0,2]) {
    
    //        #translate([screwHeadDiamSm*1.5,0,0])
    //        cylinder(h= screwHeightSm, d = screwDiamSm, center = true);
            
    //        translate([screwHeadDiamSm*1.5 + 35,0,0])
    //        cylinder(h= screwHeightSm, d = screwDiamSm, center = true);
            
    //        translate([CAM_PLATE_WIDTH - screwHeadDiamSm*1.5 - 35,0,0])
    //        cylinder(h= screwHeightSm, d = screwDiamSm, center = true);
            
    //        translate([CAM_PLATE_WIDTH - screwHeadDiamSm*1.5,0,0])
    //        cylinder(h= screwHeightSm, d = screwDiamSm, center = true);
        
    //    }
        // countersink
    //    translate([0,0,6.5 + screwHeadHeight/2]) {
            
    //        translate([screwHeadDiamSm*1.5,0,0])
    //        cylinder(h= screwHeadHeightSm, d = screwHeadDiamSm, center = true);
 
    //        translate([screwHeadDiamSm*1.5 + 35,0,0])
    //        cylinder(h= screwHeadHeightSm, d = screwHeadDiamSm, center = true);

    //        translate([CAM_PLATE_WIDTH - screwHeadDiamSm*1.5 -35,0,0])
    //        cylinder(h= screwHeadHeightSm, d = screwHeadDiamSm, center = true);

    //        translate([CAM_PLATE_WIDTH - screwHeadDiamSm*1.5,0,0])
    //        cylinder(h= screwHeadHeightSm, d = screwHeadDiamSm, center = true);
    //    }
    //}         
    
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
    
    // ORIG
    //translate([0,-(NEEDLE_BED_DEPTH - COMB/2),0]) {
        
    //    translate([0,0,2 - tolerance]) {
            // screw holes
    //        translate([screwHeadDiam*1.5,0,0])
    //        cylinder(h= screwHeight-2, d = 2.8, center = false);
            
    //        translate([screwHeadDiam*1.5 + 35,0,0])
    //        cylinder(h= screwHeight-2, d = 2.8, center = false);
            
    //        translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5 - 35,0,0])
    //        cylinder(h= screwHeight-2, d = 2.8, center = false);
            
    //        translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,0,0])
    //        cylinder(h= screwHeight-2, d = 2.8, center = false);
        
        
            // countersink
    //        translate([screwHeadDiam*1.5,0,0])
    //        cylinder(h= screwHeadHeight + tolerance, d = screwHeadDiam, center = false);
 
    //        translate([screwHeadDiam*1.5 + 35,0,0])
    //        cylinder(h= screwHeadHeight + tolerance, d = screwHeadDiam, center = false);

    //        translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5 -35,0,0])
    //        cylinder(h= screwHeadHeight + tolerance, d = screwHeadDiam, center = false);

    //        translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,0,0])
    //        cylinder(h= screwHeadHeight + tolerance, d = screwHeadDiam, center = false);
    //    }
    //}              
}


carriageScrews();