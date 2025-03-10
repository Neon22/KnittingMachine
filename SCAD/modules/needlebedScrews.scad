include<params.scad>;
//include<needlebed.scad>;

// Really these are the holes the screws go into
module screwHoles(screw) {
	// screw is +/-1 depending on left or right side
    
	// positions
    screw_x = gauge/2;
	front_screw_y = -BACK_COVER + 5;
	back_screw_y = -5;
	spongebar_screw_y = -(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2;//SPONGE_BAR/2 - NEEDLE_BED_DEPTH-COMB;
	// heights
	screw_height = needleBedHeight*2 + 1;
	screw_head_height = screwHeadHeight*2 + tolerance;
	// screw resolution
	screw_res = 25;
	
    // "screw" is passed in during the loop to place holes at either end of the assembly
    if (screw > 0) {  // left half
		// spongebar screw
		translate([screw_x, spongebar_screw_y, 0]) {
			cylinder(h = screw_height, d = screwDiamSm, center = true, $fn=screw_res); 
			translate([0,0,railHeight]) 
				cylinder(h = screw_head_height, d = screwHeadDiamSm, center = true, $fn=screw_res);
		}
		// back screw, back cover
		translate([screw_x, back_screw_y, 0]) {
			cylinder(h = screw_height, d = screwDiamSm, center = true, $fn=screw_res);
			cylinder(h = screw_head_height, d = screwHeadDiamSm, center = true, $fn=screw_res);   
		}    
		// front screw, back cover
		translate([screw_x, front_screw_y, 0]) {
			cylinder(h = screw_height, d = screwDiamSm, center = true, $fn=screw_res);  
			cylinder(h = screw_head_height, d = screwHeadDiamSm, center = true, $fn=screw_res);   
		}
	}
     
	if (screw < 0) {  // right half
		// spongebar screw
		translate([-screw_x, spongebar_screw_y, 0]) {
			cylinder(h = screw_height, d = screwDiamSm, center = true, $fn=screw_res); 
			translate([0,0,railHeight]) 
				cylinder(h = screw_head_height, d = screwHeadDiamSm, center = true, $fn=screw_res);
		}
		// back screw, back cover
		translate([-screw_x, back_screw_y, 0]) {
			cylinder(h = screw_height, d = screwDiamSm, center = true, $fn=screw_res);
			cylinder(h = screw_head_height, d = screwHeadDiamSm, center = true, $fn=screw_res);   
		}    
		// front screw, back cover
		translate([-screw_x, front_screw_y, 0]) {
			cylinder(h = screw_height, d = screwDiamSm, center = true, $fn=screw_res);  
			cylinder(h = screw_head_height, d = screwHeadDiamSm, center = true, $fn=screw_res);   
		}
	}
}


module needleBedScrews(count=numNeedles) {
    for(i = [0:count-1]) {
        if (i==screwPlacement || i==count-screwPlacement) {
			translate([gauge*i, 0, 0])
				screwHoles(screw = -1); 
        } else if (i == screwPlacement - 1 || i==count-(screwPlacement + 1)) {
			//LS screw holes
			translate([gauge*i, 0, 0])
				screwHoles(screw = 1);  
        }
    }
}

// for testng
//screwHoles(screw = 1); // left side
needleBedScrews();
