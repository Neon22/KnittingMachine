include<../modules/params.scad>;
use<../parts/needleBed.scad>;
use<../parts/backCover.scad>;
use<../parts/spongeBar.scad>;
use<../modules/connector.scad>;

// TODO: needs refactoring!

clampWidth = 50;
clampDepth = NEEDLE_BED_DEPTH-clampWidth/2; 
clampThickness = 6;
clampHollow = 85; // adjust this for your table thickness
Delta = 0.1;


module clampScrews() {
    // screwholes for clamp
    $fn = 50;
    translate([-CAM_PLATE_WIDTH/2,0,-needleBedHeight]) {
        translate([0,-(NEEDLE_BED_DEPTH-clampWidth),0]) {
            translate([- clampWidth/2 + screwHeadDiam*1.5, 0, 0])
            #cylinder(screwHeight*2, d = screwDiam, center = true); 
            
            translate([ - clampWidth/2 + screwHeadDiam*1.5, 0, 0])
            #cylinder((screwHeadHeight + tolerance)*2, d = screwHeadDiam, center = true); 
            
            translate([ + clampWidth/2 - screwHeadDiam*1.5, 0, 0])
            #cylinder(screwHeight*2, d = screwDiam, center = true); 
            
            translate([ + clampWidth/2 - screwHeadDiam*1.5, 0, 0])
            #cylinder((screwHeadHeight + tolerance)*2, d = screwHeadDiam, center = true); 
        }
        translate([0,-clampWidth*2/3,0]) {
            translate([- clampWidth/2 + screwHeadDiam*1.5, 0, 0])
            #cylinder(screwHeight*2, d = screwDiam, center = true); 
            
            translate([ - clampWidth/2 + screwHeadDiam*1.5, 0, 0])
            #cylinder((screwHeadHeight + tolerance)*2, d = screwHeadDiam, center = true); 
            
            translate([ + clampWidth/2 - screwHeadDiam*1.5, 0, 0])
            #cylinder(screwHeight*2, d = screwDiam, center = true); 
            
            translate([ + clampWidth/2 - screwHeadDiam*1.5, 0, 0])
            #cylinder((screwHeadHeight + tolerance)*2, d = screwHeadDiam, center = true); 
        }
    }
}

module clampUnit() {
    difference() {
        // top
        translate([-CAM_PLATE_WIDTH/2 , -NEEDLE_BED_DEPTH + clampDepth/2, -needleBedHeight + clampThickness/2])
            cube([clampWidth - tolerance*2, clampDepth - tolerance, clampThickness-tolerance], center = true); 
        clampScrews();
        for(i = [0:ceil(CAM_PLATE_WIDTH/gauge)]) {
           translate([-gauge*i, 0, 0])
           frontAngle(CAM_PLATE_WIDTH + 10);
        }
    }
    // front
    hull () {
        translate([-CAM_PLATE_WIDTH/2 , -NEEDLE_BED_DEPTH + clampThickness/2 + 12, -(needleBedHeight - tolerance) - clampHollow/2]) {
                cube([clampWidth - tolerance*2, clampThickness, clampHollow], center = true);
            
            // rounded edge
            translate([0,0,-(clampHollow + clampThickness)/2])
            rotate([0,90,0])
            cylinder(clampWidth - tolerance*2, d = clampThickness, center = true, $fn = 30);
        }  
    }
    difference() {
        // bottom
        translate([-CAM_PLATE_WIDTH/2 , -NEEDLE_BED_DEPTH + clampDepth/2 +  clampThickness/2, -(needleBedHeight - tolerance) - clampHollow - clampThickness/2 ])
        cube([clampWidth - tolerance*2, clampDepth - 25, clampThickness], center = true);
        
        
        translate([-CAM_PLATE_WIDTH/2,-clampWidth*2/3 - 18,-(needleBedHeight - tolerance) - clampHollow - clampThickness/2]) {
            // bolt hole
            cylinder(h = clampThickness*2, d = 8, center = true, $fn = 50);
            
            // nut cutout
            translate([-14.491/2,-12.55/2,clampThickness/2]) // use w/h specs from svg
            #linear_extrude(6.75, center = true)
            import("../../SVG/HexNut.svg");
        }        
    }
}

//
// module restref() {
	// adj = 1.5;
	// translate([clampWidth/4+gauge+adj,0,0])
	// translate([ -NEEDLE_BED_DEPTH + clampDepth/2,0,-needleBedHeight])
	// rotate([0,0,-90])
	// import("Ribber Mounting Bracket.stl", convexity=4);
// }

// The ribber bracket starts here
module clampBase() {
	difference() {
        // top
        translate([-CAM_PLATE_WIDTH/2 , -NEEDLE_BED_DEPTH + clampDepth/2, -needleBedHeight + clampThickness/2])
            cube([clampWidth-tolerance*2, clampDepth-tolerance, clampThickness-tolerance], center=true); 
        clampScrews();
	}
}

module plate() {
	translate([CAM_PLATE_WIDTH/2 , NEEDLE_BED_DEPTH - clampDepth/2, needleBedHeight - clampThickness/2])
		clampBase();
}

module plate2() {
	clipPos = 50;
	adj = 2;
	difference() {
		// plate
		//color("pink")
		translate([0,clipPos,0])
			plate();
		// cutting plane
		translate([(Delta-clampWidth)/2,-clampWidth-adj,-clampWidth/2])
			cube([clampWidth+Delta,clampWidth,clampWidth]);
	}
}
module mainbox() {
	boxWidth = 51.5;
	wall = 5;
	//color("red")
	translate([0,-146,-50.2])
	rotate([22.5,0,0])
	difference() {
		cube([clampWidth-tolerance, boxWidth, 56], center=true);
		// subtract interior
		translate([-wall,-0,-8])
			cube([clampWidth, boxWidth-wall*2 ,56], center=true);
		// holes
		translate([-10,0,-8])
		rotate([90,0,0])
			cylinder(h=60,d=10,center=true);
		translate([10,0,-8])
		rotate([90,0,0])
			cylinder(h=60,d=10,center=true);
	}
}

module ribber_bracket() {
	// top
	//color("red")
	translate([0,-134.5,-17])
		plate2();
	//
	//color("orange")
	rotate([45,0,0])
	translate([0,-150,101])
	mirror([1,0,0])
	rotate([0,0,180])
		plate2();
	// topbox
	//color("lightgrey")
	rotate([22.5,0,0])
	translate([0,-154,35.2])
		cube([clampWidth-tolerance,45.5,8.0], center=true);
	//mainbox
	mainbox();
}


// load stl for comparison
// translate([clampWidth+41,0,0])
	// restref();

// printing position
rotate([157.5,90,0])
translate([0,204.5,17])
	ribber_bracket();
