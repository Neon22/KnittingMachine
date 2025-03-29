include<../modules/params.scad>;
use<../modules/carriageScrews.scad>;

module stripperPlate() {
    color("DodgerBlue")
    hull() {
        // outer L
        translate([-CAM_PLATE_WIDTH/2, NEEDLE_EXTENSION-4, -camPlateHeight])
            sphere(d=camPlateHeight/2, $fn=cylres50);
        
        // mid L
        translate([-camPlateHeight * 2.5, NEEDLE_EXTENSION-camPlateHeight/2, -camPlateHeight])
            sphere(d=camPlateHeight/2, $fn=cylres50);
        
        // inner L
        translate([-camPlateHeight * 1.5 - 0.5, NEEDLE_EXTENSION-camPlateHeight * 1.5 -2, -camPlateHeight])
            cylinder(h=camPlateHeight/2, d=camPlateHeight*3, center=true, $fn=cylres50);
        
        // front rounded edge
        translate([-CAM_PLATE_WIDTH/2 + 55/2, -(camPlateHeight)/2, -(camPlateHeight + 1)/2])
        rotate([0,90,0])
            cylinder(55, d=camPlateHeight + 1, center=true, $fn=cylres30);
    }
}


module stripperPlateNose() {
    color("LightSkyBlue")
    hull () {
        // translate([0, -(camPlateHeight)/2, -(camPlateHeight + 1)/2])
        // rotate([0,90,0])
            // cylinder(CAM_PLATE_WIDTH, d = camPlateHeight + 1, center = true, $fn = 30);
        
        translate([-CAM_PLATE_WIDTH/2 + 55/2, -(camPlateHeight)/2, -(camPlateHeight + 1)/2])
        rotate([0,90,0])
            cylinder(55, d=camPlateHeight + 1, center=true, $fn=cylres25);
    
        
        // line up with front edge of yarn carrier
        translate([-CAM_PLATE_WIDTH/2 + 55/2,-(camPlateHeight + 1.5),needleSlotHeight + 2])
        rotate([0,90,0])
        cylinder(55, d=needleSlotHeight + 2.5, center=true, $fn=cylres50);
    }
}

// unused here. Used by yarnCarrierCover()
module yarnCarrierCutout() {
    hull() {
        // translate([CAM_PLATE_WIDTH/2,0,0])
            // yarnFeeder();
            
        // back
        translate([CAM_PLATE_WIDTH/2,YARN_DEPOSIT_Y,(camHeight + camPlateHeight*2)])
            cylinder(h=40, r=29, center=true, $fn=cylres100);
         
        // wide cone front   
        translate([CAM_PLATE_WIDTH/2,YARN_DEPOSIT_Y - 35,(camHeight + camPlateHeight)/2])
            cylinder(h=camHeight + camPlateHeight, d=CAM_PLATE_WIDTH - 55*2, center=true, $fn=cylres50);
                
        // small frontmost
        // translate([CAM_PLATE_WIDTH/2,YARN_DEPOSIT_Y - 35,-camPlateHeight])
            // cylinder(h = camHeight + camPlateHeight*2, r = 10, center = true);
    }
}

module half_stripper_plate() {
    difference() {
        translate([CAM_PLATE_WIDTH/2,-NEEDLE_BED_DEPTH - NEEDLE_EXTENSION - tolerance * 2,-needleSlotHeight]) {
            union() {
                stripperPlate();
                stripperPlateNose();
            }
        }
        // subtract recess for yarnfeeder plate
        translate([-1,-tolerance, -tolerance])
        translate([0,-(NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight + 2), 2])
            cube([CAM_PLATE_WIDTH + 4, camPlateHeight + 2, camPlateHeight + 2], center = false);
        //
        //yarnCarrierCutout();
        // screw oles
        carriageScrews();
    }
}

module build_stripper_plate() {
    // one side
    half_stripper_plate();
    // other side
    translate([CAM_PLATE_WIDTH, 0, 0])
    mirror([1,0,0])
        half_stripper_plate();
}


//
build_stripper_plate();
//yarnCarrierCutout();  // used by yarnCarrierCover()