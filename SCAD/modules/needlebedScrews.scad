include<params.scad>;

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
}


module needleBedScrews(count=numNeedles, xpos=gauge) {
    for(i = [0:count-1])
        if (i==screwPlacement || i==count-screwPlacement)
            translate([xpos*i, 0, 0])
                screwHoles(xpos);
}


// for testing
needleBedScrews();
