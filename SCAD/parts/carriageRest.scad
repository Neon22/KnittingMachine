include<../modules/params.scad>;
use<../parts/needleBed.scad>;
use<../parts/backCover.scad>;
use<../parts/spongeBar.scad>;
use<../modules/connector.scad>;

/* [Parameters] */
// Knitting machine Bed Size
gauge = 4.5;  // [4.5:STANDARD_GAUGE, 6.5:MID_GAUGE, 9.0:BULKY_GAUGE]
// Number of Needles
numNeedles = 25;
// 3D printer slop margin
tolerance = 0.2;
Show_clamp = true;
// Rotate for printing
orientation = false;

/* [Clamp] */
clampWidth = 50;
clampThickness = 6;
// Table Thickness
clampHollow = 85;
clampDepth = NEEDLE_BED_DEPTH - clampWidth/2;
/* [Hidden] */

//
module carriageRest() {
    union() {
        difference() {
            // round corners of needleBase
            hull() {  // build a single needlebed and hull to widen
                needleBase();   
                translate([-CAM_PLATE_WIDTH, -10, -needleBedHeight/2])
                    cylinder(needleBedHeight, 10, 10, center=true, $fn=cylres50); 
                
                translate([-CAM_PLATE_WIDTH, -NEEDLE_BED_DEPTH+10, -needleBedHeight/2])
                    cylinder(needleBedHeight, 10, 10, center=true, $fn=cylres50); 
            }
            // subtract angled front
            for(i = [0:ceil(CAM_PLATE_WIDTH/gauge)]) {
                translate([-gauge*i, 0, 0])
                    frontAngle(CAM_PLATE_WIDTH + 10);
            }
            // cutout for clamp
            translate([-CAM_PLATE_WIDTH/2, -NEEDLE_BED_DEPTH, -needleBedHeight])
                cube([clampWidth, clampDepth*2, clampThickness*2], center = true); 
            // screws
            clampScrews();
        }
        // front and rear rails
        translate([gauge/2-CAM_PLATE_WIDTH/4,0,0]) {
            frontRail(CAM_PLATE_WIDTH/2, rounded = true);
            backRail(CAM_PLATE_WIDTH/2, rounded = true);
       }
    }
}

// clamp screws
module clampScrew(side=1) {
    xpos = side * clampWidth/2 + side*-1 * screwHeadDiam*1.5;
    color("Gold")
    translate([xpos, 0, 3])
    rotate([0,180,0])
        Screw3();
}

// screwholes for clamp
module clampScrews() {
    translate([-CAM_PLATE_WIDTH/2, 0, -needleBedHeight]) {
        translate([0, -(NEEDLE_BED_DEPTH-clampWidth), 0])
        for (side = [1,-1])
            clampScrew(side);
        translate([0, -clampWidth*2/3, 0])
        for (side = [1,-1])
            clampScrew(side);
    }
}

module clampUnit() {
    // top section
    difference() {
        // top
        translate([-CAM_PLATE_WIDTH/2 , -NEEDLE_BED_DEPTH + clampDepth/2, -needleBedHeight + clampThickness/2])
            cube([clampWidth - tolerance*2, clampDepth - tolerance, clampThickness-tolerance], center=true); 
        // subtract screw holes
        clampScrews();
        // angle front plate
        translate([-CAM_PLATE_WIDTH/2 - gauge, 0, 0])
        scale([1.1,1,1])
            frontAngle(CAM_PLATE_WIDTH + 10);
    }
    // front section
    hull () {
        translate([-CAM_PLATE_WIDTH/2 , -NEEDLE_BED_DEPTH + clampThickness/2 + 12, -(needleBedHeight - tolerance) - clampHollow/2]) {
            cube([clampWidth - tolerance*2, clampThickness, clampHollow], center=true);
            // rounded front edge
            translate([0,0,-(clampHollow + clampThickness)/2])
            rotate([0,90,0])
                cylinder(clampWidth - tolerance*2, d = clampThickness, center=true, $fn=cylres25);
        }  
    }
    // bottom section
    difference() {
        // bottom plate
        zpos =  -(needleBedHeight - tolerance) - clampHollow - clampThickness/2;
        translate([-CAM_PLATE_WIDTH/2, -NEEDLE_BED_DEPTH + clampDepth/2 +  clampThickness/2, zpos])
            cube([clampWidth - tolerance*2, clampDepth - 25, clampThickness], center=true);
        // Nut hole
        translate([-CAM_PLATE_WIDTH/2, -clampWidth*2/3 - 18, zpos]) {
            // bolt hole
            cylinder(h = clampThickness*2, d = 8, center=true, $fn=cylres25);
            // nut cutout
            translate([-14.491/2,-12.55/2,clampThickness/2]) // use w/h specs from svg
            linear_extrude(6.75, center = true)
                import("../../SVG/HexNut.svg");
        }        
    }
}

module build_carriage_rest () {
    // Left side carriage
    union() {
        translate([-gauge, 0, 0])
            carriageRest();
        // Connectors
        translate([-gauge/2, -connectorOffset, -needleBedHeight])
            connector(tolerance = tolerance);
        translate([-gauge/2, -(NEEDLE_BED_DEPTH-connectorOffset), -needleBedHeight])
            connector(tolerance = tolerance);
    }
    // Right side carriage
    difference() {
        translate([gauge*numNeedles, 0, 0])
        mirror([1,0,0])
            carriageRest();
        // Connectors
        translate([gauge*numNeedles - gauge/2 - tolerance, -connectorOffset, -needleBedHeight-tolerance])
            connector();
        translate([gauge*numNeedles - gauge/2 - tolerance, -(NEEDLE_BED_DEPTH-connectorOffset), -needleBedHeight - tolerance])
            connector();
    }
}

build_carriage_rest();

// Clamps
if (Show_clamp)
    if (orientation)
        translate([CAM_PLATE_WIDTH,CAM_PLATE_WIDTH,-CAM_PLATE_WIDTH/2])
        rotate([0,90,0])
            clampUnit();
    else 
        translate([-gauge,0,0])
            clampUnit();
