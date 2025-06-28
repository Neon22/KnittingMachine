include<params.scad>;
//include<needlebed.scad>;

// Really these are the holes the screws go into
module screwHoles(xpos=gauge) {
    // positions
    screw_x = -xpos/2;
    front_screw_y = -BACK_COVER + 5;
    back_screw_y = -5;
    spongebar_screw_y = SPONGE_BAR/2 - NEEDLE_BED_DEPTH + COMB;
    // spongebar screw 
    color("Gold") {
    translate([screw_x, spongebar_screw_y, railHeight/2+1])
        Screw1(extra_length=12);  // drill all way through
        // back screw, back cover
        translate([screw_x, back_screw_y, -3])
            Screw2(extra_length=10);
        translate([screw_x, front_screw_y, -3])
            Screw2(extra_length=10);
    }

    // heights
    //screw_height = needleBedHeight*2 + 1;
    //screw_head_height = screwHeadHeight*2 + tolerance;
    // screw resolution
    //screw_res = 25;
    
    // "screw" is passed in during the loop to place holes at either end of the assembly
    //if (screw > 0) {  // left half
        // ORIG
        // spongebar screw
    //    translate([screw_x, spongebar_screw_y, 0]) {
    //        cylinder(h = screw_height, d = screwDiamSm, center = true, $fn=screw_res); 
    //        translate([0,0,railHeight]) 
    //            cylinder(h = screw_head_height, d = screwHeadDiamSm, center = true, $fn=screw_res);
    //    }
        // back screw, back cover
    //    translate([screw_x, back_screw_y, 0]) {
    //        cylinder(h = screw_height, d = screwDiamSm, center = true, $fn=screw_res);
    //        cylinder(h = screw_head_height, d = screwHeadDiamSm, center = true, $fn=screw_res);   
    //    }    
        // front screw, back cover
    //    translate([screw_x, front_screw_y, 0]) {
    //        cylinder(h = screw_height, d = screwDiamSm, center = true, $fn=screw_res);  
    //        cylinder(h = screw_head_height, d = screwHeadDiamSm, center = true, $fn=screw_res);   
    //    }
    //}
}


module needleBedScrews(count=numNeedles, xpos=gauge) {
    for(i = [0:count-1])
        if (i==screwPlacement || i==count-screwPlacement)
            translate([xpos*i, 0, 0])
                screwHoles(xpos);
}


// for testing
needleBedScrews();
